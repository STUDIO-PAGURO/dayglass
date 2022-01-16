# 概要
Ruby on Railsを学んで制作した、ポートフォリオです。
24時間経つと消える、Instagramのストーリーのようなものに特化したSNSです。

# バージョン
Ruby 2.6.5  
Rails 6.0.4.4

# テーブル設計

## users テーブル

| Column   | Type      | Options           |
| -------- | --------- | ----------------- |
| name     | string    | null: false       |
| account  | string    | null: false       |
| email    | string    | null: false       |
| password | string    | null: false       |
| profile  | text      |                   |

### Association

- has_many :posts
- has_many :likes
- has_many :comments

## posts テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| text     | text       |                                |

### Association

- belongs_to :user
- has_many :likes
- has_many :comments

## likes テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| post     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## comments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| post     | references | null: false, foreign_key: true |
| text     | text       |                                |

### Association

- belongs_to :user
- belongs_to :post

## follows テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| following | references | null: false, foreign_key: true |
| follower  | references | null: false, foreign_key: true |

