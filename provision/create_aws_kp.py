import boto3
ec2 = boto3.resource('ec2')

try:
    f = open('/home/vagrant/provision/ec2-KP-devops06.pem')

except:
    # create a file to store the key locally
    outfile = open('/home/vagrant/provision/ec2-KP-devops06.pem','w')
    
    # call the boto ec2 function to create a key pair
    key_pair = ec2.create_key_pair(KeyName='ec2-KP-devops06')

    # capture the key and store it in a file
    KeyPairOut = str(key_pair.key_material)
    print(KeyPairOut)
    outfile.write(KeyPairOut)
    outfile.close()

finally:
    f.close()
