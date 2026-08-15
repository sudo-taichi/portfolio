variable "aws_region" {
  description = "メインリソースを作成する AWS リージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "site_bucket_name" {
  description = "静的サイト配信用の S3 バケット名"
  type        = string
  default     = "sudo-taichi-portfolio-site"
}
