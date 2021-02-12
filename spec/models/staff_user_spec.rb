require 'rails_helper'

RSpec.describe StaffUser, type: :model do
  describe 'staff_user新規登録' do
    let(:staff) { build(:staff_user) }
    let(:another_staff) {build(:staff_user) }
    context '登録できる時' do
      it '全てのカラムに値が存在すれば登録できる' do
        expect(staff).to be_valid
      end

      it 'passwordは英・数字の両方が含まれており6文字以上であれば登録できる' do
        staff_user_password = '123Abc'
        staff.password = staff_user_password
        staff.password_confirmation = staff_user_password
        expect(staff).to be_valid
      end

      it 'last_nameは全角ひらがな、カタカナ、漢字だと登録できる' do
        staff.last_name = '全角かなカナ'
        expect(staff).to be_valid
      end

      it 'first_nameは全角ひらがな、カタカナ、漢字だと登録できる' do
        staff.first_name = '全角かなカナ'
        expect(staff).to be_valid
      end

      it 'id_nameは6〜16文字だと数字だけでも登録できる' do
        staff.id_name = '123456'
        expect(staff).to be_valid
      end

      it 'id_nameは6〜16文字だと半角英字だけでも登録できる' do
        staff.id_name = 'abcdef'
        expect(staff).to be_valid
      end
    end

    context '登録できない時' do
      subject { staff.errors.full_messages }
      it 'emailが空だと登録できない' do
        staff.email = ''
        staff.valid?
        is_expected.to include("Eメールを入力してください")
      end

      it 'passwordが空だと登録できない' do
        staff.password = ''
        staff.valid?
        is_expected.to include("パスワードを入力してください")
      end

      it 'passwordが存在していてもpassword_confirmationが空だと登録できない' do
        staff.password_confirmation = ''
        staff.valid?
        is_expected.to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'id_nameが空だと登録できない' do
        staff.id_name = ''
        staff.valid?
        is_expected.to include("ユーザーIDを入力してください")
      end

      it 'last_nameが空だと登録できない' do
        staff.last_name = ''
        staff.valid?
        is_expected.to include("お名前（姓）を入力してください")
      end

      it 'first_nameが空だと保存できない' do
        staff.first_name = ''
        staff.valid?
        is_expected.to include("お名前（名）を入力してください")
      end

      it 'emailは@が含まれていないと登録できない' do
        staff.email = 'email'
        staff.valid?
        is_expected.to include('Eメールは不正な値です')
      end

      it 'passwordは数字だけでは登録できない' do
        staff_user_password = '123456'
        staff.password = staff_user_password
        staff.password_confirmation = staff_user_password
        staff.valid?
        is_expected.to include('パスワードは不正な値です')
      end

      it 'passwordは英字だけでは登録できない' do
        staff_user_password = 'AbcDef'
        staff.password = staff_user_password
        staff.password_confirmation = staff_user_password
        staff.valid?
        is_expected.to include('パスワードは不正な値です')
      end

      it 'passwordは英・数字混合でも5文字以下だと登録できない' do
        staff_user_password = 'Ab123'
        staff.password = staff_user_password
        staff.password_confirmation = staff_user_password
        staff.valid?
        is_expected.to include('パスワードは6文字以上で入力してください')
      end

      it '重複したemailが既に存在する場合は登録できない' do
        staff.save
        another_staff.email = staff.email
        another_staff.valid?
        expect(another_staff.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'id_nameは6~16文字でも全角だと登録できない' do
        staff.id_name = 'あいうえおア'
        staff.valid?
        is_expected.to include('ユーザーIDは不正な値です')
      end

      it 'id_nameは5文字以下だと登録できない' do
        staff.id_name = 'abcde'
        staff.valid?
        is_expected.to include('ユーザーIDは不正な値です')
      end

      it 'id_nameは17文字以上だと登録できない' do
        staff.id_name = '1234567890abcdefg'
        staff.valid?
        is_expected.to include('ユーザーIDは不正な値です')
      end

      it 'last_nameは半角だと登録できない' do
        staff.last_name = 'hankaku'
        staff.valid?
        is_expected.to include('お名前（姓）は全角文字で入力してください')
      end

      it 'first_nameは半角だと登録できない' do
        staff.first_name = 'hankaku'
        staff.valid?
        is_expected.to include('お名前（名）は全角文字で入力してください')
      end
    end
  end
end
