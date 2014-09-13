Rails.application.routes.draw do
  resources :contents

  resources :tweets, only: [:new, :create]

  get "/auth/:provider/callback" => "sessions#create"
  get 'auth/failure', to: redirect('/')
  get "/signout" => "sessions#destroy", :as => :signout

  root to: 'contents#index'
end