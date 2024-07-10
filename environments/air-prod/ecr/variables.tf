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
