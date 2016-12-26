MountainLion::Application.routes.draw do

  get "landing1", to: 'seo#landing1'
  get "men", to: 'seo#men', as: 'seo_men'
  get "women", to: 'seo#women', as: 'seo_women'
  match "/404", :to => "errors#not_found", via: [:get, :post, :delete, :put]
  match "/500", :to => "errors#something_wrong", via: [:get, :post, :delete, :put]
  get "/cities", to: "ajax#cities"
  get "search", to: "search#index"
  get "search/advanced", as: 'advanced_search'
  post "search/create"
  get "search/simple", to: "search#simple"
  post "search/advanced", to: "search#create"
  resources :password_resets
  resources :sessions
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "users/activate/:activation_token", to: "users#activate", as: "activate_user_profile"
  get 'upgrade', to: "upgrade#index", as: 'upgrade'
  post 'upgrade/payment', to: 'upgrade#payment', as: 'upgrade_payment'
  get 'messages/new_flirt', to: "messages#new_flirt", as: "new_flirt"
  resources :messages do
    collection do
      get :inbox
      get :sent
      get :deleted
      delete :delete
    end
    member do
      get :abuse
    end
  end
  get "logout", to: "sessions#destroy", as: "logout"
  get "welcome", to: "welcome#home", as: "welcome"
  get "users/profile", to: "users#show", as: "user_profile"
  get "users/like/:user_id", to: "users#manage_likes", as: "manage_likes"
  resources :users do
    collection do
      get :likes
      get :liked
      get :views
      get :matches
      post :signup_one
      post :signup_two
    end
    member do
      get :unsubscribe
      get :mandatory_edit_profile
    end
    resources :user_photos do
      member do
        get :edit_profile_photo, to: "user_photos#edit"
        put :update_profile_photo, to: "user_photos#update"
      end
    end
  end
  namespace "admin" do
    get "dashboard", to: "dashboard#index", as: "root"
    post "users/approve_photos", to: "users#approve_photos", as: 'approve_photos'
    resources :users do
      resources :messages do
        collection do
          get :inbox
          get :sent
        end
      end
      member do
        delete :destroy_photo
        post :block
        post :unblock
        post :login
        post :logout
        post :resend_activation
      end
      resources :subscriptions, only: [:show]
    end
    resources :profile_sections do
      member do
        post :sort_questions
      end
      collection do
        post :sort_sections
      end
    end
    resources :profile_questions
    resources :flirts do
      collection do
        post :sort
      end
    end
    resources :internal_notifications
  end

  get 'account', to: 'accounts#index', as: 'account'
  put 'account/update', to: 'accounts#update', as: 'update_account'
  get '/confirmation', to: 'welcome#confirmation', as: 'confirmation'
  get '/:page', to: 'welcome#static_page', as: 'static_page'
  post '/contact', to: 'welcome#contact', as: 'contact'
  root to: "welcome#home"
end
