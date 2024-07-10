variable "create_ecr" {
  description = "Controls if ECR should be created"
  type        = bool
  default     = true
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "container_port" {
  description = "Port that needs to be exposed for the application"
  default     = 80
}
variable "container_name" {
  description = "Application name"
  default     = "simple-rest-air"
}
