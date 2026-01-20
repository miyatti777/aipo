# CMD_sys_05_バックエンド実装

最終更新日時: 2026年1月20日

# バックエンド実装テンプレート

> **サービス層からリポジトリパターンまで**

---

## 🎯 このテンプレートでできること

- ビジネスロジック実装
- サービス層設計
- リポジトリパターン実装
- ミドルウェア実装
- 外部サービス連携

---

## 📋 実行前の質問（必須回答）

### 1. アーキテクチャパターン
- レイヤードアーキテクチャ
- クリーンアーキテクチャ
- シンプルMVC

### 2. フレームワーク
- Next.js API Routes / Server Actions
- Express / Fastify
- NestJS
- Hono

### 3. 実装対象機能
- 対象エンティティ
- 主要なユースケース

---

## 🔄 実行手順

### Phase 1: ディレクトリ構造設計（10分）

```yaml
実行内容:
  - レイヤー構造の決定
  - ディレクトリ構成の作成
  - 依存関係の方向性確認

成果物:
  - docs/backend/structure.md
```

**AIの動作:**
```
📂 バックエンド構造を設計します

【レイヤードアーキテクチャ】
src/
├── app/                    # プレゼンテーション層
│   └── api/               # API Routes
│       ├── auth/
│       ├── projects/
│       └── tasks/
│
├── services/              # アプリケーション層
│   ├── auth.service.ts
│   ├── project.service.ts
│   └── task.service.ts
│
├── repositories/          # データアクセス層
│   ├── user.repository.ts
│   ├── project.repository.ts
│   └── task.repository.ts
│
├── lib/                   # インフラ層
│   ├── db.ts             # Prisma Client
│   ├── auth.ts           # 認証ユーティリティ
│   └── errors.ts         # エラーハンドリング
│
└── types/                 # 型定義
    └── index.ts

【依存関係の方向】
API Routes → Services → Repositories → Database
（上位層は下位層に依存、逆は禁止）

この構成で進めますか？
```

---

### Phase 2: リポジトリ層実装（20分）

```yaml
実行内容:
  - Prisma Clientのラッピング
  - CRUD操作の抽象化
  - トランザクション対応

成果物:
  - src/repositories/
```

**AIの動作:**
```typescript
// src/repositories/base.repository.ts
import { PrismaClient } from '@prisma/client'
import { prisma } from '@/lib/db'

export abstract class BaseRepository<T, CreateInput, UpdateInput> {
  protected prisma: PrismaClient = prisma

  abstract findById(id: string): Promise<T | null>
  abstract findMany(filters?: Record<string, unknown>): Promise<T[]>
  abstract create(data: CreateInput): Promise<T>
  abstract update(id: string, data: UpdateInput): Promise<T>
  abstract delete(id: string): Promise<void>
}

// src/repositories/project.repository.ts
import { Project, Prisma } from '@prisma/client'
import { BaseRepository } from './base.repository'

export interface ProjectFilters {
  ownerId?: string
  status?: string
  search?: string
}

export interface PaginatedResult<T> {
  data: T[]
  total: number
  page: number
  limit: number
}

export class ProjectRepository extends BaseRepository<
  Project,
  Prisma.ProjectCreateInput,
  Prisma.ProjectUpdateInput
> {
  async findById(id: string): Promise<Project | null> {
    return this.prisma.project.findUnique({
      where: { id },
      include: {
        owner: true,
        tasks: {
          orderBy: { createdAt: 'desc' },
        },
      },
    })
  }

  async findMany(filters: ProjectFilters = {}): Promise<Project[]> {
    const where: Prisma.ProjectWhereInput = {}

    if (filters.ownerId) {
      where.ownerId = filters.ownerId
    }
    if (filters.status) {
      where.status = filters.status as any
    }
    if (filters.search) {
      where.OR = [
        { name: { contains: filters.search, mode: 'insensitive' } },
        { description: { contains: filters.search, mode: 'insensitive' } },
      ]
    }

    return this.prisma.project.findMany({
      where,
      include: { owner: true },
      orderBy: { createdAt: 'desc' },
    })
  }

  async findManyPaginated(
    filters: ProjectFilters,
    page: number = 1,
    limit: number = 20
  ): Promise<PaginatedResult<Project>> {
    const where: Prisma.ProjectWhereInput = {}
    // ...フィルタ適用

    const [data, total] = await Promise.all([
      this.prisma.project.findMany({
        where,
        include: { owner: true },
        orderBy: { createdAt: 'desc' },
        skip: (page - 1) * limit,
        take: limit,
      }),
      this.prisma.project.count({ where }),
    ])

    return { data, total, page, limit }
  }

  async create(data: Prisma.ProjectCreateInput): Promise<Project> {
    return this.prisma.project.create({
      data,
      include: { owner: true },
    })
  }

  async update(id: string, data: Prisma.ProjectUpdateInput): Promise<Project> {
    return this.prisma.project.update({
      where: { id },
      data,
      include: { owner: true },
    })
  }

  async delete(id: string): Promise<void> {
    await this.prisma.project.delete({ where: { id } })
  }

  async existsById(id: string): Promise<boolean> {
    const count = await this.prisma.project.count({ where: { id } })
    return count > 0
  }
}

export const projectRepository = new ProjectRepository()
```

