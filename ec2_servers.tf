resource "aws_security_group" "bigateway-sg" {
    name = "bigateway-sg"
    description = "Allow incoming HTTP connections."
    vpc_id = "${aws_vpc.reportingvpc.id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "PowerBISG"
        Terraform = true
    }
}

resource "aws_instance" "powerbi-data-gateway" {
    ami = "${var.windows_ami}"
    availability_zone = "${var.public_subnet_az}"
    instance_type = "t2.small"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.bigateway-sg.id}"]
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
    key_name = "${file(var.private_key_path)}"

    tags = {
        Name = "PowerBI Gateway"
        Terraform = true
    }
}

resource "aws_eip" "web1" {
    instance = "${aws_instance.powerbi-data-gateway.id}"
    vpc = true
}
