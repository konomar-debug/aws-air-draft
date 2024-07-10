output "ecr_repositories" {
  description = "List of created repositories URLs"
  value = aws_ecr_repository.this[*].repository_url
}