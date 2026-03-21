# Keyword Analysis

Google Ads のキーワードパフォーマンスを分析するスキルです。品質スコア・CVR・CPCの観点から改善ポイントを特定します。

## 使い方

`/keyword-analysis` に続けてキャンペーン名や分析対象を指定できます。省略した場合は全キャンペーンが対象です。

例:
- `/keyword-analysis`
- `/keyword-analysis ブランドキャンペーン`

## 手順

1. `list_accessible_customers` で顧客IDを取得
2. `search` ツールで以下のデータを取得:
   - resource: `ad_group_criterion`
   - fields:
     - `campaign.name`
     - `ad_group.name`
     - `ad_group_criterion.keyword.text`
     - `ad_group_criterion.keyword.match_type`
     - `ad_group_criterion.status`
     - `ad_group_criterion.quality_info.quality_score`
     - `ad_group_criterion.quality_info.creative_quality_score`
     - `ad_group_criterion.quality_info.post_click_quality_score`
     - `ad_group_criterion.quality_info.search_predicted_ctr`
     - `metrics.impressions`
     - `metrics.clicks`
     - `metrics.cost_micros`
     - `metrics.conversions`
     - `metrics.ctr`
     - `metrics.average_cpc`
   - conditions:
     - `segments.date DURING LAST_30_DAYS`
     - `ad_group_criterion.type = 'KEYWORD'`
     - `ad_group_criterion.status != 'REMOVED'`
   - orderings: `metrics.cost_micros DESC`
   - limit: 100

3. 分析結果を以下のカテゴリに分類:
   - **高パフォーマンス**: 品質スコア 7以上 かつ CVR 高
   - **要改善**: 品質スコア 5以下 または コスト高・CV少
   - **一時停止推奨**: 表示回数は多いがクリックゼロ or CVゼロ

4. 改善アクションを具体的に提案する（マッチタイプ変更・広告文改善・除外キーワード追加など）
