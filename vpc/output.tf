
output "my_public_subnet_id-A" {
    value = aws_subnet.public_subnet-A.id
}
# output "my_internet_gateway_id" {
#     value = aws_internet_gateway.gw.id
# }
output "my_sg_id" {
    value = aws_security_group.sg.id
}

output "my_public_subnet_id-B" {
    value = aws_subnet.public_subnet-B.id
}
# output "alb_sg_id" {
#     value = aws_security_group.alb-sg.id
# }

output "my_vpc_id" {
    value = aws_vpc.main.id
}

