Rails.application.routes.draw do
  devise_for :staff_users, controllers: {
    registrations: 'staff_users/registrations',
    sessions: 'staff_users/sessions'
  }
  devise_for :owners, controllers: {
    registrations: 'owners/registrations',
    sessions: 'owners/sessions'
  }
  root to: 'boards#index'
  resources :boards, only: [:index, :new, :create, :show, :update] do
    member do
      get 'search'
      post 'invite'
    end
    
    resources :shifts, only: [:index]
  end
end
