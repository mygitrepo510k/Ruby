Headcountapp::Application.routes.draw do
	namespace :admin do
    get '', to: 'dashboard#index', as: '/'

    get 'users'                         => 'users#index'
    match 'update'                      => 'users#update',        via: [:post, :patch]
    get 'edit_user/:id'                 => 'users#edit',   				as: 'edit_user'
    delete 'delete_user/:id'            => 'users#delete_user', 	as: 'delete_user'
    get 'inactive'                      => 'users#inactive'

    #get 'events'                        => 'events#index'
    resources :events
  end
  
  mount API => '/'

  devise_for :users, controllers: {sessions: "sessions"}
  root :to => 'home#index'

  post 'api/v1/accounts/create'         => 'home#create'
  post 'api/v1/accounts/destroy'        => 'home#destroy'
  
  post 'api/v1/accounts/social_sign_in' => 'home#social_sign_in'

  post 'api/v1/accounts/sign_in'        => 'home#create_session'
  post 'api/v1/accounts/sign_out'       => 'home#delete_session'
  post 'api/v1/accounts/create_account' => 'home#create_account'
  
end
