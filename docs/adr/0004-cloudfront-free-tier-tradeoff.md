# ADR 0004: CloudFront 定額料金プラン Free ティア採用に伴う機能制約の受け入れ

## ステータス

承認済み（2026-08）

## 背景

構築当初、CloudFront にカスタムレスポンスヘッダーポリシーを定義し、
以下のセキュリティヘッダーを付与する設計としていた。

- Strict-Transport-Security（max-age 2年 / includeSubDomains / preload）
- X-Content-Type-Options: nosniff
- X-Frame-Options: DENY
- Referrer-Policy: strict-origin-when-cross-origin
- Content-Security-Policy（自サイトのみを許可する保守的な設定）

また AWS WAF v2 の WebACL を自前で定義し、マネージドルール
（CommonRuleSet / KnownBadInputs）を適用していた。

この構成は従量課金となり、WAF だけで月額 $5〜8 程度が発生する。

## 課題

2025年11月にリリースされた CloudFront 定額料金プランの Free ティア（$0/月）には、
CDN・WAF・DDoS 保護・Route 53 DNS・TLS 証明書・S3 ストレージクレジットが含まれる。
超過料金も発生しない。

しかしこのティアへ登録しようとしたところ、コンソール上で選択できなかった。
理由として表示されたのは以下である。

> You're using configuration not available in this tier: カスタムレスポンスヘッダーポリシー

さらにポリシーを外して再試行した際、価格クラス（PriceClass）の指定も
Free ティアでは許可されないことが判明した。

## 検討した選択肢

**A. 現状維持（従量課金）** — 自前のセキュリティヘッダーと WAF を保持できるが、
月額 $5〜8 が継続的に発生する。

**B. ヘッダーポリシーを削除して Free ティアへ** — 月額 $0 になるが、
セキュリティヘッダーが一切付与されなくなる。

**C. AWS マネージドの SecurityHeadersPolicy を使用** — カスタム扱いにならず
Free ティアに登録でき、主要なヘッダーは付与される。ただし CSP は含まれない。

## 決定

**C を採用する。**

マネージドポリシー `SecurityHeadersPolicy`（ID: 67f7725c-6f97-4210-82d7-5512b31e9d03）
へ切り替え、価格クラスの指定を削除した。

## 理由

B は運用コストを優先してセキュリティを放棄する判断であり、
ポートフォリオとして示す構成にはふさわしくない。

A は月額 $5〜8 の価値が CSP のみに対して見合うかという問題になる。
本サイトは静的コンテンツのみで外部スクリプトを読み込まず、
ユーザー入力を受け付けるフォームも存在しない。
CSP が防ぐ攻撃面（XSS によるスクリプト注入）のリスクは相対的に低い。

C であれば HSTS・X-Content-Type-Options・X-Frame-Options・Referrer-Policy は
引き続き付与され、WAF も Free ティアに含まれる保護が適用される。
失うのは CSP のみであり、コストとのバランスとして妥当と判断した。

## 実装上の課題

ポリシーの削除と CloudFront の更新を同時に適用した際、
Terraform が削除を先に実行し、以下のエラーで失敗した。

ResponseHeadersPolicyInUse: The specified response headers policy is
currently associated with a cache behavior.


`terraform apply -target=module.cdn.aws_cloudfront_distribution.this` により
ディストリビューションの更新のみを先行させ、紐付けを解除してから
全体を適用することで解決した。

`-target` は依存関係の解決を Terraform に委ねない例外的な操作であり、
常用すべきではないが、この種の順序制約を解く手段として有効である。

## 結果

- インフラ費用が月額 $0 になった
- 主要なセキュリティヘッダーは CDN 層で引き続き適用されている
- CSP は未適用。将来的に動的機能を追加する場合は Pro ティア（$15/月）への
  移行を検討する

## 今後の再評価条件

以下のいずれかに該当した場合、本決定を見直す。

- サイトに外部スクリプトやユーザー入力を伴う機能を追加する場合
- 独自ドメインを導入し、より厳密な HSTS preload 設定が必要になった場合
- Free ティアの使用量上限（月間100万リクエスト / 100GB）に接近した場合