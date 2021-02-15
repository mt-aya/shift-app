require 'rails_helper'

RSpec.describe "Owners", type: :system do
  describe '新規登録' do
    let(:owner) { build(:owner) }
    context 'ユーザー新規登録ができるとき' do 
      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動すること' do
        # トップページに移動する
        visit root_path
        # トップページにシフト管理者用ページへ遷移するボタンがあることを確認する
        expect(page).to have_content('事業主様はこちら')
        # 「事業主様はこちら」のリンクをクリックするとログインページへ遷移することを確認する
        click_on '事業主様はこちら'
        expect(current_path).to eq(new_owner_session_path)
        # ログインページの「シフト管理者用アカウントの作成」のリンクをクリックすると新規登録ページへ遷移することを確認する
        click_on 'シフト管理者用アカウントの作成'
        expect(current_path).to eq(new_owner_registration_path) 
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: owner.email
        fill_in 'パスワード', with: owner.password
        fill_in 'パスワード（確認）', with: owner.password_confirmation
        fill_in '会社名', with: owner.company
        find('#owner_last_name').set(owner.last_name)
        find('#owner_first_name').set(owner.first_name)
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Owner.count }.by(1)
        # ボード一覧ページへ遷移することを確認する
        expect(current_path).to eq(boards_path) 
        # ログアウトボタンが表示されていることを確認する
        expect(page).to have_content('ログアウト')
        # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('アカウント登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ユーザー新規登録ができないとき' do
      it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくること' do
        # トップページに移動する
        visit root_path
        # トップページにシフト管理者用ページへ遷移するボタンがあることを確認する
        expect(page).to have_content('事業主様はこちら')
        # 「事業主様はこちら」のリンクをクリックするとログインページへ遷移することを確認する
        click_on '事業主様はこちら'
        expect(current_path).to eq(new_owner_session_path)
        # ログインページの「シフト管理者用アカウントの作成」のリンクをクリックすると新規登録ページへ遷移することを確認する
        click_on 'シフト管理者用アカウントの作成'
        expect(current_path).to eq(new_owner_registration_path) 
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認）', with: ''
        fill_in '会社名', with: ''
        find('#owner_last_name').set('')
        find('#owner_first_name').set('')
        # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Owner.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/owners')
      end
    end
  end

  describe 'ログイン' do
    let(:owner) { create(:owner) }
    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにシフト管理者用ページへ遷移するボタンがあることを確認する
        expect(page).to have_content('事業主様はこちら')
        # 「事業主様はこちら」のリンクをクリックするとログインページへ遷移することを確認する
        click_on '事業主様はこちら'
        expect(current_path).to eq(new_owner_session_path)
        # 正しいユーザー情報を入力する
        fill_in 'メールアドレス', with: owner.email
        fill_in 'パスワード', with: owner.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ボード一覧ページへ遷移することを確認する
        expect(current_path).to eq(boards_path) 
        # ログアウトボタンが表示されていることを確認する
        expect(page).to have_content('ログアウト')
        # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('アカウント登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        # トップページに移動する
        visit root_path
        # トップページにシフト管理者用ページへ遷移するボタンがあることを確認する
        expect(page).to have_content('事業主様はこちら')
        # 「事業主様はこちら」のリンクをクリックするとログインページへ遷移することを確認する
        click_on '事業主様はこちら'
        expect(current_path).to eq(new_owner_session_path)
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページへ戻されることを確認する
        expect(current_path).to eq(new_owner_session_path)
      end
    end
  end
end