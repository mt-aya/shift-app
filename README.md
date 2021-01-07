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