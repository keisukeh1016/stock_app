AWS https://stock-app.net/

#### テストユーザーでログインできます

## 概要

1. ユーザー登録

2. 10万円が支給されます

3. 他のユーザーを参考にして、銘柄を売買

4. 10万円をどこまで増やせるか？減るか？

5. ランキングで１位を目指そう

#### 株価は平日１６時頃更新されます。

## 環境

* AWS EC2 Ubuntu Nginx + Puma

* AWS EC2 Ubuntu PostgreSQL

* Ruby 2.7.1

* Rails 6.0.3

* RSpec

* Slim (HTML)

#### gem 

* nokogiri ( スクレイピング )

* roo ( スプレッドシート )

* faker ( ランダムなユーザーネーム )

* ransack ( 検索フォーム )

## 機能

* アカウント作成／削除

* メール認証 ( SendGrid )

* ログイン／ログアウト

* スクレイピングで株価取得

* 銘柄一覧表示／検索（ TOPIX100 ）

* 仮想的な株式売買

* ユーザーのランキング表示

* 独自ドメイン ( Route53 )

* SSL/TLS ( Let's Encrypt )



## 他のデプロイ場所

* AWS https://stock-app.net/

* Heroku https://stock-ja.herokuapp.com/