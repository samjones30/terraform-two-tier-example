# Get latest snapshot from production DB
data "aws_db_snapshot" "ohs_db_snapshot" {
    most_recent = true
    db_instance_identifier = "dps-tst-hec-ohs-dat00"
}

data "aws_db_snapshot" "prc_db_snapshot" {
    most_recent = true
    db_instance_identifier = "dps-tst-hec-prc-dat00"
}

data "aws_db_snapshot" "jobs_db_snapshot" {
    most_recent = true
    db_instance_identifier = "dps-dev-hec-nhsj-dat00"
}
