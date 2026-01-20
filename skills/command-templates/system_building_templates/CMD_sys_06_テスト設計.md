# CMD_sys_06_テスト設計

最終更新日時: 2026年1月20日

# テスト設計・実装テンプレート

> **単体テストからE2Eテストまで**

---

## 🎯 このテンプレートでできること

- テスト戦略の策定
- 単体テスト実装
- 統合テスト実装
- E2Eテスト実装
- テストカバレッジ管理

---

## 📋 実行前の質問（必須回答）

### 1. テストフレームワーク
- Vitest（推奨）
- Jest
- その他

### 2. E2Eツール
- Playwright（推奨）
- Cypress
- なし

### 3. テスト対象
- 単体テスト対象（Services, Utils等）
- 統合テスト対象（API Routes等）
- E2Eテスト対象（主要フロー）

---

## 🔄 実行手順

### Phase 1: テスト戦略策定（10分）

```yaml
実行内容:
  - テストピラミッドの定義
  - カバレッジ目標設定
  - テスト環境設計

成果物:
  - docs/testing/strategy.md
```

**AIの動作:**
```
🧪 テスト戦略を策定します

【テストピラミッド】
┌─────────────────────────────┐
│      E2E Tests (10%)        │  ← 重要フローのみ
├─────────────────────────────┤
│   Integration Tests (30%)    │  ← API/DB連携
├─────────────────────────────┤
│     Unit Tests (60%)         │  ← ビジネスロジック
└─────────────────────────────┘

【カバレッジ目標】
- 全体: 80%以上
- サービス層: 90%以上
- リポジトリ層: 80%以上
- APIルート: 70%以上

【テスト環境】
- Unit/Integration: Vitest + テストDB（SQLite）
- E2E: Playwright + 開発サーバー

この戦略で進めますか？
```

---

### Phase 2: テスト環境セットアップ（15分）

```yaml
実行内容:
  - Vitestセットアップ
  - テストDBセットアップ
  - モック・スタブ準備
  - CI/CD統合

成果物:
  - vitest.config.ts
  - tests/setup.ts
  - tests/helpers/
```

**AIの動作:**
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths'

export default defineConfig({
  plugins: [react(), tsconfigPaths()],
  test: {
    environment: 'node',
    globals: true,
    setupFiles: ['./tests/setup.ts'],
    include: ['**/*.{test,spec}.{js,ts,tsx}'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html', 'lcov'],
      exclude: [
        'node_modules/',
        'tests/',
        '**/*.d.ts',
        '**/*.config.*',
      ],
      thresholds: {
        global: {
          branches: 80,
          functions: 80,
          lines: 80,
          statements: 80,
        },
      },
    },
  },
})

// tests/setup.ts
import { beforeAll, afterAll, beforeEach, afterEach } from 'vitest'
import { PrismaClient } from '@prisma/client'
import { mockDeep, mockReset } from 'vitest-mock-extended'

// Prismaモック
export const prismaMock = mockDeep<PrismaClient>()

vi.mock('@/lib/db', () => ({
  prisma: prismaMock,
}))

beforeEach(() => {
  mockReset(prismaMock)
})

// tests/helpers/factories.ts
import { User, Project, Task } from '@prisma/client'
import { faker } from '@faker-js/faker'

export const createMockUser = (overrides?: Partial<User>): User => ({
  id: faker.string.uuid(),
  email: faker.internet.email(),
  name: faker.person.fullName(),
  role: 'USER',
  createdAt: new Date(),
  updatedAt: new Date(),
  ...overrides,
})

export const createMockProject = (overrides?: Partial<Project>): Project => ({
  id: faker.string.uuid(),
  name: faker.company.name(),
  description: faker.lorem.paragraph(),
  status: 'ACTIVE',
  ownerId: faker.string.uuid(),
  createdAt: new Date(),
  updatedAt: new Date(),
  ...overrides,
})

export const createMockTask = (overrides?: Partial<Task>): Task => ({
  id: faker.string.uuid(),
  title: faker.lorem.sentence(),
  content: faker.lorem.paragraphs(),
  status: 'TODO',
  projectId: faker.string.uuid(),
  assigneeId: null,
  dueDate: null,
  createdAt: new Date(),
  updatedAt: new Date(),
  ...overrides,
})
```

---

### Phase 3: 単体テスト実装（25分）

```yaml
実行内容:
  - サービス層のテスト
  - ユーティリティのテスト
  - バリデーションのテスト

成果物:
  - tests/unit/services/
  - tests/unit/lib/
