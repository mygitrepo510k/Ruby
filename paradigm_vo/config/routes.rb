ParadigmVo::Application.routes.draw do

  root :to => 'pages#home'

  resources :artists do
    resources :uploads
    resources :voiceovers do
      collection do
        post 'sort'
      end
    end
  end
  
  resources :videos
	resources :pages

  get 'browse' => 'voiceovers#index', as: :browse
  get 'search' => 'voiceovers#index', as: :search
	
	get 'terms_of_use' => 'terms#index', as: :terms

	resources :lists, only: [:show], module: 'admin'
	match 'admin/lists/:id/send' => 'admin/lists#edit', as: :send_list

  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'invite' }, controllers: { confirmations: 'admin/confirmations', registrations: 'admin/registrations' } do #, skip: [:registrations] do
    get 'admin/logout' => 'devise/sessions#destroy', as: :destroy_admin_session
    
    get 'admin/new' => 'devise/registrations#new', as: :new_admin_registration
    
    put '/admin/confirmation' => 'admin/confirmations#update', :as=> :update_admin_confirmation

		match '/admin/list/new' => redirect('/admin/lists/new')
  end

	namespace :admin do
		resources :lists
	end

mount RailsAdmin::Engine => '/paradigm_admin', :as => 'admin'
end