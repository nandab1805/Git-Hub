import boto3

# # Define your AWS credentials directly in the script (not recommended for security reasons)
aws_access_key_id = "your_aws_access_key_id"  # Replace with your actual access key ID
aws_secret_access_key = "your_aws_secret_access_key"  # Replace with your actual secret access key

# Create a session using your AWS credentials
ec2 = boto3.resource(
    'ec2',
    region_name='us-east-1',  # Replace with your region if needed
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key
)

# Define your AMI ID, key pair name, security group ID, and IAM instance profile name
ami_id = 'ami-0b4f379183e5706b9'  # Your specified AMI ID
key_name = 'key-0afbb9d5e027b7e3f'  # Your specified key pair name
security_group_id = 'sg-03e57915a15c7d452'  # Your specified security group ID
iam_instance_profile_name = 'admin'  # Update this with your actual instance profile name


t2_micro_instances = ec2.create_instances(
    ImageId=ami_id,
    InstanceType='t2.micro',
    MinCount=1,  # Launch  instances
    MaxCount=1,
    SecurityGroupIds=[security_group_id])

print("Launched t2.micro instances:", [instance.id for instance in t2_micro_instances])
