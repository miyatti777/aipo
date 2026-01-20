# CMD_sys_04_フロントエンド設計

最終更新日時: 2026年1月20日

# フロントエンド設計・実装テンプレート

> **UIコンポーネント設計から状態管理まで**

---

## 🎯 このテンプレートでできること

- 画面設計・ワイヤーフレーム作成
- コンポーネント設計（Atomic Design等）
- 状態管理設計
- ルーティング設計
- スタイリング方針決定

---

## 📋 実行前の質問（必須回答）

### 1. フレームワーク
- React / Next.js
- Vue / Nuxt
- その他

### 2. スタイリング
- Tailwind CSS（推奨）
- CSS Modules
- styled-components
- その他

### 3. UIライブラリ
- shadcn/ui（推奨）
- Radix UI
- Chakra UI
- MUI
- なし（フルスクラッチ）

### 4. 状態管理
- React Query / TanStack Query（サーバー状態）
- Zustand / Jotai（クライアント状態）
- Redux Toolkit
- Context API

---

## 🔄 実行手順

### Phase 1: 画面一覧・ルーティング設計（15分）

```yaml
実行内容:
  - 画面一覧の作成
  - URLルーティング設計
  - レイアウト構造定義
  - 認証要否の定義

成果物:
  - docs/frontend/pages.md
  - docs/frontend/routing.md
```

**AIの動作:**
```
📱 画面一覧を設計します

【認証系】
/login           # ログイン画面（Public）
/register        # ユーザー登録画面（Public）
/forgot-password # パスワードリセット（Public）

【ダッシュボード】
/                # ダッシュボード（Private）
/projects        # プロジェクト一覧（Private）
/projects/:id    # プロジェクト詳細（Private）
/tasks           # タスク一覧（Private）
/tasks/:id       # タスク詳細（Private）

【設定系】
/settings           # 設定トップ（Private）
/settings/profile   # プロフィール設定（Private）
/settings/team      # チーム設定（Private, Admin）

【レイアウト構造】
- RootLayout（全体）
  - AuthLayout（認証画面用）
  - AppLayout（ログイン後）
    - Sidebar
    - Header
    - MainContent

この構成で進めますか？
```

---

### Phase 2: コンポーネント設計（25分）

```yaml
実行内容:
  - コンポーネント階層設計
  - Props定義
  - 再利用可能なコンポーネント特定
  - コンポーネントカタログ作成

成果物:
  - docs/frontend/components.md
  - src/components/（コンポーネント実装）
```

**AIの動作:**
```
🧩 コンポーネント構造を設計します

【ディレクトリ構造】
src/components/
├── ui/                    # 基本UIコンポーネント（shadcn/ui）
│   ├── button.tsx
│   ├── input.tsx
│   ├── card.tsx
│   ├── dialog.tsx
│   └── ...
│
├── layouts/               # レイアウトコンポーネント
│   ├── app-layout.tsx
│   ├── auth-layout.tsx
│   ├── sidebar.tsx
│   └── header.tsx
│
├── features/              # 機能別コンポーネント
│   ├── auth/
│   │   ├── login-form.tsx
│   │   └── register-form.tsx
│   ├── projects/
│   │   ├── project-card.tsx
│   │   ├── project-list.tsx
│   │   └── project-form.tsx
│   └── tasks/
│       ├── task-card.tsx
│       ├── task-list.tsx
│       ├── task-form.tsx
│       └── task-board.tsx
│
└── shared/                # 共通コンポーネント
    ├── loading-spinner.tsx
    ├── error-boundary.tsx
    ├── empty-state.tsx
    └── pagination.tsx
```

---

### Phase 3: 状態管理設計（15分）

```yaml
実行内容:
  - サーバー状態管理（React Query）
  - クライアント状態管理（Zustand）
  - 状態の分類と配置

成果物:
  - src/lib/api/
  - src/stores/
  - src/hooks/
```

