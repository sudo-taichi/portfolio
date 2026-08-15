variable "distribution_id" {
  description = "監視対象の CloudFront ディストリビューション ID"
  type        = string
}

variable "notification_email" {
  description = "アラート通知先のメールアドレス"
  type        = string
}

variable "name_prefix" {
  description = "リソース名のプレフィックス"
  type        = string
  default     = "portfolio"
}
