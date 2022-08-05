#------------------------------------------------------
# My Terraform
# Build WebServer during Bootstrap
#
#------------------------------------------------------


provider "aws" {
  access_key = "AKIAYE2BDNU365ACXGET"
  secret_key = "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"
  region     = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("user_data.sh")
  key_name               = "testKEYS"


  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Dante"
  }
}

resource "aws_instance" "my_webserver_apache" {
  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("user_data_apache.sh")
  key_name               = "testKEYS"


  tags = {
    Name  = "Apache by Terraform"
    Owner = "Dante"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

  tags = {
    Name  = "Web Server Security Group"
    Owner = "Dante"
  }
}
