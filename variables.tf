variable "access_key" {
}

variable "secret_key" {
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-2757f631"
}

variable "user" {
  default = "ubuntu"
}

variable "key_pair_name" {
  default = "main"
}
