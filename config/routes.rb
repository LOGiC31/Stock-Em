# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/logout'
  get 'sessions/omniauth'
  get 'users/show'
  get 'welcome/index'

  resources :items do
    member do
      patch :set_status
    end
  end
  resources :user_profiles
  resources :users

  root 'welcome#index'
  get 'welcome/index', to: 'welcome#index', as: 'welcome'

  get '/logout', to: 'sessions#logout', as: 'logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  get '/add_note_to_item', to: 'items#add_note', as: 'add_note'
end
