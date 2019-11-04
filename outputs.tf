output "vpc_id" {
    value = "${aws_vpc.reportingvpc.id}"
}

output "public_instance_dns" {
    value = "${aws_instance.powerbi-data-gateway.public_dns}"
}

output "private_instance_ip" {
    value = "${aws_instance.ohs_db.private_ip}"    
}

output "Windows_Administrator_Password" {
    value = "${rsadecrypt(aws_instance.powerbi-data-gateway.password_data, file("${module.ssh_key_pair.private_key_path}"))}"
}
