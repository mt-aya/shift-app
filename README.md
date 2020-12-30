# テーブル設計

## administrators テーブル

| Column             | Type     | Options     |
| ------------------ | -------- | ----------- |
| email              | string   | null: false |
| encrypted_password | string   | null: false |
| company            | string   | null: false |
| last_name          | string   | null: false |
| first_name         | string   | null: false |

### Association

- has_many :rooms

## staff_users テーブル

| Column             | Type     | Options     |
| ------------------ | -------- | ----------- |
| email              | string   | null: false |
| encrypted_password | string   | null: false |
| id_name            | string   | null: false |
| last_name          | string   | null: false |
| first_name         | string   | null: false |

### Association

- has_many :room_staff_users
- has_many :rooms, though: :room_staff_users
- has_many :requested_shifts
- has_many :decided_shift

## rooms テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| name          | string     | null: false       |
| administrator | references | foreign_key: true |

### Association

- has_many :room_staff_users
- has_many :staff_users, though: :room_staff_users
- has_many :shift_frames
- belongs_to :administrator

## room_staff_users テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| room       | references | foreign_key: true |
| staff_user | references | foreign_key: true |

### Association

- belongs_to :room
- belongs_to :staff_user

## shift_frames テーブル

| Column          | Type       | Options          |
| --------------- | ---------- | ---------------- |
| start_day       | datetime   | null: false      |
| end_day         | datetime   | null: false      |
| settled_request | boolean    | null: false      |
| settled_create  | boolean    | null: false      |
| room            | references | foreign_key:true |

### Association

- belongs_to :room
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