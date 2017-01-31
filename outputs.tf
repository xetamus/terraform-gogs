output "url" {
  value = "http://${aws_instance.gogs01.public_ip}:3000"
}
