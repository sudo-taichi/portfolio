---
order: 2
title: Azure 社内システム基盤の設計・構築
period: 2026/02-05
role: 管理者（チーム5名）／要件定義から構築まで一気通貫
challenge: 可用性 99.90% / RPO 60分 / RTO 120分 を満たす基盤設計が求められた
approach: >-
  VNet統合によるDB閉域化、Key Vault + Managed Identity によるシークレットレス構成、
  Defender for Cloud の JIT アクセス、PaaS採用による運用負荷軽減
tech:
  - Azure VM
  - VNet
  - NSG
  - MySQL Flexible Server
  - Key Vault
  - Log Analytics
  - Azure Backup
  - Nginx
  - certbot(DNS-01)
---
