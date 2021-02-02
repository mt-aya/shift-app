# アプリ名

ShiftLink

# 概要

シフトの提出やシフトの作成などのシフト管理ができるアプリケーション
- シフト提出側は、自分のシフトの希望を作成し一覧を確認でき、またその希望をシフトを作成する側に共有することができる。また、シフト作成者によって作成されたシフトを一覧で確認することができる。
- シフト作成側は、シフト提出者によって、共有されたシフト希望を一覧で確認できる。またそのシフト希望を確認しながらシフトを作成し、それを一覧で確認することができる。

# 本番環境

URL：<https://shift-app-ymmt.herokuapp.com>  
ログイン情報
- シフト提出側
  - Eメール：staff11@staff
  - パスワード：staff11
-  シフト作成側
  - Eメール：test11@test
  - パスワード：test11

# 制作背景

以前勤務していた販売店では、スタッフはLINEやメールなどでシフト希望の提出をし、店舗の責任者の方がシフト作成を行っていた。シフト作成は、各スタッフのシフト希望を照らし合わせながら、表が描かれた用紙にシフトを直接書き込んでおり、多くの時間を浪費する大変な作業だと感じていた。また、臨時スタッフの数が増える繁忙期はシフト変更の伝達に手間がかかり、各持ち場に何人いるかの確認も一目でわかりにくいと感じたので、それらも容易となるシステムがあればと考えていた。
これらのことから、シフト作成者の業務負担を少しでも削減すべく、シフトの作成・管理が容易になり、シフト作成の時間短縮が可能になるものを作成した。

# DEMO

## シフト提出側のログイン・新規登録画面
<img alt="シフト提出者ログイン・新規登録" src="https://gyazo.com/1ab0bd54b84e92e9410d4d6941c217fd">

## シフト作成者側のログイン・新規登録画面
<img alt="シフト作成者ログイン・新規登録" src="https://gyazo.com/7cb1346889e7aa71dc4a4bef8e7b17f1">

# 使用技術

## バックエンド
Ruby, Ruby on Rails

## フロントエンド
HTML, CSS, JavaScript, Ajax

## データベース
MySQL

## ソース管理
GitHub, GitHub Desktop

## その他
Docker, CircleCI, RSpec, heroku

# 今後の課題・実装予定の機能
- まだ完成しておらず、確定したシフトの共有機能、希望シフトの共有機能が最低限必要である。
- 最低限の機能では実用性は低いため、1日のシフト一覧で、時間ごとの人員数を視覚的に把握できる機能が必要と感じた。
- また以下のような機能があれば利便性が高まると考えた。
  - 持ち場（飲食店であればホールやキッチン等）ごとにスタッフのシフトを管理できるグループ機能。
  - シフトの時間をひとつひとつ入力するのも手間なので、頻繁に使用するシフトの時間をテンプレート化し、シフト作成時にテンプレート選択するだけでシフトを作成できるテンプレート作成機能。

# テーブル設計

## owners テーブル

| Column             | Type     | Options     |
| ------------------ | -------- | ----------- |
| email              | string   | null: false |
| encrypted_password | string   | null: false |
| company            | string   | null: false |
| last_name          | string   | null: false |
| first_name         | string   | null: false |

### Association

- has_many :boards

## staff_users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| email              | string   | null: false               |
| encrypted_password | string   | null: false               |
| id_name            | string   | null: false, unique: true |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |

### Association

- has_many :board_staff_users
- has_many :boards, though: :board_staff_users
- has_many :requested_shifts
- has_many :decided_shift

## boards テーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| name   | string     | null: false       |
| owner  | references | foreign_key: true |

### Association

- has_many :board_staff_users
- has_many :staff_users, though: :board_staff_users
- has_many :shift_frames
- belongs_to :owner

## board_staff_users テーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| board       | references | foreign_key: true |
| staff_user  | references | foreign_key: true |

### Association

- belongs_to :board
- belongs_to :staff_user

## shift_frames テーブル

| Column          | Type       | Options          |
| --------------- | ---------- | ---------------- |
| start_day       | datetime   | null: false      |
| end_day         | datetime   | null: false      |
| settled_request | boolean    | null: false      |
| settled_create  | boolean    | null: false      |
| board           | references | foreign_key:true |

### Association

- belongs_to :board
- has_many :requested_shifts
- has_many :created_shifts

## requested_shift テーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| start_time  | datetime   |                   |
| end_time    | datetime   |                   |
| shift_frame | references | foreign_key: true |
| staff_user  | references | foreign_key: true |

### Association

- belongs_to :shift_frame
- belongs_to :staff_user

## decided_shift テーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| start_time  | datetime   |                   |
| end_time    | datetime   |                   |
| shift_frame | references | foreign_key: true |
| staff_user  | references | foreign_key: true |

### Association

- belongs_to :shift_frame
- belongs_to :staff_user