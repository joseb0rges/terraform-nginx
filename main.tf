provider "aws" {

     region = "${var.region}" 

}


resource "aws_key_pair" "default" {
  key_name = "ec2-nginx-key"
  public_key = "${file("${var.key_path}")}"

}


resource "aws_instance" "ec2" {
    
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "${aws_key_pair.default.id}"
    subnet_id = "${var.subnet_1a}"
    vpc_security_group_ids = ["${aws_security_group.default.name}"]
    user_data = "${file("install_nginx.sh")}"

    tags = {
        Name = "webserver-nginx"
    }

}

resource "aws_security_group" "default" {

    name = "ec2-nginx-sg"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

 # Save the public IP for testing
  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2.public_ip} > public-ip.txt"
  }

