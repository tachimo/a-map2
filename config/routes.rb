Rails.application.routes.draw do
  root "markers#index"
  post "/markers", to: "markers#create"
end

