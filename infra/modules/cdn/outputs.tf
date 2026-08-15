output "distribution_arn" {
  description = "S3 バケットポリシーの条件に使用するディストリビューションの ARN"
  value       = aws_cloudfront_distribution.this.arn
}

output "distribution_id" {
  description = "キャッシュ無効化に使用するディストリビューション ID"
  value       = aws_cloudfront_distribution.this.id
}

output "domain_name" {
  description = "サイトへアクセスするための CloudFront ドメイン名"
  value       = aws_cloudfront_distribution.this.domain_name
}
