EC2 https://stock-app.net/

#### テストユーザーでログインできます

![トップページ](./app/assets/images/toppage.png)

# 概要

1. 株式売買の体験ができます

2. 他のユーザーと競争しましょう

3. 株価は平日１６時頃更新されます。

# 環境

* Ruby 2.7.1

* Rails 6.0.3

* Slim

* RSpec

#### 本番環境

* AWS ECS

  - Nginx
  - Puma

* AWS RDS

  - PostgreSQL

#### ローカル環境

* Ubuntu Desktop 20.04

* Docker Compose

#### デプロイ

* [deploy-ecs.rb](https://github.com/keisukeh1016/stock_app/blob/master/deploy-ecs.rb)

1. DockerfileからimageをBuild

2. Docker HubにPush

3. AWS ECS タスクを停止＆実行

# 機能

* アカウント作成／削除／有効化

  - SendGrid

* ログイン／ログアウト

  - bcrypt

* ユーザランキング表示／ページネーション

  - faker
  - kaminari

* 銘柄一覧表示／検索

  - roo
  - ransack

* 平日16時に株価更新

  - nokogiri
  - [lib/tasks/stock.rake](https://github.com/keisukeh1016/stock_app/blob/master/lib/tasks/stock.rake)

* 銘柄に関するツイート表示

  - Twitter Search API

* 株式売買

* 独自ドメイン／SSL／TLS

  - Route53
  - Let's Encrypt

* テスト

  - RSpec
  - Capybara
  - FactoryBot

# 他のデプロイ場所

* Heroku 
  - https://stock-ja.herokuapp.com/