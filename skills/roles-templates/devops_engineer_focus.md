# DevOps Engineer Focus Strategy

最終更新日時: 2026年1月20日

## 📋 Skill Definition

```yaml
name: DevOps Engineer Focus
type: focus_strategy
version: 1.0

description: |
  DevOpsエンジニア視点でのタスク分解戦略。
  CI/CD パイプライン構築と自動化を中心に。
  開発→テスト→デプロイ→監視のサイクルを高速化。

applicable_goals:
  - CI/CD構築
  - インフラ自動化
  - 監視・運用体制構築
  - 開発生産性向上
  keywords:
    - "DevOps"
    - "CI/CD"
    - "自動化"
    - "インフラ"
    - "デプロイ"
```

---

## 🎯 分解原則（Decomposition Principles）

### 1. CI/CDパイプライン

**Build → Test → Deploy → Monitor**

- 継続的インテグレーション
- 継続的デリバリー/デプロイメント
- フィードバックループの確立

### 2. Infrastructure as Code（IaC）

**インフラをコードで管理**

- 再現性の確保
- バージョン管理
- 変更の追跡

### 3. Observability（可観測性）

**ログ・メトリクス・トレース**

- 問題の早期発見
- パフォーマンス監視
- インシデント対応

---

## 📐 フェーズ構造（Phase Structure）

### Phase 1: Foundation（基盤構築）

**目的**: 基本的なインフラ環境の構築

**典型的なタスク分解**:
- クラウド環境設計・構築
- ネットワーク設計
- IaCツール選定・導入
- シークレット管理
- 環境分離（Dev/Stg/Prod）

### Phase 2: CI/CD Pipeline（パイプライン構築）

**目的**: 自動化パイプラインの構築

**典型的なタスク分解**:
- ソースコード管理（Git）
- ビルド自動化
- テスト自動化
- デプロイ自動化
- 承認フロー設計

### Phase 3: Monitoring & Observability（監視体制）

**目的**: 監視・アラート体制の構築

**典型的なタスク分解**:
- メトリクス収集基盤
- ログ収集・分析基盤
- ダッシュボード構築
- アラート設計・設定
- インシデント対応フロー

### Phase 4: Optimization（最適化）

**目的**: 継続的な改善

**典型的なタスク分解**:
- パフォーマンス最適化
- コスト最適化
- セキュリティ強化
- ドキュメント整備
- チーム教育・ナレッジ共有

---

## 🔑 重要な考慮事項

### SubLayer判定基準

- **異なる環境**: Dev/Staging/Production
- **異なるサービス**: マイクロサービス単位
- **技術スタック**: フロント/バック/データ

### Task判定基準

- **構築系**: 環境構築、ツール導入、設定
- **自動化系**: パイプライン作成、スクリプト作成
- **運用系**: 監視設定、アラート、ドキュメント

---

## 💡 使用例

### 例1: 本番環境DevOps構築

**Goal**: 本番環境のCI/CD基盤を構築

**SubLayer分解例**:
- SG1: クラウドインフラ構築（AWS/GCP/Azure）
- SG2: CI/CDパイプライン構築
- SG3: 監視・ログ基盤構築
- SG4: セキュリティ・運用体制

### 例2: CI/CD導入（Task分解例）

**Goal**: GitHub Actions + ArgoCD でCI/CDを構築

**Task分解例**:
- T001: 要件整理・ツール選定
- T002: GitHub Actions ワークフロー作成
- T003: Dockerイメージビルド自動化
- T004: テスト自動化（Unit/E2E）
- T005: ArgoCD 設定・導入
- T006: デプロイフロー構築
- T007: ドキュメント・教育

---

**作成日**: 2026-01-20
**ステータス**: Active
