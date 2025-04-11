variable "env" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "account_id" { type = string }
variable "region" { type = string }