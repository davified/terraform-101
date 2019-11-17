provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_instance" {
  count                  = 10
  ami                    = "ami-2757f631"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.my_key_pair.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.my_security_group.id}"]

  user_data = <<-EOF
            #!/bin/bash
            echo "Hello Coder Academy!!" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "davids-key"
  public_key = "<replace with your keypair>"
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh_security_group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_security_group" {
  name = "allow_incoming_traffic_on_port_8080"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
