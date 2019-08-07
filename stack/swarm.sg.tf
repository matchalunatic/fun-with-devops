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
    cidr_blocks = local.three_managers_cidr
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
#[ var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  ingress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
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
    cidr_blocks = local.three_managers_cidr
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3]
  }
  egress {
    from_port = 2376
    to_port = 2377
    protocol = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3]
    cidr_blocks = local.three_managers_cidr
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "udp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  egress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  ingress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  egress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
}
