output "tfstate_bucket_name" {
  description = "Terraform state を保管する S3 バケット名"
  value       = aws_s3_bucket.tfstate.bucket
}

output "tfstate_lock_table_name" {
  description = "Terraform state のロックに使う DynamoDB テーブル名"
  value       = aws_dynamodb_table.tfstate_lock.name
}