**AIの動作:**
```typescript
// === サーバー状態管理（React Query） ===

// src/lib/api/projects.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { api } from './client'

export const projectKeys = {
  all: ['projects'] as const,
  lists: () => [...projectKeys.all, 'list'] as const,
  list: (filters: ProjectFilters) => [...projectKeys.lists(), filters] as const,
  details: () => [...projectKeys.all, 'detail'] as const,
  detail: (id: string) => [...projectKeys.details(), id] as const,
}

export function useProjects(filters: ProjectFilters) {
  return useQuery({
    queryKey: projectKeys.list(filters),
    queryFn: () => api.projects.list(filters),
  })
}

export function useProject(id: string) {
  return useQuery({
    queryKey: projectKeys.detail(id),
    queryFn: () => api.projects.get(id),
    enabled: !!id,
  })
}

export function useCreateProject() {
  const queryClient = useQueryClient()
  
  return useMutation({
    mutationFn: api.projects.create,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: projectKeys.lists() })
    },
  })
}

// === クライアント状態管理（Zustand） ===

// src/stores/ui-store.ts
import { create } from 'zustand'

interface UIState {
  sidebarOpen: boolean
  toggleSidebar: () => void
  setSidebarOpen: (open: boolean) => void
}

export const useUIStore = create<UIState>((set) => ({
  sidebarOpen: true,
  toggleSidebar: () => set((state) => ({ sidebarOpen: !state.sidebarOpen })),
  setSidebarOpen: (open) => set({ sidebarOpen: open }),
}))

// src/stores/filter-store.ts
interface FilterState {
  projectFilter: ProjectFilters
  taskFilter: TaskFilters
  setProjectFilter: (filter: Partial<ProjectFilters>) => void
  setTaskFilter: (filter: Partial<TaskFilters>) => void
  resetFilters: () => void
}

export const useFilterStore = create<FilterState>((set) => ({
  projectFilter: { status: undefined, page: 1, limit: 20 },
  taskFilter: { status: undefined, assigneeId: undefined },
  setProjectFilter: (filter) =>
    set((state) => ({ projectFilter: { ...state.projectFilter, ...filter } })),
  setTaskFilter: (filter) =>
    set((state) => ({ taskFilter: { ...state.taskFilter, ...filter } })),
  resetFilters: () =>
    set({
      projectFilter: { status: undefined, page: 1, limit: 20 },
      taskFilter: { status: undefined, assigneeId: undefined },
    }),
}))
```

---

### Phase 4: フォーム・バリデーション実装（15分）

```yaml
実行内容:
  - react-hook-form設定
  - Zodスキーマ統合
  - エラー表示コンポーネント

成果物:
  - src/components/features/*/forms/
```

**AIの動作:**
```typescript
// src/components/features/projects/project-form.tsx
'use client'

import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { createProjectSchema, type CreateProjectInput } from '@/types/api'
import { useCreateProject } from '@/lib/api/projects'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'

interface ProjectFormProps {
  onSuccess?: () => void
}

export function ProjectForm({ onSuccess }: ProjectFormProps) {
  const createProject = useCreateProject()
  
  const form = useForm<CreateProjectInput>({
    resolver: zodResolver(createProjectSchema),
    defaultValues: {
      name: '',
      description: '',
    },
  })

  const onSubmit = async (data: CreateProjectInput) => {
    try {
      await createProject.mutateAsync(data)
      form.reset()
      onSuccess?.()
    } catch (error) {
      // エラーハンドリング
    }
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
        <FormField
          control={form.control}
          name="name"
          render={({ field }) => (
            <FormItem>
              <FormLabel>プロジェクト名</FormLabel>
              <FormControl>
                <Input placeholder="プロジェクト名を入力" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        
        <FormField
          control={form.control}
          name="description"
          render={({ field }) => (
            <FormItem>
              <FormLabel>説明</FormLabel>
              <FormControl>
                <Textarea placeholder="説明を入力（任意）" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        
        <Button type="submit" disabled={createProject.isPending}>
          {createProject.isPending ? '作成中...' : '作成'}
        </Button>
      </form>
    </Form>
  )
}
```

---

### Phase 5: レイアウト・ナビゲーション実装（10分）

```yaml
実行内容:
  - レイアウトコンポーネント作成
  - ナビゲーション実装
  - レスポンシブ対応

成果物:
  - src/components/layouts/
  - src/app/layout.tsx
```

---

## ✅ 完了条件チェックリスト

- [ ] 画面一覧・ルーティングが定義されている
- [ ] コンポーネント構造が設計されている
- [ ] 状態管理方針が決定している
- [ ] フォーム・バリデーションが実装されている
- [ ] レイアウトが実装されている
- [ ] レスポンシブ対応されている

---

## 💡 推奨ディレクトリ構造（Next.js App Router）

```
src/
├── app/                    # App Router
│   ├── (auth)/            # 認証グループ
│   │   ├── login/
│   │   └── register/
│   ├── (dashboard)/       # メイングループ
│   │   ├── projects/
│   │   ├── tasks/
│   │   └── settings/
│   ├── layout.tsx
│   └── page.tsx
├── components/             # コンポーネント
├── lib/                    # ユーティリティ
│   ├── api/               # API関連
│   └── utils/             # ヘルパー関数
├── stores/                 # 状態管理
├── hooks/                  # カスタムフック
├── types/                  # 型定義
└── styles/                 # グローバルスタイル
```

---

## 🔗 関連テンプレート

- [CMD_sys_03_API設計](./CMD_sys_03_API設計.md)
- [CMD_sys_05_バックエンド実装](./CMD_sys_05_バックエンド実装.md)
- [CMD_sys_06_テスト設計](./CMD_sys_06_テスト設計.md)

---

**作成日**: 2026-01-20
**カテゴリ**: システム構築
**タスクタイプ**: implementation
