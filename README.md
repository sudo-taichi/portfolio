# Portfolio Site

インフラエンジニア 須藤大智（Taichi Sudo）のポートフォリオサイト。

**サイト:** https://d2c0ddmidime42.cloudfront.net

このリポジトリは、サイトのコンテンツだけでなく、それを配信するインフラ構成そのものを含んでいます。
Terraform による IaC、GitHub Actions による CI/CD、セキュリティ設計の実物として公開しています。

## アーキテクチャ

```
                    ┌─────────────┐
   ユーザー ──────► │ CloudFront  │◄── AWS WAF (マネージドルール2種)
                    │   + OAC     │◄── Managed SecurityHeadersPolicy
                    └──────┬──────┘
                           ▼
                    ┌─────────────┐
                    │  S3 Bucket  │  パブリックアクセス全ブロック
                    │  (private)  │  OAC 経由のみ許可
                    └─────────────┘

  CI/CD:  GitHub Actions ──OIDC──► IAM Role (AssumeRoleWithWebIdentity)
          ※ 長期のアクセスキーを一切保持しない

  State:  S3 backend + DynamoDB (state lock) + バージョニング + SSE

  監視:   SNS トピック + AWS Budgets（月額 $1 で通知）
```

## 技術スタック

| 領域 | 採用技術 |
|---|---|
| フロントエンド | Astro（静的サイト生成 / TypeScript strict） |
| ホスティング | Amazon S3（非公開バケット） |
| CDN | Amazon CloudFront（OAC / 定額料金プラン Free ティア） |
| セキュリティ | AWS WAF v2 / Managed SecurityHeadersPolicy |
| IaC | Terraform 1.15（モジュール分割 / S3 backend） |
| CI/CD | GitHub Actions（OIDC 認証） |
| 監視 | Amazon SNS / AWS Budgets |

## 設計判断

| 判断 | 理由 |
|---|---|
| S3 を非公開にし OAC 経由のみ許可 | バケットへの直接アクセスを遮断。旧 OAI ではなく現行の OAC を採用 |
| GitHub Actions を OIDC 連携 | 長期認証情報を Secrets に置かない。漏洩リスクを構造的に排除 |
| IAM 権限を S3 4アクション + CloudFront 2アクションに限定 | 最小権限の原則。CI に管理者権限を持たせない |
| tfstate に暗号化・ロック・バージョニング | 誤操作からの復旧と排他制御を担保 |
| モジュール分割 | 責務の分離と再利用性の確保 |
| CloudFront 定額プラン Free ティア | WAF・DNS・S3 ストレージを含めて月額 $0 |

## コスト

| 項目 | 月額 |
|---|---|
| CloudFront + WAF + DNS + S3 | $0（定額プラン Free ティア） |
| TLS 証明書 | $0（CloudFront デフォルト証明書） |
| tfstate 用 S3 + DynamoDB | 実質 $0（数 KB / オンデマンド） |
| **合計** | **$0** |

想定トラフィックはポートフォリオ用途のため、Free ティアの上限（月間 100万リクエスト / 100GB 転送）に対して十分な余裕がある。

AWS Budgets で月額 $1 の 80% 到達時にメール通知する設定を入れ、想定外の課金を即座に検知できるようにしている。

## リポジトリ構成

```
portfolio/
├── .github/workflows/
│   └── deploy.yml           # ビルド → S3 同期 → キャッシュ削除
├── infra/
│   ├── bootstrap/           # tfstate 用 S3 + DynamoDB（初回限定）
│   ├── modules/
│   │   ├── static-site/     # S3 バケットとバケットポリシー
│   │   ├── cdn/             # CloudFront + OAC
│   │   ├── waf/             # WAF v2 WebACL
│   │   ├── github-oidc/     # OIDC プロバイダ + IAM ロール
│   │   └── monitoring/      # SNS + Budgets
│   └── envs/prod/           # 本番環境（モジュール呼び出し）
├── site/                    # Astro プロジェクト
└── docs/adr/                # 設計判断記録
```

## デプロイ

`main` ブランチの `site/` 配下に変更を push すると、GitHub Actions が自動的にビルド・S3 同期・CloudFront キャッシュ削除を実行する。

手動デプロイは不要。認証は OIDC により実行時に一時的な認証情報が発行される。

## 既知の課題

- CloudWatch アラーム（5xx エラー率）の provider alias 指定が期待通り動作せず、現在は SNS トピックと予算アラートのみ稼働。原因調査中
- 独自ドメイン未導入。CloudFront デフォルトドメインで運用中
- Content-Security-Policy 未適用（定額プラン Free ティアの制約によりカスタムレスポンスヘッダーポリシーが使用不可）

## ライセンス

コンテンツの著作権は須藤大智に帰属する。
インフラ構成のコードは参考実装として自由に利用してよい。

## 既知の課題

- CloudWatch アラーム（5xx エラー率）の provider alias 指定が期待通り動作せず、
  現在は SNS トピックと予算アラートのみ稼働。原因調査中
- 独自ドメイン未導入。CloudFront デフォルトドメインで運用中
- Content-Security-Policy 未適用（定額プラン Free ティアの制約により
  カスタムレスポンスヘッダーポリシーが使用不可）