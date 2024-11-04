# Retrieve all running instances
running_instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
instance_ids = []

# Extract instance IDs
for reservation in running_instances['Reservations']:
    for instance in reservation['Instances']:
        instance_ids.append(instance['InstanceId'])

# Stop the instances
response = ec2.stop_instances(InstanceIds=instance_ids)

# Print the response
print("Stopping instances:")
for instance in response['StoppingInstances']:
    print(f"Instance ID: {instance['InstanceId']}, Current State: {instance['CurrentState']['Name']}")
