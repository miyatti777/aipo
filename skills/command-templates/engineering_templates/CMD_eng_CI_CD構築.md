# CMD_eng_CI_CD構築

最終更新日時: 2026年1月20日

## 📋 コマンド概要

```yaml
command: /eng/CI_CD構築
alias: ["/cicd", "/パイプライン", "/devops"]
category: engineering
related_role: devops_engineer_focus

description: |
  CI/CDパイプラインの設計・構築をサポートします。
  ビルド、テスト、デプロイの自動化と
  インフラのコード化を支援。

trigger_keywords:
  - "CI/CD"
  - "パイプライン"
  - "DevOps"
  - "自動化"
  - "デプロイ"
```

---

## 📝 実行フロー

### Phase 1: 要件整理

```markdown
## 📋 CI/CD要件定義

### プロジェクト情報
- リポジトリ: 
- 言語/フレームワーク: 
- 現在のデプロイ方法: 

### 環境構成
| 環境 | 用途 | URL | インフラ |
|------|------|-----|---------|
| Dev | 開発 | | |
| Staging | 検証 | | |
| Production | 本番 | | |

### 要件
- [ ] 自動ビルド
- [ ] 自動テスト（Unit/Integration/E2E）
- [ ] 自動デプロイ
- [ ] 承認フロー
- [ ] ロールバック機能
- [ ] 通知（Slack等）

### ツール選定
| カテゴリ | 選択肢 | 選定 |
|---------|-------|------|
| CI | GitHub Actions / GitLab CI / CircleCI | |
| CD | ArgoCD / Flux / Spinnaker | |
| コンテナ | Docker | |
| オーケストレーション | Kubernetes / ECS | |
| IaC | Terraform / Pulumi | |
```

### Phase 2: パイプライン設計

```markdown
## 🔄 パイプライン設計

### パイプラインフロー
```
[Push/PR]
    ↓
┌─────────┐
│  Build  │ ← コンパイル、依存解決
└────┬────┘
     ↓
┌─────────┐
│  Test   │ ← Unit, Lint, Security
└────┬────┘
     ↓
┌─────────┐
│  Image  │ ← Docker Build & Push
└────┬────┘
     ↓
┌─────────┐
│ Deploy  │ ← Staging/Production
│ (Dev)   │
└────┬────┘
     ↓
┌─────────┐
│ Approve │ ← 本番承認
└────┬────┘
     ↓
┌─────────┐
│ Deploy  │
│ (Prod)  │
└─────────┘
```

### ステージ詳細
| ステージ | トリガー | 処理内容 | 成功条件 |
|---------|---------|---------|---------|
| Build | Push | | |
| Test | Build成功 | | |
| Deploy Dev | Test成功 | | |
| Deploy Prod | 手動承認 | | |
```

### Phase 3: 実装

```markdown
## 📝 GitHub Actions設定例

### .github/workflows/ci.yml
\`\`\`yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install dependencies
        run: npm ci
      - name: Build
        run: npm run build

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: npm test
      - name: Run lint
        run: npm run lint

  deploy-staging:
    needs: test
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Staging
        run: echo "Deploy to staging"

  deploy-production:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy to Production
        run: echo "Deploy to production"
\`\`\`
```

### Phase 4: 監視・運用

```markdown
## 📊 監視・運用設計

### ダッシュボード
- ビルド成功率
- デプロイ頻度
- リードタイム
- 障害復旧時間（MTTR）

### アラート設定
| イベント | 通知先 | 優先度 |
|---------|-------|-------|
| ビルド失敗 | Slack #dev | 中 |
| デプロイ失敗 | Slack #dev | 高 |
| 本番障害 | PagerDuty | 緊急 |

### ロールバック手順
1. 
2. 
3. 
```

---

## 📋 出力テンプレート

```markdown
# CI/CD設計書

## 概要
{{overview}}

## パイプライン構成
{{pipeline}}

## 環境構成
{{environments}}

## 設定ファイル
{{configurations}}

## 運用手順
{{operations}}
```

---

**作成日**: 2026-01-20
**ステータス**: Active
