---
category: cloud
categoryLabel: クラウド
title: Azure / AWS / GCP
order: 1
---

### Microsoft Azure — 約1年

主力領域。**AZ-305（Solutions Architect Expert）** 保持。

可用性 99.90% / RPO 60分 / RTO 120分の要件に基づく全体アーキテクチャ設計と、
月額コストの概算・最適化まで一貫して担当した経験があります。

- VNet / Subnet / NSG による層分離と、最小権限に基づくトラフィック制御
- Key Vault + Managed Identity によるシークレットレスな実行環境の構築
- Azure Database for MySQL Flexible Server の VNet 統合による閉域化
- Defender for Cloud の JIT アクセスによる SSH ポートの常時開放排除
- Log Analytics による統合監視と、Webhook 経由の Teams アラート連携
- Microsoft Entra ID の条件付きアクセスによる 1,000名規模のセキュリティ設計

### AWS — 3ヶ月

**AWS-SAA（Solutions Architect Associate）** 保持。

資格学習のアウトプットとして、Terraform を用いた検証環境を構築しました。
実務での本番運用経験はまだありませんが、
基本的なネットワークトポロジとアクセス制御の設計は自力で行えます。

- VPC / パブリック・プライベートサブネット / IGW / ルートテーブルの構成
- EC2 のデプロイと Elastic IP の割り当て
- セキュリティグループによるインバウンド・アウトバウンド制御

### Google Cloud — 2ヶ月

Azure で設計した既存アーキテクチャを GCP 上に再現するプロジェクトを担当。
生成AIを技術アシスタントとして活用しながら、自己解決型で構築を進めました。

- Compute Engine / VPC ファイアウォールルールによる基礎的なインフラ構築
- Identity-Aware Proxy (IAP) によるセキュアなアクセス経路の確保
- サービスアカウントの権限設計
