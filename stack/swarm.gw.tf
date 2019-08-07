resource "aws_internet_gateway" "poc_gw" {
  vpc_id = "${aws_vpc.swarm_poc_vpc.id}"

  tags = {
    Name = "poc_gw"
  }
}

