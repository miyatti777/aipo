---
name: execution-rules
description: "aipo実行ルール - 全コマンド共通の振る舞いと成果物ページ構造標準"
license: "MIT"
---

# CTX_execution_rules

最終更新日時: 2025年12月25日 19:51

# aipo実行ルール - 全コマンド共通の振る舞い

<aside>
📌

**このページについて**

aipo_01〜05の全コマンドが従う共通の実行ルールを定義します。

</aside>

---

## 📐 成果物ページ構造標準

<aside>
🎨

**全Layerページの標準構造**

aipoで構築される全ての成果物ページ（Layer、SubLayer、Wiki、Dashboard等）は、以下の2層構造に従う：

1. **成果物セクション（上部）** - ユーザー向けコンテンツ（Wiki、DB、ガイド、レポート等）
2. **aipo管理セクション（下部）** - 実行管理ファイル群（**必ずトグルで折りたたみ**）
</aside>

### ページ構造テンプレート

```markdown
# [Layer名] (Layer ID)

<callout icon="🎯">
	**Goal**: [目標の一行要約]
	
	**対象**: [誰向けか] ｜ **Owner**: [owner] ｜ **期限**: [deadline]
</callout>

---

## 📊 [成果物セクション]

<!-- ユーザー向けコンテンツをここに配置 -->
<!-- 例: Wiki構造、Dashboard、Database、ガイド、レポート等 -->

### 主要な成果物

- <database>TaskDB</database>
- <page>運用ガイド</page>
- <page>FAQ</page>

### 関連リソース

- **関連Layer**: <mention-page>親Layer</mention-page>
- **参考資料**: [リンク]

---

<!-- ここからaipo管理セクション（必ずトグルで折りたたみ） -->

▶### 🔧 aipo管理（[Layer ID]）

	> **Layer ID**: [L001-SG1-X] ｜ **Parent**: [親Layer]
	> **Status**: [status] ｜ **Owner**: [owner] ｜ **Deadline**: [date]
	
	<page>layer.yaml</page>
	<page>context.yaml</page>
	<page>tasks.yaml</page>
	<page>variables.yaml</page>
	<page>Commands/</page>
```

### 成果物セクションの設計原則

<aside>
💡

**ユーザーファースト設計**

1. **最重要情報を最上部に** - Goal、対象、Owner、期限をCalloutで明示
2. **成果物を前面に** - Database、ドキュメント、ガイドを見やすく配置
3. **ナビゲーションを提供** - 関連Layerや参考資料へのリンク
4. **技術詳細は下に隠す** - aipo管理セクションは必ずトグルで折りたたむ
</aside>

### 具体例

