/*
Security groups for the Docker Swarm stack
*/

/* SG for Docker Swarm worker nodes

Basically:
ingress 2376/TCP
7946/UDP
4789/UDP
*/

resource "aws_security_group" "docker-swarm-worker-sg" {
  name = "swarm-worker-sg"
  description = "SG for Swarm Worker nodes"
  vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port = 2376
    to_port = 2376
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc]
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  ingress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  egress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
}

/* SG for Docker Swarm manager nodes

Basically:
2376:2377/TCP
7946/UDP
4789/UDP
*/

resource "aws_security_group" "docker-swarm-manager-sg" {
  name = "swarm-manager-sg"
  description = "SG for Swarm Manager nodes"
  vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port = 2376
    to_port = 2377
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc]
  }
  egress {
    from_port = 2376
    to_port = 2377
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc]
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  ingress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
  egress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = [var.swarm_mgrs_cidr_aza, var.swarm_mgrs_cidr_azb, var.swarm_mgrs_cidr_azc, var.swarm_wkrs_cidr_aza, var.swarm_wkrs_cidr_azb, var.swarm_wkrs_cidr_azc]
  }
}
