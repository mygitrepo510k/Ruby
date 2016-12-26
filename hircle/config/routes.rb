Hircle::Application.routes.draw do

  devise_for :users,  :controllers => { :registrations => "users/registrations",:passwords => "users/passwords" }
  resources :users do
    resources :conversations, :only => [:index, :show, :new, :create, :update] do
    end
  end
  # social network routing  
  match "/auth/callback",                             :to => "SocialAuthentications#linkedin_login"
  match "/save_fb_info",                              :to => "SocialAuthentications#create_by_facebook"
  match "/save_linkedin_info",                        :to => "SocialAuthentications#create_by_linkedin"

  #dashboard routes
  resources :dashboard, :only => [:index]
  match "/employer/jobs",                             :to => "dashboard#employer_jobs"
  match "/employer/new/job",                          :to => "dashboard#new_job_post"
  match "/submit_step_one",                           :to => "dashboard#submit_step_one"
  match "/submit_step_two",                           :to => "dashboard#submit_step_two"
  match "/employer/jobs/applicants",                  :to => "dashboard#job_applicants"
  match "/employer/show/job/:id",                     :to => "dashboard#show_job"  
  match "/get_user_name",                             :to => "dashboard#get_user"
  match "/employer/tasks",                            :to => "dashboard#task_board"
  
  resources :invitations  

  resources :profiles

  resources :tasks
  match "/task_update/:id",                           :to => "tasks#update"     

  resources :conversations

  resources :resources

  resources :departments

  resources :companies

  resources :activities

  resources :comments
  
  resources :user_settings, :only => [:index]

  resources :spaces

   resources :spaces_users
   
    resources :orders

  resources :networks, :only => ["index"] do
    collection do
      post :connect
      post :connected
      post :apccept
    end
  end

  namespace :settings do
    resources :payment 
    resources :invoice
    resources :plan   
  end
 
  get "welcome/index"

  get "plan/index"

  get "invoice/index"

  get "payment/index"

  get "administrator/index"
  
  get "job_seeker/index"
  post "job_seeker/resume"
  get "interview/index"
  
  get "orders/new"

  #add by Yang
  get "departments/query_statistical_datas"

  get "departments/:id/documents" => "departments#documents", :via => [:get]


  match "departments/:ids/addemployees/:department_id" => "departments#addemployees", :via => [:post,:get]
  #query departments's avtivities 
  match "activities/:id/comments" => "activities#comments", :via => [:get] 
  match "departments/:id/activities" => "departments#activities", :via => [:get] 
  match "departments/:id/employees" => "departments#employees", :via => [:get] 

  match "companies/:id/employees" => "companies#employees", :via => [:get] 
  match "companies/:id/employees/:name" => "companies#employees", :via => [:get] 

  # match "companies/:company_id/departments/:id" => "departments#destroy", :via => [:delete]
  # match "companies/:company_id/departments" => "departments#create", :via => [:post] 
  match "companies/:id/departments" => "companies#departments", :via => [:get]

  get 'settings/company' => 'settings#company_setting', :as => 'company_setting'
  put 'company/update(/:id)' => 'settings#update_company_setting', :as => 'update_company'

  #add by Mani to check - HTML file Integration
  
  match "task_management" => "tasks#task_management", :as => "task_management"
   



  #saving settings path
  match "/submit_search"                      =>  "user_settings#save_search"
  match "/submit_zone"                        =>  "user_settings#save_zone"
  match "/cancel_account"                     =>  "user_settings#cancel_account"
  match "/submit_privacy"                     =>  "user_settings#save_privacy"
  match "/user_settings/update_password"      =>  "users/passwords#update"
   
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
