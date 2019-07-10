/*
SG for the frontend app (be accessed from the world, access the backend app)

*/

resource "aws_security_group" "fox-front-sg" {
  name = "foxapp-front-sg"
  subnets = local.three_workers_subnets
  description = "SG for FoxApp front"
  vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port = 3000
    to_port = 3000
    cidr_blocks = local
    protocol = "tcp"
  }
}

