Rails.application.routes.draw do
  devise_for :staff_users
  devise_for :administrators
  root to: 'shifts#index'
end
