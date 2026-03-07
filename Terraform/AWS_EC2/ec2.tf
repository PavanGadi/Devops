resource "aws_instance" "db" {

    ami = var.ami_id
    vpc_security_group_ids = ["sg-0123456789abcdef0"]
    instance_type = "t2.micro"

    tags = {
        Name = "Database Instance"
    }
}