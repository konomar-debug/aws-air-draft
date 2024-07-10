locals {
  tags = {
    Environment = "air-prod"
    Terraform   = "true"
  }

  suffix = "prod"
  registries = [
    {
      name                 = "simple-rest-air"
      image_tag_mutability = "IMMUTABLE"
      scan_on_push         = false
    }
  ]
}
