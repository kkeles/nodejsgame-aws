aws ec2 create-tags \
    --resources $SUBNET1_PUBLIC_ID \
    --tags Key=Name,Value=public-subnet-1a

aws ec2 create-tags \
    --resources $SUBNET1_PRIVATE_ID \
    --tags Key=Name,Value=private-subnet-1a

aws ec2 create-tags \
    --resources $SUBNET2_PUBLIC_ID \
    --tags Key=Name,Value=public-subnet-1b

aws ec2 create-tags \
    --resources $SUBNET2_PRIVATE_ID \
    --tags Key=Name,Value=private-subnet-1b

aws ec2 create-tags \
    --resources $IGW_ID \
    --tags Key=Name,Value=game-vpc-igw

aws ec2 create-tags \
    --resources $ROUTE_TABLE_ID \
    --tags Key=Name,Value=game-vpc-public-route-table