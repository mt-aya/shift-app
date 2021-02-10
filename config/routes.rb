Rails.application.routes.draw do
  devise_for :staff_users, controllers: {
    registrations: 'staff_users/registrations',
    sessions: 'staff_users/sessions'
  }
  devise_for :owners, controllers: {
    registrations: 'owners/registrations',
    sessions: 'owners/sessions'
  }
  root to: 'shift_requests#index'
  resources :shift_requests, only: [:index, :create] do
    collection do
      get 'search'
      get 'submit_confirm'
      patch 'submit'
    end
  end
  resources :boards, only: [:index, :create, :update] do
    member do
      get 'search'
      post 'invite'
    end
    resources :shifts, only: [:index, :create, :update, :destroy] do
      collection do
        get 'weekly'
        get 'monthly'
        get 'calendar'
      end
    end
  end
end
