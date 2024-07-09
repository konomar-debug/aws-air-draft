variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "air-prod"
}

variable "owners" {
  description = "organization this Infrastructure belongs"
  type        = string
  default     = ""
}

variable "name" {
  description = "VPC Name"
  type        = string
  default     = "vpc"
}

variable "cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}
