Parknow::Application.routes.draw do
  get "user/index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  
  mount API => '/'
	
	post 'api/v1/auth/login'        => 'home#create_session'
  post 'api/v1/auth/logout'       => 'home#delete_session'

  namespace :admin do
  	resources :users
    get 'users/auth_tokens/:id'   => 'users#new_auth_token',   as: 'new_auth_token'
    post 'users/auth_tokens'      => 'users#create_auth_token', as: 'auth_tokens'
    
    get 'users/auth_tokens/edit/:id'    => 'users#edit_auth_token', as: 'edit_auth_token'
    #put 'users/auth_tokens/:id'    => 'users#update_auth_token', as: 'auth_token'    
    match 'users/auth_tokens/:id'  => 'users#update_auth_token', as: 'auth_token', via: [:put, :patch]
    delete 'users/auth_token/:id' => 'users#destroy_auth_token', as: 'destroy_auth_token'

  end

  root :to => "home#index"  
end
