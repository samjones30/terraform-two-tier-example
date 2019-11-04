resource "aws_security_group" "dbsg" {
    name = "vpc_db"
    description = "Allow incoming database connections."
    vpc_id = "${aws_vpc.reportingvpc.id}"

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = ["${aws_security_group.websg.id}"]
    }

    tags = {
        Name = "DBServerSG"
        Terraform = true
    }
}

# Create new ohs DB
resource "aws_db_instance" "ohs_db" {
  instance_class       = "db.t2.small"
  identifier           = "ohs-db"
  username             = "aws_master_user"
  password             = "${var.db_pwd}"
  db_subnet_group_name = "${var.private_subnet_az}"
  snapshot_identifier  = "${data.aws_db_snapshot.ohs_db_snapshot.id}"
  vpc_security_group_ids = ["${aws_security_group.dbsg.id}"]
  skip_final_snapshot = true
  tags = {
      Name = "OHS DB Server"
      Terraform = true
  }
}
