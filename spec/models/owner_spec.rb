require 'rails_helper'

RSpec.describe Owner, type: :model do
  before do
    @owner = FactoryBot.build(:owner)
  end

  describe 'owner新規登録' do
    context '登録できる時' do
      it '全てのカラムに値が存在すれば登録できる' do
        expect(@owner).to be_valid
      end

      it 'passwordは英・数字の両方が含まれており6文字以上であれば登録できる' do
        owner_password = '123Abc'
        @owner.password = owner_password
        @owner.password_confirmation = owner_password
        expect(@owner).to be_valid
      end

      it 'last_nameは全角ひらがな、カタカナ、漢字だと登録できる' do
        @owner.last_name = '全角かなカナ'
        expect(@owner).to be_valid
      end

      it 'first_nameは全角ひらがな、カタカナ、漢字だと登録できる' do
        @owner.first_name = '全角かなカナ'
        expect(@owner).to be_valid
      end
    end

    context '登録できない時' do
      it 'emailが空だと登録できない' do
        @owner.email = ''
        @owner.valid?
        expect(@owner.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'passwordが空だと登録できない' do
        @owner.password = ''
        @owner.valid?
        expect(@owner.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが存在していてもpassword_confirmationが空だと登録できない' do
        @owner.password_confirmation = ''
        @owner.valid?
        expect(@owner.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'companyが空だと登録できない' do
        @owner.company = ''
        @owner.valid?
        expect(@owner.errors.full_messages).to include("会社名を入力してください")
      end

      it 'last_nameが空だと登録できない' do
        @owner.last_name = ''
        @owner.valid?
        expect(@owner.errors.full_messages).to include("お名前（姓）を入力してください")
      end

      it 'first_nameが空だと保存できない' do
        @owner.first_name = ''
        @owner.valid?
        expect(@owner.errors.full_messages).to include("お名前（名）を入力してください")
      end

      it 'emailは@が含まれていないと登録できない' do
        @owner.email = 'email'
        @owner.valid?
        expect(@owner.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordは数字だけでは登録できない' do
        owner_password = '123456'
        @owner.password = owner_password
        @owner.password_confirmation = owner_password
        @owner.valid?
        expect(@owner.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは英字だけでは登録できない' do
        owner_password = 'AbcDef'
        @owner.password = owner_password
        @owner.password_confirmation = owner_password
        @owner.valid?
        expect(@owner.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは英・数字混合でも5文字以下だと登録できない' do
        owner_password = 'Ab123'
        @owner.password = owner_password
        @owner.password_confirmation = owner_password
        @owner.valid?
        expect(@owner.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it '重複したemailが既に存在する場合は登録できない' do
        @owner.save
        another_owner = FactoryBot.build(:owner)
        another_owner.email = @owner.email
        another_owner.valid?
        expect(another_owner.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'last_nameは半角だと登録できない' do
        @owner.last_name = 'hankaku'
        @owner.valid?
        expect(@owner.errors.full_messages).to include('お名前（姓）は全角文字で入力してください')
      end

      it 'first_nameは半角だと登録できない' do
        @owner.first_name = 'hankaku'
        @owner.valid?
        expect(@owner.errors.full_messages).to include('お名前（名）は全角文字で入力してください')
      end
    end
  end
end
