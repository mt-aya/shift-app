require 'rails_helper'

RSpec.describe 'ShiftRequestsController', type: :request do
  let(:staff_user) { create(:staff_user) }
  let(:owner) { create(:owner) }
  let(:shift_request) { create(:shift_request, staff_user_id: staff_user.id) }

  shared_context 'staff_user' do
    before do
      sign_in staff_user
    end
  end
  shared_context 'owner' do
    before do
      sign_in owner
    end
  end

  describe 'GET #index' do
    shared_examples 'indexテンプレートで表示されること' do
      it do
        get root_path
        expect(response).to render_template :index
      end
    end

    context 'staff_userとしてログインしているとき' do
      include_context 'staff_user'
      it_behaves_like 'indexテンプレートで表示されること'

      it '正常にレスポンスが返ってくること' do
        get root_path
        expect(response.status).to eq 200
      end

      it '自分の作成済みのシフト希望の時間が存在すること' do
        get root_path
        expect(response.body).to_not include(shift_request.start_time.strftime('%H:%M'))
      end

      it 'シフトアプリの紹介文が存在しないこと' do
        get root_path
        expect(response.body).to_not include('シフト管理が、カンタンに')
      end
    end

    context 'ownerとしてログインしているとき' do
      include_context 'owner'
      it_behaves_like 'indexテンプレートで表示されること'

      it '正常にレスポンスが返ってくること' do
        get root_path
        expect(response.status).to eq 200
      end

      it 'シフトアプリの紹介文が存在すること' do
        get root_path
        expect(response.body).to include('シフト管理が、カンタンに')
      end
    end

    context 'ログインしていないとき' do
      it_behaves_like 'indexテンプレートで表示されること'

      it '正常にレスポンスが返ってくること' do
        get root_path
        expect(response.status).to eq 200
      end

      it 'シフトアプリの紹介文が存在すること' do
        get root_path
        expect(response.body).to include('シフト管理が、カンタンに')
      end
    end
  end

  describe 'GET #search' do
    context 'staff_userとしてログインしているとき' do
      include_context 'staff_user'
      it '正常にレスポンスが返ってくること' do
        get search_shift_requests_path
        expect(response.status).to eq 200
      end

      it 'searchテンプレートで表示されること' do
        get search_shift_requests_path
        expect(response).to render_template :search
      end
    end

    context 'ownerとしてログインしているとき' do
      include_context 'owner'
      it 'root_pathにリダイレクトすること' do
        get search_shift_requests_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインしてないとき' do
      it 'root_pathにリダイレクトすること' do
        get search_shift_requests_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
