Rails.application.routes.draw do
  resources :trips, only: [:index, :show, :create, :update]
end
