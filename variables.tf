
variable "aws_region" {
    default = "eu-west-2"
}

variable "vpc_cidr" {
    default = "10.2.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.2.0.0/24"
}

variable "public_subnet_az" {
    default = "eu-west-2a"
}

variable "private_subnet_cidr" {
    default = "10.2.1.0/24"
}

variable "private_subnet_az" {
    default = "eu-west-2b"
}

variable "allow_all" {
    default = "0.0.0.0/0"
}

variable "aws_key_name" {
    default = "reporting-poc"
}

variable "private_key_path" {
    default = "C:\Users\samjo\Documents\reporting\reporting-poc.pem"
}

variable "cis_ami" {
    default = "ami-ea3f2b8e"
}

variable "windows-ami" {
    default = "ami-06ea28ca18bb79e3c"
}

variable "db_pwd" {
    default = "r3p0rt1ng"
}
