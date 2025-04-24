output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.sap_sles.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.sap_sles.public_ip
}
