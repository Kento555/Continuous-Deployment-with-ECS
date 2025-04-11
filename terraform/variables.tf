variable "env" {
  type = string
}

variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
  default = [ "vpc-03da384fe18f03012" ]
}

variable "security_group_ids" {
  type = list(string)
  default = [ "sg-04d29afb50bef2d6a" ]
}
