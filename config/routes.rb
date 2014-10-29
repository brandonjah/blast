Rails.application.routes.draw do
  resources :contents
	resources :identities
  resources :tweets, only: [:new, :create]

  match '/auth/:provider/callback' => 'sessions#create', :via => [:get,:post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]
  match "/signout" => "sessions#destroy", :as => :signout, :via => [:get, :post]

  match ':landing_page' => "contents#landing_page", :as => "landing_page", :via => [:get], :defaults => { :landing_page => ':landing_page' }

  root to: 'pages#home'
end