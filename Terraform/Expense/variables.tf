variable "instance_names" {
    default = ["db","frontend","backend"]
  
}
variable "image_id" {
  type        = string #optional
  default     = "ami-0220d79f3f480ecf5" #optional
  description = "RHEL-9 AMI ID" #optional
}

variable "instance_type" {
    default = "t2.micro"
    type = string
}

variable "common_tags" {
    default = {
        Project = "Expense"
        Environment = "Dev"
    }
}

variable "sg_name" {
    default = "allow_ssh"
}

variable "sg_description" {
    default = "allowing port 22"
}

variable "ssh_port" {
    default = 22
}

variable "protocol" {
    default = "tcp"
}

variable "allowed_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "zone_id" {
    default = "Z0841985K37TL1E8WGNQ"
}

variable "domain_name" {
    default = "devopspractice.biz"  
}