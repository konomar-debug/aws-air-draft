resource "aws_ecr_repository" "this" {
  count = var.create_ecr && length(var.registries) > 0 ? length(var.registries) : 0
  name  = "${var.registries[count.index]["name"]}-${var.suffix}"

  image_tag_mutability = var.registries[count.index]["image_tag_mutability"]

  image_scanning_configuration {
    scan_on_push = var.registries[count.index]["scan_on_push"]
  }

  tags = merge(var.tags)
}