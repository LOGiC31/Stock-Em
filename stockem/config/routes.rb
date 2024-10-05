Rails.application.routes.draw do
  resources :user_profiles
  root :to => redirect('/user_profiles')
end
