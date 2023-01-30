variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

#variable "aws_account" {
#  type = string
#}

variable "name-prefix" {
  type = string
  default = "prod-ci"
}