variable "bucket_name" {
  description = "静的サイト配信用の S3 バケット名"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "アクセスを許可する CloudFront ディストリビューションの ARN"
  type        = string
}
