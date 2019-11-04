resource "aws_vpc" "reportingvpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "reporting-vpc"
        Terraform = true
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.reportingvpc.id}"

    tags = {
        Name = "reporting-igw"
        Terraform = true
    }
}

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "natgw" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"

    tags = {
        Name = "Reporting NAT Gateway"
        Terraform = true
    }
}

resource "aws_subnet" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.reportingvpc.id}"
    availability_zone = "${var.public_subnet_az}"
    cidr_block = "${var.public_subnet_cidr}"

    tags = {
        Name = "Reporting Public Subnet"
        Terraform = true
    }
}

resource "aws_route_table" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.reportingvpc.id}"
    route {
        cidr_block = "${var.allow_all}"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = {
        Name = "Reporting Public Subnet"
        Terraform = true
    }
}

resource "aws_route_table_association" "eu-west-2a-public" {
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    route_table_id = "${aws_route_table.eu-west-2a-public.id}"
}

resource "aws_subnet" "eu-west-2b-private" {
    vpc_id = "${aws_vpc.reportingvpc.id}"
    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "${var.private_subnet_az}"

    tags = {
        Name = "Private Subnet"
        Terraform = true
    }
}

resource "aws_route_table" "eu-west-2b-private" {
    vpc_id = "${aws_vpc.reportingvpc.id}"

    route {
        cidr_block = "${var.allow_all}"
        nat_gateway_id = "${aws_nat_gateway.natgw.id}"
    }

    tags = {
        Name = "Private Subnet"
        Terraform = true
    }
}

resource "aws_route_table_association" "eu-west-2b-private" {
    subnet_id = "${aws_subnet.eu-west-2b-private.id}"
    route_table_id = "${aws_route_table.eu-west-2b-private.id}"
}
