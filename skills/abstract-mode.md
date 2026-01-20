---
name: abstract-mode
description: "L0-L4抽象度管理とIDE擬似プログラミングガイド"
license: "MIT"
---

# CTX_abstract_mode_rules

最終更新日時: 2026年1月20日

# abstract_rules:ide_development - IDE開発ガイド

> **AIPOの抽象化モードは「IDEで動くシステム」を作ります**
>
> 設計書だけでなく、**実際のコード・設定ファイル・スキーマ**を生成して、実行可能なアプリケーションを構築します。
>
> このページは、IDEでできること・作るべき成果物を明確にし、実装タスクの正しい進め方を定義します。

---

## 🚨 最重要原則：必ず実際のコードを生成する

**AIPOの抽象化モードの目的は「動くコード/システム」を作ること。**

セッション中、以下を常に確認すること：

```yaml
session_reminder:
  every_task:
    question: "このタスクで実際のファイルは作成/更新されたか？"
    if_no: "完了とせず、ファイル生成を実行する"
  
  every_completion:
    check: "設計書/ガイドだけで終わっていないか？"
    if_yes: "実際のコード生成を追加実行する"
  
  session_end:
    verify: "このセッションで作成されたファイルの数を報告"
    format: |
      📊 成果物サマリ
      - 作成したコードファイル: X件
      - 更新したファイル: Y件
      - 作成した設計ドキュメント: Z件
      
      ⚠️ ドキュメント数 > コードファイル数 の場合、追加でコード生成が必要
```

**このルールはセッション全体を通じて適用される。**

---

## 🎯 抽象度レベル（L0-L4）

AIPOは5段階の抽象度レベルでプロダクト開発を管理します：

| Level | 名称 | 説明 | 主な成果物 |
|-------|------|------|-----------|
| **L0** | コンセプト | アイデア・仮説段階 | コンセプトドキュメント、仮説リスト |
| **L1** | 設計 | アーキテクチャ・設計段階 | 設計書、ER図、API仕様 |
| **L2** | スキーマ | 型定義・スキーマ段階 | Prismaスキーマ、TypeScript型、OpenAPI |
| **L3** | 実装 | コード実装段階 | ソースコード、テストコード |
| **L4** | 運用 | デプロイ・運用段階 | CI/CD、監視設定、ドキュメント |

```
L0 コンセプト
  ↓ 具体化
L1 設計
  ↓ 具体化
L2 スキーマ
  ↓ 具体化
L3 実装
  ↓ 具体化
L4 運用
```

---

## 🤖 コマンド駆動開発【最重要】

IDEでの開発は**コマンド（テンプレート）駆動**で行います。
各フェーズに対応するコマンドテンプレートを実行し、成果物を生成します。

### 🎯 コマンド駆動とは

**コマンド駆動開発**は、定義済みのテンプレートを使って、一貫した品質で成果物を生成する方式です。

**特徴**：
- テンプレートを`@`メンションで呼び出し
- 必要な情報を質問形式で収集
- 成果物を自動生成
- チェックリストで品質保証
- 繰り返し実行可能（再現性）

### 📐 実装パターン

#### 1. ディレクトリ構造設計

```yaml
# プロジェクト構造
project/
├── src/
│   ├── app/              # Next.js App Router
│   ├── components/       # UIコンポーネント
│   │   ├── ui/          # 基本UI (shadcn/ui等)
│   │   ├── features/    # 機能別コンポーネント
│   │   └── layouts/     # レイアウト
│   ├── lib/             # ユーティリティ
│   │   ├── api/         # APIクライアント
│   │   ├── db.ts        # DB接続
│   │   └── utils/       # ヘルパー
│   ├── services/        # ビジネスロジック
│   ├── repositories/    # データアクセス
│   └── types/           # 型定義
├── prisma/
│   ├── schema.prisma    # DBスキーマ
│   └── seed.ts          # シードデータ
├── tests/
│   ├── unit/            # 単体テスト
│   ├── integration/     # 統合テスト
│   └── e2e/             # E2Eテスト
└── docs/
    ├── api/             # API仕様
    ├── development/     # 開発ガイド
    └── operations/      # 運用ガイド
```

#### 2. コマンドテンプレート実行

```markdown
# 実行例: データベース設計

@CMD_sys_02_データベース設計.md を実行してください

## 入力情報
- DB種別: PostgreSQL
- ORMツール: Prisma
- エンティティ: User, Project, Task
```

**実行結果**：
- AIが質問に回答を収集
- Prismaスキーマを生成
- ER図を作成
- マイグレーションファイルを生成
- シードスクリプトを作成

#### 3. 成果物の例

