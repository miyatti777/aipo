# CMD_sys_03_API設計

最終更新日時: 2026年1月20日

# API設計・実装テンプレート

> **RESTful API / GraphQL の設計から実装まで**

---

## 🎯 このテンプレートでできること

- API設計（エンドポイント定義）
- OpenAPI仕様書作成
- リクエスト/レスポンス型定義
- 認証・認可設計
- エラーハンドリング設計

---

## 📋 実行前の質問（必須回答）

### 1. API種別
- REST API
- GraphQL
- tRPC
- gRPC

### 2. 認証方式
- JWT（Bearer Token）
- Session Cookie
- API Key
- OAuth 2.0

### 3. 対象リソース
- 管理するリソース名
- 各リソースの操作（CRUD等）

---

## 🔄 実行手順

### Phase 1: エンドポイント設計（20分）

```yaml
実行内容:
  - リソース一覧の作成
  - HTTPメソッド定義
  - URLパス設計
  - クエリパラメータ定義

成果物:
  - docs/api/endpoints.md
```

**AIの動作:**
```
📡 APIエンドポイントを設計します

【認証】
POST   /api/auth/register    # ユーザー登録
POST   /api/auth/login       # ログイン
POST   /api/auth/logout      # ログアウト
GET    /api/auth/me          # 現在のユーザー取得

【ユーザー】
GET    /api/users            # ユーザー一覧
GET    /api/users/:id        # ユーザー詳細
PATCH  /api/users/:id        # ユーザー更新
DELETE /api/users/:id        # ユーザー削除

【プロジェクト】
GET    /api/projects                    # プロジェクト一覧
POST   /api/projects                    # プロジェクト作成
GET    /api/projects/:id                # プロジェクト詳細
PATCH  /api/projects/:id                # プロジェクト更新
DELETE /api/projects/:id                # プロジェクト削除
GET    /api/projects/:id/tasks          # タスク一覧

【タスク】
GET    /api/tasks            # タスク一覧（フィルタ対応）
POST   /api/tasks            # タスク作成
GET    /api/tasks/:id        # タスク詳細
PATCH  /api/tasks/:id        # タスク更新
DELETE /api/tasks/:id        # タスク削除

この設計で進めますか？
```

---

### Phase 2: OpenAPI仕様書作成（30分）

```yaml
実行内容:
  - スキーマ定義
  - リクエスト/レスポンス型
  - エラーレスポンス定義
  - 認証スキーム定義

成果物:
  - docs/api/openapi.yaml
```

**AIの動作:**
```yaml
# docs/api/openapi.yaml
openapi: 3.0.3
info:
  title: Project Management API
  version: 1.0.0
  description: プロジェクト管理システムのAPI

servers:
  - url: http://localhost:3000/api
    description: Development
  - url: https://api.example.com
    description: Production

security:
  - bearerAuth: []

paths:
  /auth/login:
    post:
      tags: [Auth]
      summary: ログイン
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [email, password]
              properties:
                email:
                  type: string
                  format: email
                password:
                  type: string
                  minLength: 8
      responses:
        '200':
          description: ログイン成功
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthResponse'
        '401':
          $ref: '#/components/responses/Unauthorized'

  /projects:
    get:
      tags: [Projects]
      summary: プロジェクト一覧取得
      parameters:
        - name: status
          in: query
          schema:
            type: string
            enum: [DRAFT, ACTIVE, ARCHIVED]
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
      responses:
        '200':
          description: 成功
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProjectListResponse'

    post:
      tags: [Projects]
      summary: プロジェクト作成
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateProjectInput'
      responses:
        '201':
          description: 作成成功
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Project'

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        name:
          type: string
        role:
          type: string
          enum: [ADMIN, USER]
        createdAt:
          type: string
          format: date-time

    Project:
      type: object
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
        description:
          type: string
          nullable: true
        status:
          type: string
          enum: [DRAFT, ACTIVE, ARCHIVED]
        owner:
          $ref: '#/components/schemas/User'
        createdAt:
          type: string
          format: date-time

    CreateProjectInput:
      type: object
      required: [name]
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 100
        description:
          type: string
          maxLength: 1000

    Error:
      type: object
      properties:
        code:
          type: string
        message:
          type: string
        details:
          type: object

  responses:
    Unauthorized:
      description: 認証エラー
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
    NotFound:
      description: リソースが見つかりません
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
```

---

### Phase 3: 型定義・バリデーション（15分）

```yaml
実行内容:
  - TypeScript型定義
  - Zodスキーマ定義
  - バリデーションルール

成果物:
  - src/types/api.ts
  - src/lib/validations/
```

