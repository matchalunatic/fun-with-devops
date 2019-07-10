provider "aws" {
    version = "~> 2.0"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

locals {
    three_azs = ["${data.aws_availability_zones.azs.names[0]}", "${data.aws_availability_zones.azs.names[1]}", "${data.aws_availability_zones.azs.names[2]}"]
    three_workers_subnets = [
        "${aws_subnet.subnet_swarm_wkr_aza.id}",
        "${aws_subnet.subnet_swarm_wkr_azb.id}",
        "${aws_subnet.subnet_swarm_wkr_azc.id}"
    ]
    three_managers_subnets = [
        "${aws_subnet.subnet_swarm_mgr_aza.id}",
        "${aws_subnet.subnet_swarm_mgr_azb.id}",
        "${aws_subnet.subnet_swarm_mgr_azc.id}"
    ]
    three_mongo_subnets = [
        "${aws_subnet.subnet_mongo_aza.id}",
        "${aws_subnet.subnet_mongo_azb.id}",
        "${aws_subnet.subnet_mongo_azc.id}"
    ]
}
