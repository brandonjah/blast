Rails.application.routes.draw do
  resources :contents
	resources :identities
  resources :tweets, only: [:new, :create]

  match '/auth/:provider/callback' => 'sessions#create', :via => [:get,:post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]
  match "/signout" => "sessions#destroy", :as => :signout, :via => [:get, :post]

  root to: 'contents#index'
end