import boto3
import sys

def create_instance():
    ec2 = boto3.resource('ec2')
    # create a new EC2 instance
    for i in range(0,3):
        resp = ec2.create_instances( ImageId='ami-04b9e92b5572fa0d1', MinCount=1, MaxCount=1, InstanceType='t2.micro', KeyName='ec2-KP-devops06')
        print(resp)
        resp = resp[0]
        resp.wait_until_running()
        resp.load()
        print(resp.public_ip_address)

        
    
if __name__== "__main__" :
    create_instance()

