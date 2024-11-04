import boto3

# # Define your AWS credentials directly in the script (not recommended for security reasons)
# aws_access_key_id = "your_aws_access_key_id"  # Replace with your actual access key ID
# aws_secret_access_key = "your_aws_secret_access_key"  # Replace with your actual secret access key

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

# Launch 3 t3.medium instances with IAM role and unique names
t3_medium_instances = ec2.create_instances(
    ImageId=ami_id,
    InstanceType='t3.medium',
    MinCount=3,
    MaxCount=3,
    SecurityGroupIds=[security_group_id],
    IamInstanceProfile={'Name': iam_instance_profile_name}  # Attach IAM role
)

# Assign specific names to the t3.medium instances
t3_instance_names = ['mongodb', 'shipping', 'mysql']
for i, instance in enumerate(t3_medium_instances):
    if i < len(t3_instance_names):
        instance.create_tags(
            Tags=[
                {'Key': 'Name', 'Value': t3_instance_names[i]}
            ]
        )

# Launch 8 t2.micro instances with IAM role and unique names
t2_micro_instances = ec2.create_instances(
    ImageId=ami_id,
    InstanceType='t2.micro',
    MinCount=8,  # Launch 8 instances
    MaxCount=8,
    SecurityGroupIds=[security_group_id],
    IamInstanceProfile={'Name': iam_instance_profile_name}  # Attach IAM role
)

# Assign specific names to the t2.micro instances
t2_instance_names = ['web', 'catalogue', 'user', 'redis', 'cart', 'rabbitmq', 'payment', 'dispatch']
for i, instance in enumerate(t2_micro_instances):
    if i < len(t2_instance_names):
        instance.create_tags(
            Tags=[
                {'Key': 'Name', 'Value': t2_instance_names[i]}
            ]
        )

# Print the IDs of the launched instances
print("Launched t3.medium instances:", [instance.id for instance in t3_medium_instances])
print("Launched t2.micro instances:", [instance.id for instance in t2_micro_instances])
