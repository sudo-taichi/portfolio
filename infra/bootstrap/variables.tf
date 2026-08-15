variable "aws_region" {
  description = "リソースを作成する AWS リージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "tfstate_bucket_name" {
  description = "Terraform state を保管する S3 バケット名"
  type        = string
  default     = "sudo-taichi-portfolio-tfstate"
}

variable "tfstate_lock_table_name" {
  description = "Terraform state のロックに使う DynamoDB テーブル名"
  type        = string
  default     = "portfolio-tfstate-lock"
}
