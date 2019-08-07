resource "aws_vpc" "swarm_poc_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        usage = "poc"
        project = "foxint"
    }
}

