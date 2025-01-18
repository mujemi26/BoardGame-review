output "instance_ids" {
  value = aws_instance.main[*].id
}

output "public_ips" {
  value = aws_instance.main[*].public_ip
}

output "private_key_path" {
  value = local_file.private_key.filename
}