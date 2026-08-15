output "bucket_regional_domain_name" {
  description = "CloudFront のオリジン設定で使用するバケットのリージョナルドメイン名"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_id" {
  description = "デプロイ時のファイル同期先として使用するバケット名"
  value       = aws_s3_bucket.this.id
}
