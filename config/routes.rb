Rails.application.routes.draw do
  devise_for :staff_users, controllers: {
    registrations: 'staff_users/registrations',
    sessions: 'staff_users/sessions'
  }
  devise_for :owners, controllers: {
    registrations: 'owners/registrations',
    sessions: 'owners/sessions'
  }
  root to: 'shifts#index'
end
