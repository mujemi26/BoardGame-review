data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.environment}-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/${var.environment}-key.pem"
  file_permission = "0600"
}

resource "aws_instance" "main" {
  count = var.instance_count

  ami                    = data.aws_ami.ubuntu.id
  instance_type         = "t2.medium"
  subnet_id             = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group_id]
  key_name             = aws_key_pair.generated_key.key_name

  tags = {
    Name = "${var.environment}-instance-${count.index + 1}"
  }
}