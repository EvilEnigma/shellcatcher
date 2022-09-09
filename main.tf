terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.aws_region
}

variable "generated_key_name" {
  type        = string
  default     = "terraform-key-pair"
  description = "Key-pair added by Terraform"
}

resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.generated_key_name
  public_key = tls_private_key.dev_key.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      rm '${var.generated_key_name}'.pem
      echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem
      chmod 400 ./'${var.generated_key_name}'.pem
      chmod 764 ip.sh
    EOT
  }

}

data "external" "myip" {
  program = ["/bin/bash" , "ip.sh"]
}

resource "aws_security_group" "default" {
  name        = "Shell_catcher_gp"
  description = "Added by Terraform"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s",data.external.myip.result["internet_ip"],32)]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "shell_catcher" {
  ami           = var.aws_ami[var.aws_region]
  instance_type = "t2.micro"
  security_groups = [aws_security_group.default.name]
  key_name        = aws_key_pair.generated_key.key_name 

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = tls_private_key.dev_key.private_key_openssh
    host     = self.public_ip
  }

provisioner "remote-exec" {
    inline = [
	"id",
    ]
}

  tags = {
    Name = "ShellCatcherV0.2"
  }
}
