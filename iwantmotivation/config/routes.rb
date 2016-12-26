Iwantmotivation::Application.routes.draw do
  
  resources :groups


  get "admin/home"
  get "admin/stores"
  get "admin/public_group"
  get "admin/options"

  post "admin/save_category"
  post "admin/delete_category"

  post "admin/save_foundus"
  post "admin/delete_foundus"
  post "admin/update_option"

  resources :stores


  root :to => "home#index"
  resources :options

  mount StripeEvent::Engine => '/stripe'
  get "content/full"
  get "content/limited"
  get "content/free"
  get "content/coach"
  get "content/counselor"
  authenticated :user do
    root :to => 'home#index'
  end
  
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :invitations => 'invitations' }
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end
  
  get  'success_payments' => 'users#paypal_success'
  get  'cancel_payments' => 'users#paypal_cancel' 

  resources :users, :only => :show do
    member do
      get :profile
      post :change_city
      post :change_state
      post :change_country

      post :change_cch_philosophy
      post :change_cch_experience
      post :change_cch_helppeople
    end
    resources :chat_conversations, :only => [:index, :show, :new, :create, :update] do
    end
  end
  
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get "signup", :to => "home#signup"  
  get "couchcounselor_signup", :to => "home#couchcounselor_signup"

  get "home/find_motivation_partner"
  get "home/motivation_partner_group"
  get "home/find_coach"
  get "home/motivation_video"
  get "home/motivation_forum"
  get "home/blog"
  get "home/stores"
  
  get "home/store/:id" => "home#store"
  get "home/contact_us"
  get "home/coach_counselor_pay"
  get 'home/partner/:id' => 'home#partner_profile'
  get 'home/coach_counselor_profile/:id' =>'home#coach_counselor_profile'
  get 'home/welcome'
  
  post "pusher/auth"

  # check controller
  get "home/check_screen_name"
  get "home/check_email"

end