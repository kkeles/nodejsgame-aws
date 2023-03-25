aws ec2 create-subnet \
    --cidr-block 10.0.1.0/24 \
    --availability-zone eu-central-1a \
    --vpc-id $VPC_ID