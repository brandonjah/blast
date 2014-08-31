Rails.application.routes.draw do
  # get 'content/index'
  resources :contents
  root to: 'contents#index'
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout  
end