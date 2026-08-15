output "web_acl_arn" {
  description = "CloudFront に適用する WebACL の ARN"
  value       = aws_wafv2_web_acl.this.arn
}
