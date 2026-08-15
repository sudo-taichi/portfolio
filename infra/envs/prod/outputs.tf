output "site_url" {
  description = "サイトの URL"
  value       = "https://${module.cdn.domain_name}"
}

output "distribution_id" {
  description = "キャッシュ無効化に使用するディストリビューション ID"
  value       = module.cdn.distribution_id
}

output "bucket_id" {
  description = "デプロイ先の S3 バケット名"
  value       = module.static_site.bucket_id
}

output "github_actions_role_arn" {
  description = "GitHub Actions のワークフローで指定する IAM ロール ARN"
  value       = module.github_oidc.role_arn
}