---

### Phase 3: サービス層実装（25分）

```yaml
実行内容:
  - ビジネスロジックの実装
  - バリデーション
  - トランザクション管理
  - 権限チェック

成果物:
  - src/services/
```

**AIの動作:**
```typescript
// src/services/project.service.ts
import { Project } from '@prisma/client'
import { projectRepository, ProjectFilters, PaginatedResult } from '@/repositories/project.repository'
import { CreateProjectInput, UpdateProjectInput } from '@/types/api'
import { createError } from '@/lib/errors'

export class ProjectService {
  async getById(id: string, userId: string): Promise<Project> {
    const project = await projectRepository.findById(id)
    
    if (!project) {
      throw createError.notFound('プロジェクト')
    }

    // アクセス権限チェック
    if (project.ownerId !== userId) {
      throw createError.forbidden('このプロジェクトへのアクセス権限がありません')
    }

    return project
  }

  async getList(
    userId: string,
    filters: ProjectFilters,
    page: number,
    limit: number
  ): Promise<PaginatedResult<Project>> {
    // ユーザーが所有するプロジェクトのみ取得
    const result = await projectRepository.findManyPaginated(
      { ...filters, ownerId: userId },
      page,
      limit
    )
    return result
  }

  async create(input: CreateProjectInput, userId: string): Promise<Project> {
    // ビジネスルールのバリデーション
    const existingProjects = await projectRepository.findMany({ ownerId: userId })
    
    // 例：無料プランは5プロジェクトまで
    if (existingProjects.length >= 5) {
      throw createError.forbidden('プロジェクト数の上限に達しています')
    }

    return projectRepository.create({
      name: input.name,
      description: input.description,
      owner: { connect: { id: userId } },
    })
  }

  async update(
    id: string,
    input: UpdateProjectInput,
    userId: string
  ): Promise<Project> {
    // 存在確認と権限チェック
    await this.getById(id, userId)

    return projectRepository.update(id, input)
  }

  async delete(id: string, userId: string): Promise<void> {
    // 存在確認と権限チェック
    await this.getById(id, userId)

    await projectRepository.delete(id)
  }

  async archive(id: string, userId: string): Promise<Project> {
    await this.getById(id, userId)

    return projectRepository.update(id, { status: 'ARCHIVED' })
  }
}

export const projectService = new ProjectService()
```

---

### Phase 4: APIルート実装（20分）

```yaml
実行内容:
  - ルートハンドラー実装
  - リクエスト/レスポンス処理
  - エラーハンドリング

成果物:
  - src/app/api/
```

