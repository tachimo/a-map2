Rails.application.routes.draw do
  resources :markers, only: [:index, :create]
  resources :garbage_spots
  root "markers#index"
end

