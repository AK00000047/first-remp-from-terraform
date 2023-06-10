resource "aws_instance" "web" {
  ami           = "ami-04980462b81b515f6"
  key_name = "WEBKEY"
  instance_type = "t2.micro"
  security_groups ="sg-059629c9783a92cbf"
  subnet_id = "subnet-08ae600c4d516dcb5"
  associate_public_ip_address = true
  tags = "instance"
}