**良い例**: [EXPLAZA](https://www.notion.so/EXPLAZA-71a5a102450a46f588cbe23ab79e3873?pvs=21)

- 成果物（各部門のDB、運用ガイド）が上部に整理されている
- aipo管理セクションが下部にトグルで折りたたまれている
- 一般ユーザーは成果物のみを見て使える構造

---

## 📄 aipo管理セクション標準

<aside>
📐

**全Layerページにおけるaipo管理セクションの配置ルール**

aipoで構築した全てのLayerページは、以下の構造に従う：

1. **成果物セクション（上部）** - ユーザー向けのコンテンツ（Wiki、DB、ガイドなど）
2. **aipo管理セクション（下部）** - プロジェクト管理用ファイル群（**必ずトグルで折りたたみ**）
</aside>

### aipo管理セクションのフォーマット

```markdown
▶### 🔧 aipo管理（[Layer ID]）
	> **Layer ID**: [L001-SG1-X] ｜ **Parent**: [親Layer]
	> **Status**: [active/ready/completed] ｜ **Owner**: [owner] ｜ **Deadline**: [date]
	<page>layer.yaml</page>
	<page>context.yaml</page>
	<page>tasks.yaml</page>
	<page>variables.yaml</page>
	<page>Commands/</page>
	<page>Context/</page>
```

### 必須配置ファイル

| ファイル/フォルダ | 説明 | 必須 | アイコン |
| --- | --- | --- | --- |
| **layer.yaml** | Layer定義（ID、Goal、mode、parentなど） | ✅ 必須 | 📋 |
| **context.yaml** | Context Index（Contextフォルダへのリンク + 要約） | ✅ 必須 | 📚 |
| **Context/** | Context実体（収集した情報を整理したドキュメント群） | ✅ 必須 | 📖 |
| **tasks.yaml** | タスク定義（task_id、title、description、commandなど） | ✅ 必須 | ✅ |
| **variables.yaml** | 抽出された変数（Abstract modeのみ） | ⭕ Abstract時 | 🔢 |
| **Commands/** | 各タスクの実行用コマンドページ（aipo_03で生成） | ⭕ タスク実行時 | ⚙️ |

<aside>
🎨

**📌 アイコン設定ルール**

全ての必須配置ファイル・フォルダは、ページ作成時に上記の標準アイコンを設定すること。

**理由：**

- 視覚的な識別性の向上
- ページの役割を一目で判断可能
- Layer構造全体の統一感の確保

**実装タイミング：**

- `aipo_01_init` - layer.yaml, context.yaml, Context/, tasks.yaml, variables.yaml作成時
- `aipo_03_discover` - Commands/およびコマンドページ作成時
</aside>

### Context情報の二層構造

<aside>
📚

**Context情報は以下の2つで構成されます：**

1. **Context/フォルダ（実体）** - 収集した情報を整理したドキュメント群
2. **context.yaml（Index）** - Context/フォルダへのリンク + 要約情報

**なぜこの構造が重要か：**

- SubLayerに継承したときに、詳細情報が失われない
- 親Layerで収集した情報を子Layerでも参照できる
- context.yamlはシンプルに保ちつつ、詳細はドキュメントで管理
</aside>

### メタデータ項目

| 項目 | 説明 | 例 |
| --- | --- | --- |
| **Layer ID** | 一意のID（タイトルにも括弧で追記） | L001-SG1-3 |
| **Parent** | 親LayerのIDと名称 | L001-SG1（Product部門基盤） |
| **Status** | active / ready / completed | active |
| **Owner** | 担当者 | miyatti |
| **Deadline** | 期限 | 2025-12-25 |

### なぜこの構造か？

<aside>
💡

**混乱を防ぐための設計原則**

1. **Layer IDの明示** — どのLayerのページか一目でわかる
2. **成果物とaipo管理の完全分離** - 一般ユーザーは成果物のみを見る
3. **トグルで折りたたみ** - 管理ファイルは通常時は非表示（AIと管理者のみが開く）
4. **統一フォルダ構造** - Commands/, yaml群が必ず同じ場所にある
5. **一元管理** - Layerページを開けば全ての管理ファイルにアクセス可能
</aside>

### Context/ フォルダの構造

`Context/` フォルダには、`aipo_init` が収集・整理したContext情報ドキュメントが格納されます：

```jsx
Context/
├── 01_[チーム構成.md](http://チーム構成.md)
├── 02_[関連リンク集.md](http://関連リンク集.md)
├── 03_[技術スタック.md](http://技術スタック.md)
├── 04_制約条件・[ポリシー.md](http://ポリシー.md)
└── 05_[既存資料まとめ.md](http://既存資料まとめ.md)
```

各ドキュメントには：

- ワークスペース検索で収集した関連情報
- 整理・構造化されたコンテキストデータ
- 親Layerからの継承情報（SubLayerの場合）

が含まれます。

**SubLayer継承の仕組み：**

- 親のContext/フォルダへの参照が自動設定
- SubLayer独自のContext/フォルダも新規作成
- context.yamlで両方を参照可能

### Commands/ フォルダの構造

`Commands/` フォルダには、`aipo_03_command_gen` が生成した各タスクの実行用コマンドページが格納されます：

```
Commands/
├─ T1.1_タスク名
├─ T1.2_タスク名
├─ T2.1_タスク名
└─ ...
```

各コマンドページには：

- タスクの詳細説明
- 実行手順（command_templateからコピーまたは新規生成）
- 完了条件
- 実行履歴

が含まれます。

---

---

## 📝 標準プロンプトテンプレート（コピペ用）

<aside>
📋

**毎回このプロンプトを使用すること**

aipoの目的を忘れないために、以下のプロンプトテンプレートを使用してください。

「🔴 最重要原則」を毎回含めることで、コンテキストが維持されます。

</aside>

### テンプレート1: タスク実行（aipo_04_deliver）

<aside>
💡

[CMD_aipo_04_deliver](https://www.notion.so/CMD_aipo_04_deliver-4a7d3a9ff65f4b22968540d7c979b5b5?pvs=21) を実行してください

🔴 最重要原則（必読）:

aipoの目的は「実際に動くDatabase/システム」を作ること。

- ガイド/設計書「だけ」では完了にならない
- 全てのタスクは実際のDB作成/更新を伴う
- タスク完了前に「DBは作成されたか？」を確認

Layer: @[対象LayerのURL]

読み込み:

- @[対象Layerのlayer.yaml]
- @[対象Layerのcontext.yaml]
- @[対象Layerのtasks.yaml]

実行タスク: [タスクID]

期待する成果物:

- Database: [DB名]（必須）
- プロパティ: [必要なプロパティ]
- ビュー: [必要なビュー]
- 付属ドキュメント: [ガイド等]（任意）
</aside>

### テンプレート2: Layer初期化（aipo_01_init）

<aside>
💡

[/aipo/01_sense](../commands/01_sense.md) を実行してください

🔴 最重要原則（必読）:

aipoの目的は「実際に動くDatabase/システム」を作ること。

- このLayerで作成するDBを明確にする
- ガイド/設計書「だけ」のタスクは作らない
- 全てのタスクにDB出力を含める

Goal: [Layerの目標]

親Layer: @[親LayerのURL]（あれば）

期待するDB成果物:

- [DB1の名前と目的]
- [DB2の名前と目的]
- ...
</aside>

### テンプレート3: セッション再開

<aside>
💡

[aipo (AI-PO) system](../aipo%20(AI-PO)%20system.md)

前回のセッションを再開します

🔴 最重要原則（必読）:

aipoの目的は「実際に動くDatabase/システム」を作ること。

- ガイド/設計書「だけ」では完了にならない
- 全てのタスクは実際のDB作成/更新を伴う
- セッション終了時に「作成したDB数」を報告

前回の状態:

- Layer: @[LayerのURL]
- 完了タスク: [タスクID一覧]
- 残タスク: [タスクID一覧]

今回の実行内容:

- [実行するタスクまたはアクション]

確認なしで実行し、完了後に以下を報告:

1. 作成/更新したDB一覧
2. 作成したページ一覧
3. 次のアクション提案
</aside>

### テンプレート4: DB実装タスク（db_implementation）

<aside>
💡

[CMD_aipo_04_deliver](https://www.notion.so/CMD_aipo_04_deliver-4a7d3a9ff65f4b22968540d7c979b5b5?pvs=21) を実行してください

🔴 最重要原則（必読）:

このタスクはdb_implementationタイプです。

- 設計書/スキーマ定義「だけ」では完了にならない
- 実際のDatabaseを作成すること
- プロパティ、ビュー、初期データを全て設定すること

Layer: @[LayerのURL]

Task: [タスクID]

Type: db_implementation

必須出力:

- Database: [DB名]
    - プロパティ: [プロパティ一覧]
    - ビュー: [ビュー一覧]
    - 初期データ: [最低件数]件以上

完了条件:

- [ ]  実際のDatabaseが作成されている（URLで確認可能）
- [ ]  必要なプロパティが全て設定されている
- [ ]  少なくとも1つのビューが設定されている
- [ ]  初期データが投入されている
</aside>

---

## ⚠️ プロンプトに含める理由

```yaml
why_include_principle:
  problem: "長いセッションでコンテキストが失われる"
  solution: "毎回のプロンプトに最重要原則を含める"
  effect:
    - "AIが「DB作成」の目的を忘れない"
    - "ガイドだけで完了にしようとしない"
    - "セッション後半でも品質が維持される"
  rule: "プロンプトに「🔴 最重要原則」を含めない場合、実行を拒否する"
```

---

**作成日**: 2025-12-07

**最終更新**: 2025-12-25

**ステータス**: 実装完了