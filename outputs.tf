output "vpc_id" {
    value = "${aws_vpc.reportingvpc.id}"
}

output "public_instance_dns" {
    value = "${aws_instance.powerbi-data-gateway.public_dns}"
}

output "OHS_DB_endpoint_ip" {
    value = "${aws_db_instance.ohs_db.endpoint}"
}

output "OHS_DB_pwd" {
    value = "${aws_db_instance.ohs_db.password}"
}
