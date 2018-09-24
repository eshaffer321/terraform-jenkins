provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "jenkins" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.jenkins-sg.name}"]
  key_name        = "${var.key_pair_name}"

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file("~/Desktop/main.pem")}"
    }

    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file("~/Desktop/main.pem")}"
    }

    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh",
    ]
  }
}

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Managed by terraform"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.jenkins.id}"
}
