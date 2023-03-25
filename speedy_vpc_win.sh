# Set AWS CLI default region
$env:AWS_DEFAULT_REGION = "eu-central-1"

# Create VPC
$VPC_ID = (aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=game-vpc}]' --query 'Vpc.VpcId' --output text)

# Enable DNS support
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support '{"Value":true}'

# Enable DNS hostnames
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames '{"Value":true}'

# Create subnets
$SUBNET1_PUBLIC_ID = (aws ec2 create-subnet --cidr-block 10.0.1.0/24 --availability-zone eu-central-1a --vpc-id $VPC_ID --query 'Subnet.SubnetId' --output text)
$SUBNET1_PRIVATE_ID = (aws ec2 create-subnet --cidr-block 10.0.2.0/24 --availability-zone eu-central-1a --vpc-id $VPC_ID --query 'Subnet.SubnetId' --output text)

$SUBNET2_PUBLIC_ID = (aws ec2 create-subnet --cidr-block 10.0.3.0/24 --availability-zone eu-central-1b --vpc-id $VPC_ID --query 'Subnet.SubnetId' --output text)
$SUBNET2_PRIVATE_ID = (aws ec2 create-subnet --cidr-block 10.0.4.0/24 --availability-zone eu-central-1b --vpc-id $VPC_ID --query 'Subnet.SubnetId' --output text)

# Create Internet Gateway
$IGW_ID = (aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)

# Attach Internet Gateway to VPC
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID

# Create Route Table
$ROUTE_TABLE_ID = (aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text)

# Associate Route Table with Public Subnets
aws ec2 associate-route-table --route-table-id $ROUTE_TABLE_ID --subnet-id $SUBNET1_PUBLIC_ID
aws ec2 associate-route-table --route-table-id $ROUTE_TABLE_ID --subnet-id $SUBNET2_PUBLIC_ID

# Create route to Internet Gateway
aws ec2 create-route --route-table-id $ROUTE_TABLE_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID

# Add tags to resources
aws ec2 create-tags --resources $SUBNET1_PUBLIC_ID --tags Key=Name,Value=public-subnet-1a
aws ec2 create-tags --resources $SUBNET1_PRIVATE_ID --tags Key=Name,Value=private-subnet-1a
aws ec2 create-tags --resources $SUBNET2_PUBLIC_ID --tags Key=Name,Value=public-subnet-1b
aws ec2 create-tags --resources $SUBNET2_PRIVATE_ID --tags Key=Name,Value=private-subnet-1b
aws ec2 create-tags --resources $IGW_ID --tags Key=Name,Value=game-vpc-igw
aws ec2 create-tags --resources $ROUTE_TABLE_ID --tags Key=Name,Value=game-vpc-public-route-table