**AIの動作:**
```typescript
// src/types/api.ts
import { z } from 'zod'

// === Auth ===
export const loginSchema = z.object({
  email: z.string().email('有効なメールアドレスを入力してください'),
  password: z.string().min(8, 'パスワードは8文字以上です'),
})
export type LoginInput = z.infer<typeof loginSchema>

// === Project ===
export const createProjectSchema = z.object({
  name: z.string().min(1).max(100),
  description: z.string().max(1000).optional(),
})
export type CreateProjectInput = z.infer<typeof createProjectSchema>

export const updateProjectSchema = createProjectSchema.partial()
export type UpdateProjectInput = z.infer<typeof updateProjectSchema>

export const projectQuerySchema = z.object({
  status: z.enum(['DRAFT', 'ACTIVE', 'ARCHIVED']).optional(),
  page: z.coerce.number().int().positive().default(1),
  limit: z.coerce.number().int().positive().max(100).default(20),
})
export type ProjectQuery = z.infer<typeof projectQuerySchema>

// === Task ===
export const createTaskSchema = z.object({
  title: z.string().min(1).max(200),
  content: z.string().max(10000).optional(),
  projectId: z.string().uuid(),
  assigneeId: z.string().uuid().optional(),
  dueDate: z.coerce.date().optional(),
})
export type CreateTaskInput = z.infer<typeof createTaskSchema>

// === Response Types ===
export interface PaginatedResponse<T> {
  data: T[]
  meta: {
    total: number
    page: number
    limit: number
    totalPages: number
  }
}

export interface ApiError {
  code: string
  message: string
  details?: Record<string, unknown>
}
```

---

### Phase 4: エラーハンドリング設計（10分）

```yaml
実行内容:
  - エラーコード体系の設計
  - HTTPステータスコードマッピング
  - エラーレスポンス形式の統一

成果物:
  - src/lib/errors.ts
  - docs/api/error-codes.md
```

**AIの動作:**
```typescript
// src/lib/errors.ts
export class AppError extends Error {
  constructor(
    public code: string,
    message: string,
    public statusCode: number = 500,
    public details?: Record<string, unknown>
  ) {
    super(message)
    this.name = 'AppError'
  }
}

// エラーコード定義
export const ErrorCodes = {
  // 認証系 (AUTH_xxx)
  AUTH_INVALID_CREDENTIALS: 'AUTH_INVALID_CREDENTIALS',
  AUTH_TOKEN_EXPIRED: 'AUTH_TOKEN_EXPIRED',
  AUTH_UNAUTHORIZED: 'AUTH_UNAUTHORIZED',
  AUTH_FORBIDDEN: 'AUTH_FORBIDDEN',

  // バリデーション系 (VALIDATION_xxx)
  VALIDATION_FAILED: 'VALIDATION_FAILED',
  VALIDATION_REQUIRED: 'VALIDATION_REQUIRED',

  // リソース系 (RESOURCE_xxx)
  RESOURCE_NOT_FOUND: 'RESOURCE_NOT_FOUND',
  RESOURCE_ALREADY_EXISTS: 'RESOURCE_ALREADY_EXISTS',
  RESOURCE_CONFLICT: 'RESOURCE_CONFLICT',

  // サーバー系 (SERVER_xxx)
  SERVER_INTERNAL_ERROR: 'SERVER_INTERNAL_ERROR',
  SERVER_SERVICE_UNAVAILABLE: 'SERVER_SERVICE_UNAVAILABLE',
} as const

// エラーファクトリ
export const createError = {
  unauthorized: (message = '認証が必要です') =>
    new AppError(ErrorCodes.AUTH_UNAUTHORIZED, message, 401),
  
  forbidden: (message = 'アクセス権限がありません') =>
    new AppError(ErrorCodes.AUTH_FORBIDDEN, message, 403),
  
  notFound: (resource: string) =>
    new AppError(ErrorCodes.RESOURCE_NOT_FOUND, `${resource}が見つかりません`, 404),
  
  validation: (details: Record<string, string[]>) =>
    new AppError(ErrorCodes.VALIDATION_FAILED, 'バリデーションエラー', 400, details),
  
  conflict: (message: string) =>
    new AppError(ErrorCodes.RESOURCE_CONFLICT, message, 409),
}
```

---

### Phase 5: APIルーター実装（15分）

```yaml
実行内容:
  - ルーター構造の作成
  - ミドルウェア設定
  - コントローラー雛形

成果物:
  - src/app/api/ または src/routes/
```

---

## ✅ 完了条件チェックリスト

- [ ] エンドポイント一覧が完成している
- [ ] OpenAPI仕様書が作成されている
- [ ] 型定義・バリデーションが実装されている
- [ ] エラーハンドリングが統一されている
- [ ] 認証・認可が設計されている

---

## 💡 RESTful API設計原則

| 原則 | 説明 |
|------|------|
| リソース指向 | URLはリソースを表す名詞で構成 |
| HTTPメソッド | GET(取得), POST(作成), PUT/PATCH(更新), DELETE(削除) |
| ステータスコード | 200(成功), 201(作成), 400(バリデーション), 401(認証), 404(未発見) |
| 一貫性 | 命名規則、レスポンス形式を統一 |
| バージョニング | /api/v1/ または Accept-Version ヘッダー |

---

## 🔗 関連テンプレート

- [CMD_sys_02_データベース設計](./CMD_sys_02_データベース設計.md)
- [CMD_sys_04_フロントエンド設計](./CMD_sys_04_フロントエンド設計.md)
- [CMD_sys_05_バックエンド実装](./CMD_sys_05_バックエンド実装.md)

---

**作成日**: 2026-01-20
**カテゴリ**: システム構築
**タスクタイプ**: design
