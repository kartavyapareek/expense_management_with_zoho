# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'zoho_authorization/redirect', to: 'zoho_authorization#redirect', as: :zoho_authorization_redirect
  get 'zoho_authorization/callback', to: 'zoho_authorization#callback', as: :zoho_authorization_callback

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'home/index' => 'home#index'
  root 'home#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
