provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "portfolio"
      ManagedBy = "terraform"
      Component = "bootstrap"
    }
  }
}
