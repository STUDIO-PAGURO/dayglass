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
| icon     | string    |                   |

### Association

- has_many :posts
- has_many :likes
- has_many :comments

- has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
- has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
- has_many :following_user, through: :follower, source: :followed
- has_many :follower_user, through: :followed, source: :follower

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

## relationships テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| follower    | references | null: false, foreign_key: true |
| followed    | references | null: false, foreign_key: true |

### Association

- belongs_to :follower, class_name: "User"
- belongs_to :followed, class_name: "User"