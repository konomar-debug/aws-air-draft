terraform {
  backend "s3" {
    key = "environments/air-prod/ecr.tf"
  }
}

module "ecr" {
  create_ecr = true
  source     = "../../../modules/ecr"
  suffix     = local.suffix
  registries = local.registries
  tags       = local.tags
}


