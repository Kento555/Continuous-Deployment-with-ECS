variable "env" {
  type = string
}

variable "account_id" {
  type = string
  default = "255945442255"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "public_subnet_ids" {
  type = list(string)
  default = [ "subnet-003548ecd64fababb" ]
}

variable "security_group_ids" {
  type = list(string)
  default = [ "sg-04d29afb50bef2d6a" ]
}
