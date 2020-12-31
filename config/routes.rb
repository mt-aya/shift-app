Rails.application.routes.draw do
  devise_for :staff_users, constrollers: {
    registrations: 'staff_users/registrations',
    sessions: 'staff_users/sessions'
  }
  devise_for :administrators, constrollers: {
    resistrations: 'administrations/registrations',
    sessions: 'administrators/sessions'
  }
  root to: 'shifts#index'
end
