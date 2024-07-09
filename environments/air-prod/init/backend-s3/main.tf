locals {
  suffix = "1111111111111111111"
  tags = {
    Environment = "air-prod"
  }
}

provider "aws" {
  region = "eu-central-1"
}


resource "aws_s3_bucket" "tf_remote_state" {
  bucket = "terraform-state-air-${local.suffix}"
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/terraform_bucket_key"
  target_key_id = aws_kms_key.terraform_bucket_key.key_id
}

resource "aws_kms_key" "terraform_bucket_key" {
  description             = "This key is used to encrypt terraform bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_remote_state" {
  bucket = aws_s3_bucket.tf_remote_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.tf_remote_state.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.tf_remote_state.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  hash_key = "LockID"
  name     = "terraform-state-lock-${local.suffix}"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
  tags         = local.tags
}
