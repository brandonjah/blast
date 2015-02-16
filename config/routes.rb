Rails.application.routes.draw do
  resources :contents
	resources :identities
	resources :sessions
  resources :tweets, only: [:new, :create]

  match '/auth/:provider/callback' => 'sessions#create', :via => [:get,:post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]
  match "/signout" => "sessions#destroy", :as => :signout, :via => [:get, :post]
  get 'auth/facebook', as: "auth_provider"
  get 'auth/facebook/callback', to: 'users#login'


  match "/privacy" => "pages#privacy", :as => :privacy, :via => :get

  # these two routes must be last
  match ':landing_page' => "contents#landing_page", :as => "landing_page", :via => [:get], :defaults => { :landing_page => ':landing_page' }
  root to: 'pages#home'
end