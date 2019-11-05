resource "aws_security_group" "dbsg" {
    name = "vpc_db"
    description = "Allow incoming database connections."
    vpc_id = "${aws_vpc.reportingvpc.id}"

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = ["${aws_security_group.bigateway-sg.id}"]
    }

    tags = {
        Name = "DBServerSG"
        Terraform = true
    }
}

resource "aws_db_subnet_group" "reporting-db-subnet-group" {
  name        = "reporting-subnet-group"
  description = " Reporting RDS subnet group"
  subnet_ids  = ["${aws_subnet.eu-west-2b-private.id}", "${aws_subnet.eu-west-2a-private.id}" ]
}

resource "random_string" "ohs_pwd" {
 length = 16
 special = true
}

resource "random_string" "prc_pwd" {
 length = 16
 special = true
}

resource "random_string" "jobs_pwd" {
 length = 16
 special = true
}

# Create new ohs DB
resource "aws_db_instance" "ohs_db" {
  instance_class       = "db.t2.small"
  identifier           = "ohs-db"
  username             = "aws_master_user"
  password             = "${random_string.ohs_pwd.result}"
  db_subnet_group_name = "${aws_db_subnet_group.reporting-db-subnet-group.id}"
  snapshot_identifier  = "${data.aws_db_snapshot.ohs_db_snapshot.id}"
  vpc_security_group_ids = ["${aws_security_group.dbsg.id}"]
  skip_final_snapshot = true
  tags = {
      Name = "OHS DB Server"
      Terraform = true
  }
}

# Create new prc DB
resource "aws_db_instance" "prc_db" {
  instance_class       = "db.t2.small"
  identifier           = "prc-db"
  username             = "aws_master_user"
  password             = "${random_string.prc_pwd.result}"
  db_subnet_group_name = "${aws_db_subnet_group.reporting-db-subnet-group.id}"
  snapshot_identifier  = "${data.aws_db_snapshot.prc_db_snapshot.id}"
  vpc_security_group_ids = ["${aws_security_group.dbsg.id}"]
  skip_final_snapshot = true
  tags = {
      Name = "PRC DB Server"
      Terraform = true
  }
}

# Create new jobs DB
resource "aws_db_instance" "jobs_db" {
  instance_class       = "db.t2.small"
  identifier           = "jobs-db"
  username             = "aws_master_user"
  password             = "${random_string.jobs_pwd.result}"
  db_subnet_group_name = "${aws_db_subnet_group.reporting-db-subnet-group.id}"
  snapshot_identifier  = "${data.aws_db_snapshot.jobs_db_snapshot.id}"
  vpc_security_group_ids = ["${aws_security_group.dbsg.id}"]
  skip_final_snapshot = true
  tags = {
      Name = "Jobs DB Server"
      Terraform = true
  }
}
