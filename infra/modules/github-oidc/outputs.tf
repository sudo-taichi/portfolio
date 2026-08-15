output "role_arn" {
  description = "GitHub Actions のワークフローで指定する IAM ロール ARN"
  value       = aws_iam_role.this.arn
}
