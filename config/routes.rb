Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :trips, only: [:index, :show]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do

      resources :trips, except: [:new, :edit, :update, :destroy]

      put '/trips/:id', to: 'trips#finish', as: :finish

      resources :stations, only: [:index]
      resources :bikes, only: [:index]
    end
  end
end
