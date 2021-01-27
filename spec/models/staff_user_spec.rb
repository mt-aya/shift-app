require 'rails_helper'

RSpec.describe StaffUser, type: :model do
  before do
    @staff_user = FactoryBot.build(:staff_user)
  end

  describe 'staff_user新規登録' do
    context '登録できる時' do
      it '全てのカラムに値が存在すれば登録できる' do
        expect(@staff_user).to be_valid
      end

      it 'passwordは英・数字の両方が含まれており6文字以上であれば登録できる' do
        staff_user_password = '123Abc'
        @staff_user.password = staff_user_password
        @staff_user.password_confirmation = staff_user_password
        expect(@staff_user).to be_valid
      end

      it 'last_nameは全角ひらがな、カタカナ、漢字だと登録できる' do
        @staff_user.last_name = '全角かなカナ'
        expect(@staff_user).to be_valid
      end

      it 'first_nameは全角ひらがな、カタカナ、漢字だと登録できる' do
        @staff_user.first_name = '全角かなカナ'
        expect(@staff_user).to be_valid
      end

      it 'id_nameは6〜16文字だと数字だけでも登録できる' do
        @staff_user.id_name = '123456'
        expect(@staff_user).to be_valid
      end

      it 'id_nameは6〜16文字だと半角英字だけでも登録できる' do
        @staff_user.id_name = 'abcdef'
        expect(@staff_user).to be_valid
      end
    end

    context '登録できない時' do
      it 'emailが空だと登録できない' do
        @staff_user.email = ''
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'passwordが空だと登録できない' do
        @staff_user.password = ''
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが存在していてもpassword_confirmationが空だと登録できない' do
        @staff_user.password_confirmation = ''
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'id_nameが空だと登録できない' do
        @staff_user.id_name = ''
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include("ユーザーIDを入力してください")
      end

      it 'last_nameが空だと登録できない' do
        @staff_user.last_name = ''
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include("お名前（姓）を入力してください")
      end

      it 'first_nameが空だと保存できない' do
        @staff_user.first_name = ''
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include("お名前（名）を入力してください")
      end

      it 'emailは@が含まれていないと登録できない' do
        @staff_user.email = 'email'
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordは数字だけでは登録できない' do
        staff_user_password = '123456'
        @staff_user.password = staff_user_password
        @staff_user.password_confirmation = staff_user_password
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは英字だけでは登録できない' do
        staff_user_password = 'AbcDef'
        @staff_user.password = staff_user_password
        @staff_user.password_confirmation = staff_user_password
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは英・数字混合でも5文字以下だと登録できない' do
        staff_user_password = 'Ab123'
        @staff_user.password = staff_user_password
        @staff_user.password_confirmation = staff_user_password
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it '重複したemailが既に存在する場合は登録できない' do
        @staff_user.save
        another_staff_user = FactoryBot.build(:staff_user)
        another_staff_user.email = @staff_user.email
        another_staff_user.valid?
        expect(another_staff_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'id_nameは6~16文字でも全角だと登録できない' do
        @staff_user.id_name = 'あいうえおア'
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('ユーザーIDは不正な値です')
      end

      it 'id_nameは5文字以下だと登録できない' do
        @staff_user.id_name = 'abcde'
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('ユーザーIDは不正な値です')
      end

      it 'id_nameは17文字以上だと登録できない' do
        @staff_user.id_name = '1234567890abcdefg'
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('ユーザーIDは不正な値です')
      end

      it 'last_nameは半角だと登録できない' do
        @staff_user.last_name = 'hankaku'
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('お名前（姓）は全角文字で入力してください')
      end

      it 'first_nameは半角だと登録できない' do
        @staff_user.first_name = 'hankaku'
        @staff_user.valid?
        expect(@staff_user.errors.full_messages).to include('お名前（名）は全角文字で入力してください')
      end
    end
  end
end
