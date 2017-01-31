resource "aws_vpc" "gogs-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gogs-gw" {
  vpc_id = "${aws_vpc.gogs-vpc.id}"
}

resource "aws_route" "gogs-route" {
  route_table_id = "${aws_vpc.gogs-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gogs-gw.id}"
}

resource "aws_subnet" "gogs-subnet" {
  vpc_id = "${aws_vpc.gogs-vpc.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true
}

