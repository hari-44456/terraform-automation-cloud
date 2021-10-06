data "aws_ami" "ubuntu" {
  most_recent = true
  owners= ["amazon"]
  filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
      name = "virtualization-type"
      values = ["hvm"]
  }
}

resource "aws_key_pair" "deployer" {
  count = var.number_of_instances

  key_name   = "${var.prefix}-key"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "web" {
  
  count = var.number_of_instances
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer[0].key_name

  provisioner "remote-exec" {
  
    inline = [
     "mkdir newDir",
     "rmdir newDir"
    ]
    
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = file(var.private_key_location)
    }
  }

  provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i '${self.public_ip},' --private-key ${var.private_key_location} ansible/playbook.yml"
  }

  tags = {
    Name = "${var.prefix}-Terraform"
  }
}
