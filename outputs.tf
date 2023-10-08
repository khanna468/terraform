output "vpc_peering_connection_id" {
    value = aws_vpc_peering_connection.assignment.id
}

output "vpcb_id" {
  value = aws_vpc.vpcb.id
}

output "vpca_id" {
  value = aws_vpc.vpca.id
}

output "vpceast_id" {
  value = data.aws_vpc.vpc.id
}

