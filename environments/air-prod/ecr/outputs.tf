################################################################################
# Amazon Elastic Container Registry (ECR)
################################################################################

output "ecr_repositories" {
  value = module.ecr.ecr_repositories
}