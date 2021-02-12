require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'board新規作成' do
    let(:board) { build(:board) }
    subject { board.errors.full_messages }

    context '保存できるとき' do
      it 'nameの値が存在すれば保存できる' do
        expect(board).to be_valid
      end
    end

    context '保存できないとき' do
      it 'nameが空だと保存できない' do
        board.name = ''
        board.valid?
        is_expected.to include("シフトボード名を入力してください")
      end

      it 'ownerが紐付いていないと保存できない' do
        board.owner = nil
        board.valid?
        is_expected.to include('シフト管理者を入力してください')
      end
    end
  end
end
