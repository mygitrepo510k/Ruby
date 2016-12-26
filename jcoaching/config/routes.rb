Jcoaching::Application.routes.draw do
  devise_for :users
  root "pages#home"


  #Main Menu
  get 'about' => 'pages#about'
  get 'videos' => 'pages#videos'
  get 'testimonies' => 'pages#testimonials'
  get 'confirmation' => 'pages#confirmation'


  #Sales
  get 'lp/smartvideo1' => 'lp#smartvid1'

  get 'lp/checkout' => 'lp#checkout'
  get 'lp/cancel' => 'lp#cancels'

  get 'lp/reg21agHwcm' => 'devise/registrations#new'


  #Basics Content
  get 'basics' => 'basics#home'
  get 'basics/stretches' => 'basics#stretches'
  get 'basics/wriststretches' => 'basics#wristStretches'
  get 'basics/foundationprinciples' => 'basics#foundationPrinciples'

  #Core Content
  get 'core' => 'core#home'
    get 'core/foundation/toprock' => 'core#f_toprock'
    get 'core/foundation/footwork1' => 'core#f_footwork_1'
    get 'core/foundation/footwork2' => 'core#f_footwork_2'
    get 'core/foundation/freeze1' => 'core#f_freeze_1'
    get 'core/foundation/freeze2' => 'core#f_freeze_2'  

    get 'core/power/swipes' => 'core#p_swipes'
    get 'core/power/flares' => 'core#p_flares'
    get 'core/power/turtles' => 'core#p_turtles'
    get 'core/power/glides' => 'core#p_glides'

    get 'core/bodyrock/abs' => 'core#b_abs'





  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
