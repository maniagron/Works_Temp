#!/bin/bash

# Set the AWS CLI profile to use
export AWS_PROFILE=my_aws_profile

# Set the region for the first server
export AWS_REGION=us-west-2

# Spin up the first server
aws ec2 run-instances --image-id ami-0c94855ba95c71c99 --count 1 --instance-type t2.micro --key-name my_key_pair --security-group-ids my_security_group --subnet-id my_subnet_id --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Server1}]'

# Set the region for the second server
export AWS_REGION=eu-west-1

# Spin up the second server
aws ec2 run-instances --image-id ami-0c94855ba95c71c99 --count 1 --instance-type t2.micro --key-name my_key_pair --security-group-ids my_security_group --subnet-id my_subnet_id --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Server2}]
