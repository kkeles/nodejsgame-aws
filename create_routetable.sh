aws ec2 create-route-table \
    --vpc-id $VPC_ID

aws ec2 create-route \
    --route-table-id $ROUTE_TABLE_ID \
    --gateway-id $IGW_ID \
    --destination-cidr-block 0.0.0.0/0 
