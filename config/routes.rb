Rails.application.routes.draw do

  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :trips, only: [:index, :show]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do

      resources :trips, except: [:new, :edit, :update, :destroy]

      put '/trips/:id', to: 'trips#finish', as: :finish

      resources :stations, only: [:index]
      resources :bikes, only: [:index]

      post 'login', to: 'users#login', as: :login
      post 'logout', to: 'users#logout', as: :logout
    end
  end
end
