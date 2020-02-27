Rails.application.routes.draw do
  resources :trips, only: [:index, :show]

  namespace :api do
    namespace :v1 do

      resources :trips, except: [:new, :edit, :destroy]
    end
  end
end
