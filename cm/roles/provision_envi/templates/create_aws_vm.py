import boto3
import sys
import logging

ec2 = boto3.resource('ec2')
ec2_client = boto3.client('ec2')


def write_ini(inst):
    keypair = "/home/vagrant/.ssh/ec2-KP-devops06"
    with open('deploy.ini', 'w+') as outfile:
        for iname, iip in inst.items():
            outfile.write("[{}]\n".format(iname))
            outfile.write("{} ansible_ssh_private_key_file={} ansible_user={}\n".format(iip, keypair, "ubuntu"))
            outfile.write("[{}]\n".format(iname+":"+"vars"))
            outfile.write("ansible_ssh_common_args={}\n".format('-o StrictHostKeyChecking=no'))


def get_instances():

    inst = {}
    names = ['Checkbox.io', 'iTrust2', 'Monitoring']
    # get all the running resources
    instances = ec2.instances.filter(
            Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

    for instance in instances:
        ec2instance = ec2.Instance(instance.id)
        for tags in ec2instance.tags:
            if tags['Key'] == 'Name':
                ans = ec2_client.describe_instances(InstanceIds=[instance.id])
                if tags['Value'] in names:
                    inst[tags['Value']] = ans['Reservations'][0]['Instances'][0]['PublicIpAddress']
    return inst


def create_instance(inst):

    resp = ec2.create_instances(ImageId='ami-04b9e92b5572fa0d1', MinCount=1, MaxCount=1, InstanceType='t2.micro', KeyName='ec2-KP-devops06')
    print(resp)
    resp = resp[0]
    resp.wait_until_running()
    resp.load()
    rsrc_id = str(resp.instance_id)

    ec2.create_tags(Resources=[rsrc_id], Tags=[{'Key': 'Name', 'Value': inst}])

    ans = ec2_client.describe_instances(InstanceIds=[rsrc_id])

    iip = ans['Reservations'][0]['Instances'][0]['PublicIpAddress']
    return iip

if __name__ == "__main__":
    # get checkbox.io, iTrust, monitoring VMs IPs if present
    instances = get_instances()
    names = ['Checkbox.io', 'iTrust2', 'Monitoring']
    create_inst = []
    for i in names:
        if i in instances:
            continue
        else:
            create_inst.append(i)

    # create instance
    for i in create_inst:
        instances[i] = create_instance(i)

    # security group
    try:
        ec2_client.authorize_security_group_ingress(
            GroupId='sg-0a29706d9a6e61063',
            IpPermissions=[
                {
                    'IpProtocol': 'tcp',
                    'FromPort': 0,
                    'ToPort': 65535,
                    'IpRanges': [{'CidrIp': '0.0.0.0/0'}]
                }
            ]
        )
    except:
        logging.info("Security group configuration already exists")            

    # write instances IP in the .ini file
    write_ini(instances)
