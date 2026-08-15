terraform {
  backend "s3" {
    bucket         = "sudo-taichi-portfolio-tfstate"
    key            = "prod/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "portfolio-tfstate-lock"
    encrypt        = true
  }
}