```prisma
// prisma/schema.prisma（生成されるファイル）

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        String    @id @default(uuid())
  email     String    @unique
  name      String
  role      Role      @default(USER)
  createdAt DateTime  @default(now())
  updatedAt DateTime  @updatedAt

  projects  Project[] @relation("ProjectOwner")
  tasks     Task[]    @relation("TaskAssignee")
}

model Project {
  id          String        @id @default(uuid())
  name        String
  description String?
  status      ProjectStatus @default(DRAFT)
  createdAt   DateTime      @default(now())
  updatedAt   DateTime      @updatedAt

  ownerId String
  owner   User   @relation("ProjectOwner", fields: [ownerId], references: [id])

  tasks Task[]
}

model Task {
  id        String     @id @default(uuid())
  title     String
  content   String?
  status    TaskStatus @default(TODO)
  dueDate   DateTime?
  createdAt DateTime   @default(now())
  updatedAt DateTime   @updatedAt

  projectId  String
  project    Project @relation(fields: [projectId], references: [id])

  assigneeId String?
  assignee   User?   @relation("TaskAssignee", fields: [assigneeId], references: [id])
}

enum Role {
  ADMIN
  USER
}

enum ProjectStatus {
  DRAFT
  ACTIVE
  ARCHIVED
}

enum TaskStatus {
  TODO
  IN_PROGRESS
  DONE
}
```

### 🔄 抽象度レベル別の成果物

| Level | コマンド | 成果物 |
|-------|---------|--------|
| **L1** | CMD_sys_01_アーキテクチャ設計 | architecture.md, tech-stack.md |
| **L2** | CMD_sys_02_データベース設計 | schema.prisma, er-diagram.mermaid |
| **L2** | CMD_sys_03_API設計 | openapi.yaml, types/api.ts |
| **L3** | CMD_sys_04_フロントエンド設計 | components/, pages/, hooks/ |
| **L3** | CMD_sys_05_バックエンド実装 | services/, repositories/, routes/ |
| **L3** | CMD_sys_06_テスト設計 | tests/, vitest.config.ts |
| **L4** | CMD_sys_07_デプロイ設計 | .github/workflows/, vercel.json |
| **L4** | CMD_sys_08_ドキュメント整備 | README.md, docs/ |

### 📚 実装ガイドライン

**1. ファイル生成の原則**

```yaml
原則:
  - 設計書だけで終わらない → 必ずコードも生成
  - 1タスク = 1ファイル以上の成果物
  - 動作確認可能な状態まで実装
  
禁止:
  - "後で実装する"で終わること
  - 設計書のみを成果物とすること
  - 動作確認なしで完了とすること
```

**2. 命名規則**

```yaml
ファイル命名:
  コンポーネント: PascalCase (UserCard.tsx)
  ユーティリティ: camelCase (formatDate.ts)
  定数: UPPER_SNAKE_CASE (API_ENDPOINTS.ts)
  テスト: *.test.ts または *.spec.ts

ディレクトリ命名:
  機能別: kebab-case (user-management/)
  コンポーネント別: PascalCase (UserCard/)
```

**3. コード生成の順序**

```yaml
推奨順序:
  1. 型定義 (types/)
  2. スキーマ (prisma/schema.prisma)
  3. リポジトリ層 (repositories/)
  4. サービス層 (services/)
  5. APIルート (app/api/)
  6. コンポーネント (components/)
  7. ページ (app/)
  8. テスト (tests/)
```

---

## ✅ IDEでできること（実装可能）

### 1. ファイル・コード生成

```yaml
生成可能なファイル:
  設計ドキュメント:
    - README.md
    - architecture.md
    - api-spec.yaml (OpenAPI)
    - er-diagram.mermaid
    
  スキーマ・型定義:
    - prisma/schema.prisma
    - src/types/*.ts
    - zod schemas
    
  ソースコード:
    - React/Next.js コンポーネント
    - API Routes / Server Actions
    - サービス層 / リポジトリ層
    - ユーティリティ関数
    
  テストコード:
    - 単体テスト (Vitest)
    - 統合テスト
    - E2Eテスト (Playwright)
    
  設定ファイル:
    - package.json
    - tsconfig.json
    - tailwind.config.ts
    - vitest.config.ts
    - .github/workflows/*.yml
```

### 2. ファイル編集・リファクタリング

```yaml
編集操作:
  - 既存ファイルの修正
  - コードの追加・削除
  - リファクタリング
  - 型の修正
  - インポート整理
  
リファクタリング:
  - 関数の抽出
  - コンポーネントの分割
  - 型の共通化
  - 重複コードの削除
```

### 3. プロジェクト構造の構築

```yaml
構造構築:
  - ディレクトリ作成
  - ファイル配置
  - モジュール構成
  - レイヤー分離
  
自動化:
  - Lintエラー修正
  - 型エラー修正
  - インポートパス更新
```

---

## ❌ IDEでできないこと（注意点）

```yaml
直接実行できないこと:
  
  1. ランタイム実行:
    - サーバー起動（手動でnpm run devが必要）
    - ブラウザでの動作確認
    - DBマイグレーション実行
    → 対応: コマンドを提示し、ユーザーに実行を依頼
    
  2. 外部サービス連携:
    - 実際のAPIコール
    - DB接続テスト
    - 認証フロー確認
    → 対応: モックを使ったテストコードを生成
    
  3. GUI操作:
    - Figma連携
    - ブラウザDevTools
    - Vercel Dashboard操作
    → 対応: 手順を文書化して提示
```

