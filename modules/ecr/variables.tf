variable "create_ecr" {
  description = "Controls if ECR should be created"
  type        = bool
  default     = true
}

variable "registries" {
  type    = any
  default = []
}

variable "registries_policies" {
  type    = any
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "suffix" {
  description = "The project suffix"
  type        = string
}