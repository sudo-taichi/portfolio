data "aws_caller_identity" "current" {}

locals {
  distribution_arn = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${module.cdn.distribution_id}"
}

module "waf" {
  source = "../../modules/waf"

  providers = {
    aws.us_east_1 = aws.us_east_1
  }

  name = "portfolio-web-acl"
}

module "static_site" {
  source = "../../modules/static-site"

  bucket_name                 = var.site_bucket_name
  cloudfront_distribution_arn = local.distribution_arn
}

module "cdn" {
  source = "../../modules/cdn"

  bucket_regional_domain_name = "${var.site_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  bucket_id                   = var.site_bucket_name
  web_acl_arn                 = module.waf.web_acl_arn
  comment                     = "portfolio site"
}
