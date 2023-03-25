SUBNET1_PUBLIC_ID=$(aws ec2 create-subnet \
    --cidr-block 10.0.1.0/24 \
    --availability-zone eu-central-1a \
    --vpc-id $VPC_ID \
    --query 'Subnet.SubnetId' --output text)

SUBNET1_PRIVATE_ID=$(aws ec2 create-subnet \
    --cidr-block 10.0.2.0/24 \
    --availability-zone eu-central-1a \
    --vpc-id $VPC_ID \
    --query 'Subnet.SubnetId' --output text)

SUBNET2_PUBLIC_ID=$(aws ec2 create-subnet \
    --cidr-block 10.0.3.0/24 \
    --availability-zone eu-central-1b \
    --vpc-id $VPC_ID \
    --query 'Subnet.SubnetId' --output text)

SUBNET2_PRIVATE_ID=$(aws ec2 create-subnet \
    --cidr-block 10.0.4.0/24 \
    --availability-zone eu-central-1b \
    --vpc-id $VPC_ID \
    --query 'Subnet.SubnetId' --output text)