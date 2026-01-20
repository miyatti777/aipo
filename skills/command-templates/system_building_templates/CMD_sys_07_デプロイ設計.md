# CMD_sys_07_デプロイ設計

最終更新日時: 2026年1月20日

# デプロイ・CI/CD設計テンプレート

> **開発環境から本番環境まで**

---

## 🎯 このテンプレートでできること

- 環境設計（dev/staging/prod）
- CI/CDパイプライン構築
- インフラ構成設計
- 監視・ロギング設計
- セキュリティ設定

---

## 📋 実行前の質問（必須回答）

### 1. デプロイ先
- Vercel（推奨：Next.js）
- Cloudflare Pages/Workers
- AWS（ECS/Lambda/EC2）
- GCP（Cloud Run/GKE）
- 自前サーバー

### 2. データベース
- Vercel Postgres / Neon
- PlanetScale
- Supabase
- AWS RDS
- 自前PostgreSQL

### 3. CI/CDツール
- GitHub Actions（推奨）
- GitLab CI
- CircleCI

---

## 🔄 実行手順

### Phase 1: 環境設計（15分）

```yaml
実行内容:
  - 環境一覧の定義
  - 環境変数管理方針
  - ブランチ戦略

成果物:
  - docs/deploy/environments.md
```

**AIの動作:**
```
🌍 環境設計を行います

【環境一覧】
┌──────────┬───────────────┬─────────────┬──────────────┐
│ 環境     │ URL           │ ブランチ    │ 用途         │
├──────────┼───────────────┼─────────────┼──────────────┤
│ local    │ localhost:3000│ -           │ ローカル開発 │
│ preview  │ *.vercel.app  │ feature/*   │ PR確認       │
│ staging  │ stg.xxx.com   │ develop     │ 検証環境     │
│ prod     │ xxx.com       │ main        │ 本番環境     │
└──────────┴───────────────┴─────────────┴──────────────┘

【ブランチ戦略】
main (本番)
  ↑ merge (PR + 承認)
develop (ステージング)
  ↑ merge (PR)
feature/* (機能開発)

【環境変数管理】
- ローカル: .env.local（gitignore）
- Vercel: Environment Variables（UI管理）
- シークレット: Vercel環境変数（暗号化）

この設計で進めますか？
```

---

### Phase 2: CI/CDパイプライン構築（25分）

```yaml
実行内容:
  - GitHub Actions設定
  - ビルド・テスト自動化
  - デプロイ自動化

成果物:
  - .github/workflows/ci.yml
  - .github/workflows/deploy.yml
```

**AIの動作:**
```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  NODE_VERSION: '20'

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  typecheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      - run: npm ci
      - run: npm run typecheck

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      - run: npm ci
      - run: npm run test:ci
      - uses: codecov/codecov-action@v3
        with:
          token: ${{ secrets.CODECOV_TOKEN }}

  build:
    runs-on: ubuntu-latest
    needs: [lint, typecheck, test]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-artifact@v4
        with:
          name: build
          path: .next/

  e2e:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npm run test:e2e
      - uses: actions/upload-artifact@v4
        if: failure()
        with:
          name: playwright-report
          path: playwright-report/
```

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://your-app.com
    steps:
      - uses: actions/checkout@v4
      - uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
```

---

### Phase 3: 環境変数・シークレット管理（15分）

```yaml
実行内容:
  - 環境変数の分類
  - シークレット管理方針
  - .env.example作成

成果物:
  - .env.example
  - docs/deploy/env-vars.md
```

**AIの動作:**
```bash
# .env.example
# ====================
# App Configuration
# ====================
NODE_ENV=development
NEXT_PUBLIC_APP_URL=http://localhost:3000

# ====================
# Database
# ====================
DATABASE_URL="postgresql://user:password@localhost:5432/mydb"

# ====================
# Authentication
# ====================
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-secret-key-here  # openssl rand -base64 32

# OAuth (Optional)
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# ====================
# External Services
# ====================
# Stripe (Optional)
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=

# Email (Optional)
RESEND_API_KEY=

# ====================
# Monitoring (Optional)
# ====================
SENTRY_DSN=
NEXT_PUBLIC_SENTRY_DSN=
```

```markdown
# docs/deploy/env-vars.md

