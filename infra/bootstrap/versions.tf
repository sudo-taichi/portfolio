terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # このディレクトリ自体の state は S3/DynamoDB が存在しない前提で作られるため、
  # chicken-and-egg 問題を避けてローカルで管理する。
  # backend "local" {}
}
