output "SHELLCATCHER" {
value = format("[+]>>>>>>>>>>LOGIN HERE>>>>>>>>>> ssh -i terraform-key-pair.pem ec2-user@%s", aws_instance.shell_catcher.public_ip)
}