---

## 🎯 タスクタイプ別の実装方針

### Type: `design` - 設計タスク

**該当するタスク：**
- "○○の設計"
- "アーキテクチャ検討"
- "API仕様策定"

**実装内容：**

```yaml
成果物:
  1. 設計ドキュメント:
    - docs/architecture/README.md
    - docs/api/openapi.yaml
    - docs/database/er-diagram.mermaid
    
  2. 技術選定記録:
    - docs/architecture/decisions/*.md (ADR)
    
  3. スキーマ定義【必須】:
    - prisma/schema.prisma（DB設計の場合）
    - src/types/api.ts（API設計の場合）
```

---

### Type: `implementation` - 実装タスク

**該当するタスク：**
- "○○の実装"
- "○○機能開発"
- "○○コンポーネント作成"

**実装内容：**

```yaml
成果物:
  1. ソースコード【必須】:
    - 機能実装コード
    - 型定義
    - ユーティリティ
    
  2. テストコード【推奨】:
    - 単体テスト
    - 統合テスト（必要に応じて）
    
  3. ドキュメント:
    - JSDoc / TSDoc
    - 使用方法のコメント
```

**実装例（サービス層）:**

```typescript
// src/services/project.service.ts
import { projectRepository } from '@/repositories/project.repository'
import { CreateProjectInput, UpdateProjectInput } from '@/types/api'
import { createError } from '@/lib/errors'

export class ProjectService {
  async getById(id: string, userId: string) {
    const project = await projectRepository.findById(id)
    
    if (!project) {
      throw createError.notFound('プロジェクト')
    }

    if (project.ownerId !== userId) {
      throw createError.forbidden('アクセス権限がありません')
    }

    return project
  }

  async create(input: CreateProjectInput, userId: string) {
    return projectRepository.create({
      ...input,
      ownerId: userId,
    })
  }

  async update(id: string, input: UpdateProjectInput, userId: string) {
    await this.getById(id, userId) // 権限チェック
    return projectRepository.update(id, input)
  }

  async delete(id: string, userId: string) {
    await this.getById(id, userId) // 権限チェック
    await projectRepository.delete(id)
  }
}

export const projectService = new ProjectService()
```

---

### Type: `validation` - 検証タスク

**該当するタスク：**
- "○○のテスト"
- "品質検証"
- "動作確認"

**実装内容：**

```yaml
成果物:
  1. テストコード【必須】:
    - tests/unit/*.test.ts
    - tests/integration/*.test.ts
    - tests/e2e/*.spec.ts
    
  2. テスト設定:
    - vitest.config.ts
    - playwright.config.ts
    
  3. テストレポート:
    - カバレッジレポート設定
    - CI連携設定
```

---

## 🛠️ 実装時の必須チェックリスト

### タスク開始前

```yaml
確認事項:
  - [ ] 対応するコマンドテンプレートを特定したか？
  - [ ] 必要な入力情報を収集したか？
  - [ ] 成果物の種類と配置場所を決めたか？
```

### 実装中

```yaml
確認事項:
  - [ ] ファイルを実際に作成/更新したか？
  - [ ] 型定義は正しいか？
  - [ ] Lintエラーは解消したか？
  - [ ] インポートパスは正しいか？
```

### 完了判定

```yaml
確認事項:
  - [ ] 成果物ファイルが存在するか？
  - [ ] 設計書だけでなくコードも生成したか？
  - [ ] テストコードを作成したか（実装タスクの場合）？
  - [ ] ドキュメントを更新したか？
```

---

## 🔄 AIPOフェーズとの連携

```yaml
# Senseフェーズ (L0)
成果物: 仮説リスト、コンセプトドキュメント

# Focusフェーズ (L0-L1)
成果物: PRD、ユーザーストーリー、優先度リスト

# Discoverフェーズ (L1-L2)
成果物: 設計書、スキーマ、API仕様

# Deliverフェーズ (L2-L3)
成果物: ソースコード、テストコード

# Operationフェーズ (L3-L4)
成果物: CI/CD、監視設定、運用ドキュメント
```

---

## 📚 参考リソース

### コマンドテンプレート

| カテゴリ | テンプレート |
|---------|-------------|
| システム構築 | [system_building_templates](command-templates/system_building_templates.md) |
| プロジェクト管理 | [project_management_templates](command-templates/project_management_templates.md) |
| タスク管理 | [task_management_templates](command-templates/task_management_templates.md) |
| リサーチ | [research_templates](command-templates/Research_templates.md) |

### 内部リソース

- [CTX_command_templates](command-templates.md) - テンプレート集
- [CTX_execution_rules](execution-rules.md) - 実行ルール
- [AIPO System](../README.md) - AIPOシステム全体

---

**作成日**: 2025-12-07
**最終更新**: 2026-01-20
**ステータス**: IDE版リファクタリング完了