## 環境変数一覧

### 必須（全環境）
| 変数名 | 説明 | 例 |
|--------|------|-----|
| DATABASE_URL | DB接続文字列 | postgresql://... |
| NEXTAUTH_SECRET | 認証シークレット | ランダム文字列 |
| NEXTAUTH_URL | アプリURL | https://example.com |

### 本番のみ
| 変数名 | 説明 |
|--------|------|
| SENTRY_DSN | エラー監視 |
| STRIPE_SECRET_KEY | 決済（本番キー） |

### 設定手順

1. Vercel Dashboard → Project → Settings → Environment Variables
2. 各環境（Production/Preview/Development）に設定
3. シークレットは「Sensitive」にチェック
```

---

### Phase 4: 監視・ロギング設計（15分）

```yaml
実行内容:
  - ロギング戦略
  - エラー監視設定（Sentry等）
  - パフォーマンス監視
  - アラート設定

成果物:
  - src/lib/logger.ts
  - sentry.*.config.ts
  - docs/deploy/monitoring.md
```

**AIの動作:**
```typescript
// src/lib/logger.ts
import pino from 'pino'

export const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  transport:
    process.env.NODE_ENV === 'development'
      ? {
          target: 'pino-pretty',
          options: {
            colorize: true,
          },
        }
      : undefined,
  base: {
    env: process.env.NODE_ENV,
    version: process.env.npm_package_version,
  },
})

// 構造化ログの例
export const logRequest = (req: Request, duration: number) => {
  logger.info({
    type: 'request',
    method: req.method,
    url: req.url,
    duration,
  })
}

export const logError = (error: Error, context?: Record<string, unknown>) => {
  logger.error({
    type: 'error',
    message: error.message,
    stack: error.stack,
    ...context,
  })
}
```

```typescript
// sentry.client.config.ts
import * as Sentry from '@sentry/nextjs'

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  tracesSampleRate: 1.0,
  replaysSessionSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
  integrations: [
    Sentry.replayIntegration(),
  ],
})

// sentry.server.config.ts
import * as Sentry from '@sentry/nextjs'

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 1.0,
})
```

---

### Phase 5: ドキュメント整備（10分）

```yaml
実行内容:
  - デプロイ手順書
  - ロールバック手順
  - 障害対応手順

成果物:
  - docs/deploy/README.md
  - docs/deploy/runbook.md
```

**AIの動作:**
```markdown
# docs/deploy/README.md

## デプロイ手順

### 自動デプロイ（推奨）

1. `main`ブランチにマージ → 自動デプロイ
2. Vercel Dashboard で確認

### 手動デプロイ

```bash
# Vercel CLI
vercel --prod
```

### ロールバック

1. Vercel Dashboard → Deployments
2. 戻したいデプロイを選択
3. 「Promote to Production」をクリック

## 障害対応

### エラー発生時

1. Sentry でエラー詳細を確認
2. 必要に応じてロールバック
3. 修正PRを作成・マージ

### DB障害時

1. Vercel Postgres Dashboard を確認
2. 必要に応じて復旧手順を実行
```

---

## ✅ 完了条件チェックリスト

- [ ] 環境設計が完了している
- [ ] CI/CDパイプラインが動作している
- [ ] 環境変数が適切に管理されている
- [ ] 監視・ロギングが設定されている
- [ ] ドキュメントが整備されている

---

## 💡 デプロイチェックリスト

### 本番デプロイ前

- [ ] テストがすべてパス
- [ ] ステージングで動作確認
- [ ] 環境変数が本番用に設定
- [ ] DBマイグレーション確認
- [ ] ロールバック手順確認

### デプロイ後

- [ ] ヘルスチェック確認
- [ ] 主要機能の動作確認
- [ ] エラー監視確認
- [ ] パフォーマンス確認

---

## 🔗 関連テンプレート

- [CMD_sys_06_テスト設計](./CMD_sys_06_テスト設計.md)
- [CMD_sys_08_ドキュメント整備](./CMD_sys_08_ドキュメント整備.md)

---

**作成日**: 2026-01-20
**カテゴリ**: システム構築
**タスクタイプ**: infrastructure
