resource "aws_vpc_peering_connection" "assignment" {
  peer_vpc_id   = aws_vpc.vpcb.id
  vpc_id        = aws_vpc.vpca.id
  auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
