H1bwiki::Application.routes.draw do

  
  root :to => "static_pages#home"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post "applicants/create"
  post "applicants/destroy"

  get "applicants" => "applicants#applicants", :as => "applicants"


  get "search_employer/h1bemployer"
  get "search_employer/h1bemp_name"


  resources :search_employer do
    member do
      post :rate
    end
    member do
      post :add_comment
    end
  end
  
  #mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "messagebox/inbox"
  get "messagebox/sent"
  get "messagebox/deleted"

  #match 'conversations/:id' => 'messagebox#sent'

  resources :jobseeker_jobs
  post 'jobseeker_jobs/preview'
  resources :jobseeker_trainings
  post 'jobseeker_trainings/preview'
  resources :jobseeker_mentors
  post 'jobseeker_mentors/preview'

  resources :post_jobs
  post 'post_jobs/preview'
  resources :post_trainings  
  post 'post_trainings/preview'
  resources :post_mentors
  post 'post_mentors/preview'
  
  resources :skills    
  resources :countries
  
  match 'add_skill' => 'skills#add_skill', :as => 'add_skill'

  devise_for :users, :controllers => {:registrations => "registrations" } do
  ActiveAdmin.routes(self)
    get "registrations/new_jobseeker", :to => "registrations#new_jobseeker", :as => "new_jobseeker"
    get "registrations/new_employer", :to => "registrations#new_employer", :as => "new_employer"        
  end
  
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/help"
  get "static_pages/contact"  
  get "static_pages/post_main", :as =>"post_main"
  get "static_pages/posts", :as => "posts_view"

  get "static_pages/jobseeker_post_main", :as =>"jobseeker_post_main"
  get "static_pages/jobseeker_posts", :as => "jobseeker_posts"
  
  get "static_pages/search_home", :as => "search_home"
  get "static_pages/search_indeed", :as=> "search_indeed"

  post "/static_pages/forward"
  post "/static_pages/training_forward"

  get "account_setup" => "static_pages#account_setup"
  get "account_details" => "static_pages#account_details"
  match "update_profile" => "static_pages#update_profile"
  match "change_passwd" => "static_pages#change_passwd"
  match "reset_passwd" => "static_pages#reset_passwd"
  
  match 'signup'  => 'static_pages#signup'

  get "/postings"  => 'static_pages#postings'
  get "/post_main" => 'static_pages#post_mains'
end