**AIの動作:**
```typescript
// src/app/api/projects/route.ts
import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { projectService } from '@/services/project.service'
import { createProjectSchema, projectQuerySchema } from '@/types/api'
import { handleApiError } from '@/lib/api-utils'
import { authOptions } from '@/lib/auth'

// GET /api/projects
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session?.user?.id) {
      return NextResponse.json({ error: '認証が必要です' }, { status: 401 })
    }

    const searchParams = request.nextUrl.searchParams
    const query = projectQuerySchema.parse({
      status: searchParams.get('status'),
      page: searchParams.get('page'),
      limit: searchParams.get('limit'),
    })

    const result = await projectService.getList(
      session.user.id,
      { status: query.status },
      query.page,
      query.limit
    )

    return NextResponse.json(result)
  } catch (error) {
    return handleApiError(error)
  }
}

// POST /api/projects
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    if (!session?.user?.id) {
      return NextResponse.json({ error: '認証が必要です' }, { status: 401 })
    }

    const body = await request.json()
    const input = createProjectSchema.parse(body)

    const project = await projectService.create(input, session.user.id)

    return NextResponse.json(project, { status: 201 })
  } catch (error) {
    return handleApiError(error)
  }
}

// src/app/api/projects/[id]/route.ts
import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { projectService } from '@/services/project.service'
import { updateProjectSchema } from '@/types/api'
import { handleApiError } from '@/lib/api-utils'
import { authOptions } from '@/lib/auth'

interface Params {
  params: { id: string }
}

// GET /api/projects/:id
export async function GET(request: NextRequest, { params }: Params) {
  try {
    const session = await getServerSession(authOptions)
    if (!session?.user?.id) {
      return NextResponse.json({ error: '認証が必要です' }, { status: 401 })
    }

    const project = await projectService.getById(params.id, session.user.id)
    return NextResponse.json(project)
  } catch (error) {
    return handleApiError(error)
  }
}

// PATCH /api/projects/:id
export async function PATCH(request: NextRequest, { params }: Params) {
  try {
    const session = await getServerSession(authOptions)
    if (!session?.user?.id) {
      return NextResponse.json({ error: '認証が必要です' }, { status: 401 })
    }

    const body = await request.json()
    const input = updateProjectSchema.parse(body)

    const project = await projectService.update(params.id, input, session.user.id)
    return NextResponse.json(project)
  } catch (error) {
    return handleApiError(error)
  }
}

// DELETE /api/projects/:id
export async function DELETE(request: NextRequest, { params }: Params) {
  try {
    const session = await getServerSession(authOptions)
    if (!session?.user?.id) {
      return NextResponse.json({ error: '認証が必要です' }, { status: 401 })
    }

    await projectService.delete(params.id, session.user.id)
    return new NextResponse(null, { status: 204 })
  } catch (error) {
    return handleApiError(error)
  }
}
```

---

### Phase 5: ミドルウェア・ユーティリティ（10分）

```yaml
実行内容:
  - 認証ミドルウェア
  - ロギング
  - レート制限
  - APIユーティリティ

成果物:
  - src/middleware.ts
  - src/lib/api-utils.ts
```

---

## ✅ 完了条件チェックリスト

- [ ] リポジトリ層が実装されている
- [ ] サービス層が実装されている
- [ ] APIルートが実装されている
- [ ] エラーハンドリングが統一されている
- [ ] 認証・認可が実装されている
- [ ] 単体テストが作成されている

---

## 💡 ベストプラクティス

| 項目 | 推奨 |
|------|------|
| 依存性注入 | コンストラクタインジェクション or Factory |
| トランザクション | サービス層で管理 |
| エラーハンドリング | カスタムエラークラス + 統一ハンドラー |
| ログ | 構造化ログ（JSON形式） |
| バリデーション | Zodで入力検証 |

---

## 🔗 関連テンプレート

- [CMD_sys_02_データベース設計](./CMD_sys_02_データベース設計.md)
- [CMD_sys_03_API設計](./CMD_sys_03_API設計.md)
- [CMD_sys_06_テスト設計](./CMD_sys_06_テスト設計.md)

---

**作成日**: 2026-01-20
**カテゴリ**: システム構築
**タスクタイプ**: implementation
