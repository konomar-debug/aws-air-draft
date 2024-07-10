data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "terraform-state-air-1111111111111111111"
    key    = "environments/air-prod/network.tf"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"

  config = {
    bucket = "terraform-state-air-1111111111111111111"
    key    = "environments/air-prod/alb.tf"
    region = "eu-central-1"
  }
}
data "terraform_remote_state" "ecr" {
  backend = "s3"

  config = {
    bucket = "terraform-state-air-1111111111111111111"
    key    = "environments/air-prod/ecr.tf"
    region = "eu-central-1"
  }
}
