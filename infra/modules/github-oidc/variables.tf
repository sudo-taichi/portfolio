variable "github_repository" {
  description = "デプロイを許可する GitHub リポジトリ（owner/repo 形式）"
  type        = string
}

variable "role_name" {
  description = "GitHub Actions が引き受ける IAM ロール名"
  type        = string
  default     = "github-actions-portfolio-deploy"
}

variable "site_bucket_arn" {
  description = "デプロイ先 S3 バケットの ARN"
  type        = string
}

variable "distribution_arn" {
  description = "キャッシュ削除対象の CloudFront ディストリビューション ARN"
  type        = string
}
