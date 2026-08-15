variable "bucket_regional_domain_name" {
  description = "オリジンとなる S3 バケットのリージョナルドメイン名"
  type        = string
}

variable "bucket_id" {
  description = "オリジンとなる S3 バケット名（オリジンIDの生成に使用）"
  type        = string
}

variable "web_acl_arn" {
  description = "適用する AWS WAF WebACL の ARN"
  type        = string
}

variable "comment" {
  description = "CloudFront ディストリビューションの説明"
  type        = string
  default     = "portfolio site"
}
