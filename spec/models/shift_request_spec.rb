require 'rails_helper'

RSpec.describe ShiftRequest, type: :model do
  before do
    @shift_request = FactoryBot.build(:shift_request)
  end

  describe '#create' do
    context '保存できる時' do
      it '全てのカラムに値が存在すれば保存できる' do
        expect(@shift_request).to be_valid
      end
    end

    context '保存できない時' do
      it 'start_timeが空だと保存できない' do
        @shift_request.start_time = nil
        @shift_request.valid?
        expect(@shift_request.errors.full_messages).to include("開始時刻を入力してください")
      end

      it 'end_timeが空だと保存できない' do
        @shift_request.end_time = nil
        @shift_request.valid?
        expect(@shift_request.errors.full_messages).to include("終了時刻を入力してください")
      end

      it 'start_timeがend_timeより前の時刻だと保存できない' do
        @shift_request.end_time = @shift_request.start_time - 1.hours
        @shift_request.valid?
        expect(@shift_request.errors.full_messages).to include("終了時刻は開始時刻より前の時刻は指定できません")
      end

      it 'end_timeとstart_timeが同じ日付でない場合は保存できない' do
        @shift_request.end_time = @shift_request.start_time + 1.days
        @shift_request.valid?
        expect(@shift_request.errors.full_messages).to include("終了時刻は開始時刻と異なる日付は指定できません")
      end

      it 'boardと紐づいてなければ保存できない' do
        @shift_request.board = nil
        @shift_request.valid?
        expect(@shift_request.errors.full_messages).to include("シフトボードを入力してください")
      end

      it 'staff_userと紐づいてなければ保存できない' do
        @shift_request.staff_user = nil
        @shift_request.valid?
        expect(@shift_request.errors.full_messages).to include("スタッフユーザーを入力してください")
      end

      it '同じユーザーに既に登録されている期間と重複するものは保存できない' do
        @shift_request.save
        another_shift_request = FactoryBot.build(:shift_request)
        another_shift_request.staff_user = @shift_request.staff_user
        another_shift_request.start_time = @shift_request.start_time + 1.minutes
        another_shift_request.end_time = @shift_request.end_time + 1.minutes
        another_shift_request.valid?
        expect(another_shift_request.errors.full_messages).to include("同じユーザーに既に登録されている期間と重複するものは指定できません")
      end
    end
  end
end
