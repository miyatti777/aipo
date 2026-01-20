# operation_command_template

最終更新日時: 2025年12月25日 13:35

# operation_[system_name] - 量産型実行コマンド

> **確立されたシステム/型を使って、変数を指定するだけで高速量産を実現します**
> 

> 
> 

> このコマンドは、Abstractモードで完成したLayerから自動生成されたOperation Commandです。
> 

---

## 🎯 このコマンドの目的

**[システム名]** の確立された型を使い、変数を指定するだけで同じ構造の成果物を量産できます。

### 元になったLayer

- **Layer ID**: [L001-SG2]
- **Layer名**: [ノッカリ記事制作システム]
- **完了日**: [2025-12-06]
- **作成されたDB/システム**:
    - 記事管理DB（Articles）
    - フィードバックDB（Feedback）
    - 執筆テンプレート
    - レビューワークフロー

---

## 📋 必須変数

以下の変数を指定して実行してください：

```yaml
variables:
  variable_1:
    name: "target_person"
    type: "string"
    description: "記事対象人物名"
    example: "山田太郎"
    required: true
  
  variable_2:
    name: "theme"
    type: "string"
    description: "記事のテーマ"
    example: "AIプロダクト開発の極意"
    required: true
  
  variable_3:
    name: "deadline"
    type: "date"
    description: "締切日"
    example: "2025-12-31"
    required: true
  
  variable_4:
    name: "word_count"
    type: "number"
    description: "目標文字数"
    example: 10000
    required: false
    default: 10000
```

---

## 🔄 実行フロー

このコマンドは、以下のテンプレートを順番に実行します：

<aside>
📌

**実行フェーズ**

1. **Phase 1**: [CTX_command_templates](../command-templates.md)
    - 変数: `target_person`
    - 成果物: リサーチDB、インサイトDB
2. **Phase 2**: [CTX_command_templates](../command-templates.md)
    - 変数: `theme`, `word_count`
    - 成果物: アウトライン、セクション管理DB
3. **Phase 3**: [CTX_command_templates](../command-templates.md)
    - 変数: `target_person`, `theme`
    - 成果物: 執筆ページ、草稿
4. **Phase 4**: [CTX_command_templates](../command-templates.md)
    - 変数: なし
    - 成果物: フィードバックDB、修正版
5. **Phase 5**: [CTX_command_templates](../command-templates.md)
    - 変数: `deadline`
    - 成果物: 公開準備、振り返り
</aside>

---

## 💬 使用例

### 基本的な使い方

```jsx
@operation_[system_name] を実行してください

Variables:
  target_person: "山田太郎"
  theme: "AIプロダクト開発の極意"
  deadline: "2025-12-31"
  word_count: 10000
```

### 最小限の変数で実行

```jsx
@operation_[system_name] を実行してください

Variables:
  target_person: "鈴木花子"
  theme: "スタートアップのファイナンス戦略"
  deadline: "2026-01-15"
```

（`word_count`はデフォルト値10000が使用されます）

---

## ⚙️ AIへの実行指示

<aside>
🤖

**AIへの指示（このコマンドが@メンションされたとき）**

**Phase 1: 変数の検証**

1. ユーザーが提供した変数を読み込む
2. 必須変数が全て揃っているか確認
3. 不足している変数があれば、ユーザーに確認

**Phase 2: 実行計画の提示**

1. 実行フローを表示
2. 各フェーズで使用する変数を明示
3. 推定所要時間を提示
4. ユーザーの承認を得る

**Phase 3: 順次実行**

1. Phase 1から順番に実行
2. 各フェーズで該当テンプレートを参照
3. 変数を注入してカスタマイズ
4. 成果物を生成
5. 次のフェーズに進む前に確認

**Phase 4: 完了報告**

1. 全フェーズ完了を確認
2. 成果物一覧を表示
3. 記事管理DBに記録
4. 次回の実行例を提示

**重要ルール**:

- **型の再現性**: 元のLayerと同じDB構造・ワークフローを使用
- **変数の注入**: ハードコードされた値を変数で置換
- **品質保証**: 元のLayerと同等の品質を維持
</aside>

---

## 📊 実行履歴

| 実行日 | 変数 | 成果物URL | 所要時間 |
| --- | --- | --- | --- |
| 2025-12-06 | target_person: 柳川慶太
theme: 叩きのめすvs気がついたら世界変わってる | [aipo (AI-PO) system](../../aipo%20(AI-PO)%20system.md) | 4時間 |

---

## 🔗 関連リソース

- **元のLayer**: [Layer URL]
- **テンプレート集**: [CTX_command_templates](../command-templates.md)
- **変数定義**: variables.yaml
- **システムDB**: [aipo (AI-PO) system](../../aipo%20(AI-PO)%20system.md)

---

**作成日**: [自動生成日]

**生成元**: rogos_04_execute (Abstract Mode完了時)

**ステータス**: Ready

---

## 📝 カスタマイズ履歴

| 日付 | 変更内容 | 変更者 |
| --- | --- | --- |
| 2025-12-06 | 初回生成 | rogos_04_execute |