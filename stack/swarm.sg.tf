/*
Security groups for the Docker Swarm stack
*/

resource "aws_security_group" "basic-server-access" {
  name        = "server-web-access"
  description = "Access NTP, HTTPS... sort of rough cut + SSH access from bastions"
  vpc_id      = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.three_bastion_cidr
  }
  egress {
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

/* SG for Docker Swarm worker nodes

Basically:
ingress 2376/TCP
7946/UDP
4789/UDP
*/
resource "aws_security_group_rule" "accept_3000" {
  security_group_id        = aws_security_group.docker-swarm-worker-sg.id
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.fox-front-sg.id
}

resource "aws_security_group" "docker-swarm-worker-sg" {
  name        = "swarm-worker-sg"
  description = "SG for Swarm Worker nodes"
  vpc_id      = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port   = 2376
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = local.three_managers_cidr
  }
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }
  egress {
    from_port   = 2376
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = local.three_managers_cidr
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    #[ var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
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
  name        = "swarm-manager-sg"
  description = "SG for Swarm Manager nodes"
  vpc_id      = "${aws_vpc.swarm_poc_vpc.id}"
  ingress {
    from_port   = 2376
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = local.three_managers_cidr
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3]
  }
  egress {
    from_port = 2376
    to_port   = 2377
    protocol  = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3]
    cidr_blocks = local.three_managers_cidr
  }
  ingress {
    from_port   = 2376
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = local.three_workers_cidr
  }
  egress {
    from_port = 2376
    to_port   = 2377
    protocol  = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3]
    cidr_blocks = local.three_workers_cidr
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
  }
  egress {
    from_port = 7946
    to_port   = 7946
    protocol  = "udp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  ingress {
    from_port = 7946
    to_port   = 7946
    protocol  = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  egress {
    from_port = 7946
    to_port   = 7946
    protocol  = "tcp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  ingress {
    from_port = 4789
    to_port   = 4789
    protocol  = "udp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
  egress {
    from_port = 4789
    to_port   = 4789
    protocol  = "udp"
    # cidr_blocks = [var.swarm_mgrs_cidr_az1, var.swarm_mgrs_cidr_az2, var.swarm_mgrs_cidr_az3, var.swarm_wkrs_cidr_az1, var.swarm_wkrs_cidr_az2, var.swarm_wkrs_cidr_az3]
    cidr_blocks = concat(local.three_managers_cidr, local.three_workers_cidr)
  }
}