```

**AIの動作:**
```typescript
// tests/unit/services/project.service.test.ts
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { ProjectService } from '@/services/project.service'
import { projectRepository } from '@/repositories/project.repository'
import { createMockUser, createMockProject } from '../../helpers/factories'
import { AppError } from '@/lib/errors'

vi.mock('@/repositories/project.repository')

describe('ProjectService', () => {
  let service: ProjectService
  const mockUser = createMockUser()
  const mockProject = createMockProject({ ownerId: mockUser.id })

  beforeEach(() => {
    service = new ProjectService()
    vi.clearAllMocks()
  })

  describe('getById', () => {
    it('プロジェクトを取得できる', async () => {
      vi.mocked(projectRepository.findById).mockResolvedValue(mockProject)

      const result = await service.getById(mockProject.id, mockUser.id)

      expect(result).toEqual(mockProject)
      expect(projectRepository.findById).toHaveBeenCalledWith(mockProject.id)
    })

    it('存在しないプロジェクトでエラー', async () => {
      vi.mocked(projectRepository.findById).mockResolvedValue(null)

      await expect(
        service.getById('non-existent', mockUser.id)
      ).rejects.toThrow(AppError)
    })

    it('他ユーザーのプロジェクトでエラー', async () => {
      vi.mocked(projectRepository.findById).mockResolvedValue(mockProject)

      await expect(
        service.getById(mockProject.id, 'other-user-id')
      ).rejects.toThrow('アクセス権限がありません')
    })
  })

  describe('create', () => {
    it('プロジェクトを作成できる', async () => {
      vi.mocked(projectRepository.findMany).mockResolvedValue([])
      vi.mocked(projectRepository.create).mockResolvedValue(mockProject)

      const result = await service.create(
        { name: 'Test Project', description: 'Test' },
        mockUser.id
      )

      expect(result).toEqual(mockProject)
      expect(projectRepository.create).toHaveBeenCalled()
    })

    it('上限を超えるとエラー', async () => {
      const existingProjects = Array(5).fill(mockProject)
      vi.mocked(projectRepository.findMany).mockResolvedValue(existingProjects)

      await expect(
        service.create({ name: 'New Project' }, mockUser.id)
      ).rejects.toThrow('上限に達しています')
    })
  })

  describe('update', () => {
    it('プロジェクトを更新できる', async () => {
      vi.mocked(projectRepository.findById).mockResolvedValue(mockProject)
      vi.mocked(projectRepository.update).mockResolvedValue({
        ...mockProject,
        name: 'Updated Name',
      })

      const result = await service.update(
        mockProject.id,
        { name: 'Updated Name' },
        mockUser.id
      )

      expect(result.name).toBe('Updated Name')
    })
  })

  describe('delete', () => {
    it('プロジェクトを削除できる', async () => {
      vi.mocked(projectRepository.findById).mockResolvedValue(mockProject)
      vi.mocked(projectRepository.delete).mockResolvedValue()

      await expect(
        service.delete(mockProject.id, mockUser.id)
      ).resolves.not.toThrow()

      expect(projectRepository.delete).toHaveBeenCalledWith(mockProject.id)
    })
  })
})
```

---

### Phase 4: 統合テスト実装（20分）

```yaml
実行内容:
  - APIルートのテスト
  - DB統合テスト
  - 認証フローテスト

成果物:
  - tests/integration/api/
```

**AIの動作:**
```typescript
// tests/integration/api/projects.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { createServer } from 'http'
import { NextRequest } from 'next/server'
import { GET, POST } from '@/app/api/projects/route'
import { prisma } from '@/lib/db'
import { createMockUser } from '../../helpers/factories'

// テストユーザーの認証をモック
vi.mock('next-auth', () => ({
  getServerSession: vi.fn(),
}))

