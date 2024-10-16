# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/logout'
  get 'sessions/omniauth'
  get 'users/show'
  get 'welcome/index'

  resources :items
  resources :items, only: [:index, :show] 
  resources :user_profiles

  root 'welcome#index'
  get 'welcome/index', to: 'welcome#index', as: 'welcome'
  get '/users/:id', to: 'users#show', as: 'user'

  get '/logout', to: 'sessions#logout', as: 'logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
end