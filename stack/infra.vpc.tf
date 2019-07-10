resource "aws_vpc" "swarm_poc_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        usage = "poc"
        project = "foxint"
    }
}

