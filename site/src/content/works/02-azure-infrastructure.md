---
title: "Azure 社内システム基盤の設計・構築"
period: "2026年2月 - 2026年5月（3ヶ月）"
role: "管理者"
teamSize: 5
phase: ["設計", "構築"]
stack: ["Azure VM", "VNet", "NSG", "Azure Database for MySQL", "Key Vault", "Managed Identity", "Defender for Cloud", "Log Analytics", "Azure Backup", "Nginx", "Java", "certbot"]
summary: "社内向け勤怠管理システムの基盤を Azure 上に構築。可用性 99.90% / RPO 60分 / RTO 120分の要件を満たしつつ、DB の閉域化とシークレットレスな実行環境を実現した。"
featured: true
order: 2
---

## 概要

社内向け勤怠管理システムの基盤を Azure 上に構築するプロジェクト。
24時間稼働の Java Web アプリケーションおよびバッチ処理基盤を対象に、
要件定義から詳細設計、構築、運用設計までを一気通貫で担当した。

社内案件の獲得にあたっては、実務経験を積む機会を求めて経営層へ直接提案を行い、
管理者としてプロジェクトを主導した。

## 課題

可用性 99.90%、RPO 60分、RTO 120分という要件を満たしつつ、
社内システムとして月額コストを抑える必要があった。
セキュリティ要件とコスト効率、そして将来の拡張性という
相反しやすい3点のバランスをどう取るかが設計上の焦点となった。

## 取り組み

### ネットワーク分離とアクセス制御

VNet および Subnet 設計により Web 層と DB 層を分離。
NSG で最小権限の原則に基づくトラフィック制御を実装した。

運用時の SSH 接続には Microsoft Defender for Cloud の
**Just-In-Time アクセス**を採用し、常時開放されたポートを排除した。

### シークレットレスな実行環境

Azure Key Vault と Managed Identity を連携させ、
DB 接続情報や認証情報を VM 内に一切保持しない構成とした。
認証情報の平文管理という典型的なリスクを設計段階で排除している。

### データベースの閉域化

Azure Database for MySQL Flexible Server を VNet 統合（Private Access）で構築し、
外部ネットワークからの直接アクセスを完全に遮断。
バックアップ保持期間と PITR によりデータ保護と障害復旧要件を満たした。

### 運用負荷を見据えた技術選定

IaaS ではなくフルマネージドな PaaS を採用することを提案・導入。
パッチ適用やバックアップといった日常的な運用作業を削減した。

証明書運用についても、Azure DNS と連携した certbot の DNS-01 チャレンジにより
更新プロセスを自動化し、手作業による失効リスクを排除している。

### 監視とアラート通知の設計

Log Analytics により VM・DB の CPU、メモリ、ディスク使用率、DB接続数を統合監視。
Critical / Warning の二段階でアラートを設計した。

監視アラートおよび証明書更新の失敗イベントは、Webhook 経由で
Microsoft Teams へ自動通知する仕組みを構築。
運用担当者が管理画面を常時確認しなくても異常を検知できる体制とした。

## 成果

- 可用性・RPO・RTO の各要件を満たす構成を設計し、要求仕様を網羅した環境を構築
- DB の閉域化により、情報漏洩・不正アクセスのリスクを大幅に低減
- VM のサイズ変更や構成変更を容易に行える設計とし、
  事業成長に伴うスケールへ即座に対応可能な基盤を確立
- PaaS 採用と証明書自動更新により、運用フェーズの工数を継続的に削減
- 本案件で得た設計知見が、後続の GCP 移行プロジェクトの土台となった

## 技術構成

| 領域 | 採用技術 |
|---|---|
| コンピュート | Azure VM（Ubuntu 22.04 LTS / Premium SSD） |
| ネットワーク | VNet / Subnet / NSG / Private Endpoint / Azure DNS |
| データベース | Azure Database for MySQL Flexible Server（VNet統合 / PITR） |
| シークレット管理 | Azure Key Vault / Managed Identity |
| セキュリティ | Microsoft Defender for Cloud（JIT アクセス） |
| 監視・通知 | Log Analytics / Azure Monitor / Webhook 経由の Teams 通知 |
| バックアップ | Azure Backup（Recovery Services Vault） |
| ミドルウェア | Nginx / OpenJDK 17 / systemd / cron |
| 証明書 | Let's Encrypt / certbot（DNS-01 チャレンジ） |
