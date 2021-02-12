require 'rails_helper'

RSpec.describe ShiftRequest, type: :model do
  describe 'シフト希望の新規作成' do
    let(:shift_request) { build(:shift_request) }
    subject { shift_request.errors.full_messages }

    context '全てのカラムに値が存在するとき' do
      it { expect(shift_request).to be_valid }
    end

    context 'start_timeが空のとき' do
      it do
        shift_request.start_time = nil
        shift_request.valid?
        is_expected.to include("開始時刻を入力してください")
      end
    end

    context 'end_timeが空のとき' do
      it do
        shift_request.end_time = nil
        shift_request.valid?
        is_expected.to include("終了時刻を入力してください")
      end
    end

    context 'start_timeがend_timeより前の時刻のとき' do
      it do
        shift_request.end_time = shift_request.start_time - 1.hours
        shift_request.valid?
        is_expected.to include("終了時刻は開始時刻より前の時刻は指定できません")
      end
    end

    context 'end_timeとstart_timeが同じ日付でないとき' do
      it do
        shift_request.end_time = shift_request.start_time + 1.days
        shift_request.valid?
        is_expected.to include("終了時刻は開始時刻と異なる日付は指定できません")
      end
    end

    context 'boardと紐づいてないとき' do
      it do
        shift_request.board = nil
        shift_request.valid?
        is_expected.to include("シフトボードを入力してください" )
      end
    end

    context 'staff_userと紐づいてないとき' do
      it do
        shift_request.staff_user = nil
        shift_request.valid?
        is_expected.to include("スタッフユーザーを入力してください")
      end
    end

    context '同じユーザーに既に登録されている期間と重複するとき' do
      let(:another_shift_request) { build(:shift_request, staff_user_id: shift_request.staff_user_id, start_time: shift_request.start_time + 1.minutes, end_time: shift_request.end_time + 1.minutes) }
      it do
        shift_request.save
        another_shift_request.valid?
        expect(another_shift_request.errors.full_messages).to include("同じユーザーに既に登録されている期間と重複するものは指定できません")
      end
    end
  end
end
