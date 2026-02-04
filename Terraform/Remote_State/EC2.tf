resource "aws_instance" "db" {

    ami = "ami-0220d79f3f480ecf5"
    vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
    # In the above line we are giving id at the because of this AWS will create the SG first then it will take
    # the SG id and pass it to the above line.
    instance_type = "t3.micro"

    tags = {
      name = "db"
    }
}

resource "aws_security_group" "allow_ssh" {

    name = "allow_ssh"
    description = "allowing ssh"

    ingress {
        from_port        = "22"
        to_port          = "22"
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0 # from 0 to 0 opening all ports
        to_port          = 0
        protocol         = "-1" # this indicates all protocols
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      name = "allow_ssh"
      createdby = "Pavan" 
    }
}
