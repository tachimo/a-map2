Rails.application.routes.draw do
  resources :markers, only: [:index, :create]
  root "markers#index"
end

