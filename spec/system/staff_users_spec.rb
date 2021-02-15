require 'rails_helper'

RSpec.describe "StaffUsers", type: :system do
  describe '新規登録' do
    let(:staff) { build(:staff_user) }
    context 'ユーザー新規登録ができるとき' do 
      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動すること' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('アカウント登録')
        # 新規登録ページへ移動する
        visit new_staff_user_registration_path
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: staff.email
        fill_in 'ユーザーID', with: staff.id_name
        fill_in 'パスワード', with: staff.password
        fill_in 'パスワード（確認）', with: staff.password_confirmation
        find('#staff_user_last_name').set(staff.last_name)
        find('#staff_user_first_name').set(staff.first_name)
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { StaffUser.count }.by(1)
        # トップページへ遷移する
        expect(current_path).to eq(root_path)
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
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content('アカウント登録')
        # 新規登録ページへ移動する
        visit new_staff_user_registration_path
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: ''
        fill_in 'ユーザーID', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認）', with: ''
        find('#staff_user_last_name').set('')
        find('#staff_user_first_name').set('')
        # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { StaffUser.count }.by(0)
        # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq('/staff_users')
      end
    end
  end

  describe 'ログイン' do
    let(:staff) { create(:staff_user) }
    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_staff_user_session_path
        # 正しいユーザー情報を入力する
        fill_in 'メールアドレス', with: staff.email
        fill_in 'パスワード', with: staff.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移することを確認する
        expect(current_path).to eq(root_path)
        # ログアウトボタンが表示されていることを確認する
        expect(page).to have_content('ログアウト')
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('アカウント登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_staff_user_session_path
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページへ戻されることを確認する
        expect(current_path).to eq(new_staff_user_session_path)
      end
    end
  end
end
