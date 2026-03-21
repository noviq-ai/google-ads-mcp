# Campaign Performance Report

Google Ads のキャンペーンパフォーマンスレポートを生成するスキルです。

## 使い方

`/campaign-report` を実行すると、アクセス可能なアカウントのキャンペーン一覧と直近30日間のパフォーマンス指標を取得して表形式で表示します。

## 手順

1. `list_accessible_customers` でアクセス可能な顧客IDを取得する
2. 各顧客IDに対して `search` ツールで以下のGAQLクエリを実行する:
   - resource: `campaign`
   - fields:
     - `campaign.id`
     - `campaign.name`
     - `campaign.status`
     - `campaign.advertising_channel_type`
     - `metrics.impressions`
     - `metrics.clicks`
     - `metrics.cost_micros`
     - `metrics.conversions`
     - `metrics.ctr`
     - `metrics.average_cpc`
     - `metrics.conversion_rate`
   - conditions:
     - `segments.date DURING LAST_30_DAYS`
     - `campaign.status != 'REMOVED'`
   - orderings: `metrics.cost_micros DESC`

3. 結果を以下の形式の表にまとめる:

| キャンペーン名 | ステータス | 表示回数 | クリック数 | CTR | 費用 | CV数 | CVR | CPC |
|---|---|---|---|---|---|---|---|---|

4. コスト上位・CVR上位・改善余地のあるキャンペーンについてコメントを添える

## 注意
- `cost_micros` は 1,000,000 で割ると通貨単位になります
- ステータスが `PAUSED` のキャンペーンも含めて表示し、マーク（⏸️）を付けてください