describe('Projects API', () => {
  let testUser: any

  beforeAll(async () => {
    // テストユーザー作成
    testUser = await prisma.user.create({
      data: createMockUser(),
    })
  })

  afterAll(async () => {
    // クリーンアップ
    await prisma.project.deleteMany({ where: { ownerId: testUser.id } })
    await prisma.user.delete({ where: { id: testUser.id } })
  })

  describe('GET /api/projects', () => {
    it('プロジェクト一覧を取得できる', async () => {
      const { getServerSession } = await import('next-auth')
      vi.mocked(getServerSession).mockResolvedValue({
        user: { id: testUser.id },
      })

      const request = new NextRequest('http://localhost/api/projects')
      const response = await GET(request)
      const data = await response.json()

      expect(response.status).toBe(200)
      expect(Array.isArray(data.data)).toBe(true)
    })

    it('未認証だと401エラー', async () => {
      const { getServerSession } = await import('next-auth')
      vi.mocked(getServerSession).mockResolvedValue(null)

      const request = new NextRequest('http://localhost/api/projects')
      const response = await GET(request)

      expect(response.status).toBe(401)
    })
  })

  describe('POST /api/projects', () => {
    it('プロジェクトを作成できる', async () => {
      const { getServerSession } = await import('next-auth')
      vi.mocked(getServerSession).mockResolvedValue({
        user: { id: testUser.id },
      })

      const request = new NextRequest('http://localhost/api/projects', {
        method: 'POST',
        body: JSON.stringify({
          name: 'Test Project',
          description: 'Test Description',
        }),
      })

      const response = await POST(request)
      const data = await response.json()

      expect(response.status).toBe(201)
      expect(data.name).toBe('Test Project')
    })

    it('バリデーションエラーで400', async () => {
      const { getServerSession } = await import('next-auth')
      vi.mocked(getServerSession).mockResolvedValue({
        user: { id: testUser.id },
      })

      const request = new NextRequest('http://localhost/api/projects', {
        method: 'POST',
        body: JSON.stringify({ name: '' }), // 空の名前
      })

      const response = await POST(request)

      expect(response.status).toBe(400)
    })
  })
})
```

---

### Phase 5: E2Eテスト実装（15分）

```yaml
実行内容:
  - Playwrightセットアップ
  - 主要フローのテスト
  - CI統合

成果物:
  - playwright.config.ts
  - tests/e2e/
```

**AIの動作:**
```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test'

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
})

// tests/e2e/auth.spec.ts
import { test, expect } from '@playwright/test'

test.describe('認証フロー', () => {
  test('ログインできる', async ({ page }) => {
    await page.goto('/login')

    await page.fill('input[name="email"]', 'test@example.com')
    await page.fill('input[name="password"]', 'password123')
    await page.click('button[type="submit"]')

    await expect(page).toHaveURL('/')
    await expect(page.locator('text=ダッシュボード')).toBeVisible()
  })

  test('無効な認証情報でエラー表示', async ({ page }) => {
    await page.goto('/login')

    await page.fill('input[name="email"]', 'wrong@example.com')
    await page.fill('input[name="password"]', 'wrongpassword')
    await page.click('button[type="submit"]')

    await expect(page.locator('text=メールアドレスまたはパスワードが正しくありません')).toBeVisible()
  })
})

// tests/e2e/projects.spec.ts
import { test, expect } from '@playwright/test'

test.describe('プロジェクト管理', () => {
  test.beforeEach(async ({ page }) => {
    // ログイン
    await page.goto('/login')
    await page.fill('input[name="email"]', 'test@example.com')
    await page.fill('input[name="password"]', 'password123')
    await page.click('button[type="submit"]')
    await page.waitForURL('/')
  })

  test('プロジェクトを作成できる', async ({ page }) => {
    await page.goto('/projects')
    await page.click('button:has-text("新規プロジェクト")')

    await page.fill('input[name="name"]', 'E2E Test Project')
    await page.fill('textarea[name="description"]', 'This is a test project')
    await page.click('button[type="submit"]')

    await expect(page.locator('text=E2E Test Project')).toBeVisible()
  })

  test('プロジェクト一覧が表示される', async ({ page }) => {
    await page.goto('/projects')

    await expect(page.locator('[data-testid="project-list"]')).toBeVisible()
  })
})
```

---

## ✅ 完了条件チェックリスト

- [ ] テスト戦略が文書化されている
- [ ] 単体テストが実装されている（カバレッジ80%以上）
- [ ] 統合テストが実装されている
- [ ] E2Eテストが主要フローをカバーしている
- [ ] CIで自動実行される設定がある

---

## 💡 テスト命名規則

```typescript
// 推奨: 日本語で何をテストしているか明確に
describe('ProjectService', () => {
  describe('getById', () => {
    it('プロジェクトを取得できる', ...)
    it('存在しないプロジェクトでエラー', ...)
    it('他ユーザーのプロジェクトでエラー', ...)
  })
})
```

---

## 🔗 関連テンプレート

- [CMD_sys_05_バックエンド実装](./CMD_sys_05_バックエンド実装.md)
- [CMD_sys_07_デプロイ設計](./CMD_sys_07_デプロイ設計.md)

---

**作成日**: 2026-01-20
**カテゴリ**: システム構築
**タスクタイプ**: implementation
