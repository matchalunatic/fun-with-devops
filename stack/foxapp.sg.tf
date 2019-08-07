/*
SG for the frontend app (be accessed from the world, access the backend app)

*/

resource "aws_security_group" "fox-front-sg" {
  name        = "foxapp-front-sg"
  description = "SG for FoxApp front"
  vpc_id      = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port   = 3000
    to_port     = 3000
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  egress {
    from_port       = 3000
    to_port         = 3000
    security_groups = [aws_security_group.docker-swarm-worker-sg.id]
    protocol        = "tcp"
  }
}

