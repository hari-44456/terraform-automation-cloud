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
    count = var.number_of_instances == 1 ? 1 : 0

  key_name   = "narahari-key"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "web" {
  
  count = var.number_of_instances == 1 ? 1 : 0
  
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer[0].key_name

  tags = {
    Name = "Narahari-Terraform"
  }
}
