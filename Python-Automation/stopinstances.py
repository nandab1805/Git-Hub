import boto3

# Define your AWS credentials directly in the script (for demonstration purposes)
aws_access_key_id = "your_aws_access_key_id" # Replace with your actual access key ID
aws_secret_access_key = "your_aws_secret_access_key"  # Replace with your actual secret access key

# Initialize the EC2 client
ec2 = boto3.client(
    'ec2',
    region_name='us-east-1',  # Replace with your region if needed
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key
)

# Retrieve all running instances
running_instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
instance_ids = []

# Extract instance IDs of running instances
for reservation in running_instances['Reservations']:
    for instance in reservation['Instances']:
        instance_ids.append(instance['InstanceId'])

# Stop the instances
if instance_ids:
    response = ec2.stop_instances(InstanceIds=instance_ids)

    # Print the response
    print("Stopping instances:")
    for instance in response['StoppingInstances']:
        print(f"Instance ID: {instance['InstanceId']}, Current State: {instance['CurrentState']['Name']}")
else:
    print("No running instances found to stop.")
