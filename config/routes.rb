Rails.application.routes.draw do
  resources :trips, except: [:edit, :update, :destroy]
end
