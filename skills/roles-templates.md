---
name: roles-templates
description: "専門家ロールテンプレート集（PM、Architect、Content Strategist等）"
license: "MIT"
---

# CTX_roles_templates

最終更新日時: 2025年12月29日 16:35

# ロールテンプレート集（Roles Templates）（Roles Templates）

**Claude Code Skillsとの対応**: このコンテキストはClaude Code SkillsのLevel 2（戦略・ドメイン知識）に相当します。

<aside>
💡

**Purpose**

[/aipo/01_sense](.cursor/commands/aipo/01_sense.md) のSense段階で使用される、専門家ロール（視点）のテンプレート集です。

Goalの性質に応じて適切なロールを選択することで、以降のタスク分解において質の高い判断が可能になります。

</aside>

---

## 📚 利用可能なロール

各ロールはSkills形式で定義されており、分解原則・フェーズ構造・重要な考慮事項を含みます。

[product_manager_focus](roles-templates/product_manager_focus.md)

[system_architect_focus](roles-templates/system_architect_focus.md)

[content_strategist_focus](roles-templates/content_strategist_focus.md)

[generic_focus](roles-templates/generic_focus.md)

## 🔄 使用方法

### 1. 自動選択（推奨）

[/aipo/01_sense](.cursor/commands/aipo/01_sense.md) がGoalの性質から自動判定し、最適なロールを提案します。

### 2. 明示指定

ユーザーが特定のロールを指定することも可能：

```jsx
@CMD_aipo_01_init を実行してください
GOAL: 新サービス開発
Role: Product Manager
```

---

## 🛠️ ロールの追加方法

新しいロールを追加する場合：

1. このページ配下に新しいロールページを作成
2. Skills形式で以下を定義：
    - name: ロール名
    - description: 概要
    - applicable_goals: 適用可能なGoal
    - decomposition_principles: 分解原則
    - phase_structure: フェーズ構造
    - key_considerations: 重要な考慮事項
3. [/aipo/01_sense](.cursor/commands/aipo/01_sense.md) のロール判定ロジックに追加

---

**作成日**: 2025-12-29

**ステータス**: Active