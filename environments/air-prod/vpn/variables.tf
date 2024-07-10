variable "customer_ip" {
  type    = string
  default = "1.1.1.1"
}

variable "customer_asn" {
  type    = string
  default = "65001"
}

variable "aws_asn" {
  type    = string
  default = "64512"
}

variable "ip_version" {
  type    = string
  default = "ipv4"
}
