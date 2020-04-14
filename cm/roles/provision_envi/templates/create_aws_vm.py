import boto3
import sys

ec2 = boto3.resource('ec2')
ec2_client = boto3.client('ec2')

def get_instances():
    
    inst = []
    names = ['Checkbox.io', 'iTrust2', 'Monitoring']
    # get all the running resources
    instances = ec2.instances.filter(
            Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

    for instance in instances:
        ec2instance = ec2.Instance(instance.id)
        for tags in ec2instance.tags:
            if tags['Key'] == 'Name':
                inst.append( tags['Value'])
    
    return inst


def create_instance(inst):

    resp = ec2.create_instances( ImageId='ami-04b9e92b5572fa0d1', MinCount=1, MaxCount=1, InstanceType='t2.micro', KeyName='ec2-KP-devops06')
    print(resp)
    resp = resp[0]
    resp.wait_until_running()
    resp.load()
    rsrc_id = str(resp.instance_id)
    #rsrc_ip = resp.public_ip_address
    #print(resp.public_ip_address)

    allocation = ec2_client.allocate_address(Domain='vpc')
    response = ec2_client.associate_address(AllocationId=allocation['AllocationId'], InstanceId=resp.instance_id)
    

    resp = ec2_client.monitor_instances(InstanceIds = [rsrc_id])
    resp = ec2.create_tags(Resources = [rsrc_id], Tags = [{'Key':'Name', 'Value':inst}])
    #print (resp)

    ans = ec2_client.describe_instances(
    InstanceIds=[rsrc_id]
    )
    tags = ec2.Instance(rsrc_id).tags
    for t in tags:
        if(t['Key']=='Name'):
            print(t['Value'])
    print(ans['Reservations'][0]['Instances'][0]['PublicIpAddress'])


if __name__== "__main__" :
    instances = get_instances()
    names = ['Checkbox.io', 'iTrust2', 'Monitoring']
    for i in names:
        if i in instances:
            continue
        create_instance(i)


# import boto3
# from botocore.exceptions import ClientError

# ec2 = boto3.client('ec2')

# try:
#     allocation = ec2.allocate_address(Domain='vpc')
#     response = ec2.associate_address(AllocationId=allocation['AllocationId'],
#                                      InstanceId='INSTANCE_ID')
#     print(response)
# except ClientError as e:
#     print(e)