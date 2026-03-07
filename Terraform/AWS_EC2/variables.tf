variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
}

variable "vpc_security_group_ids" {
    type = list
    default = [""]
}