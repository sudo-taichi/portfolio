output "sns_topic_arn" {
  description = "アラート通知に使用する SNS トピックの ARN"
  value       = aws_sns_topic.alerts.arn
}
