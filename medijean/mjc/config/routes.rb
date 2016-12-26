#require 'resque_web'
require 'resque/server'

Web::Application.routes.draw do

  resque_constraint = lambda do |request|
    request.env['warden'].authenticate? and request.env['warden'].user.role?(:sysadmin)
  end

  constraints resque_constraint do
    mount Resque::Server.new, :at => "/admin/resque_web"
  end


  mount Ckeditor::Engine => '/ckeditor'

  get "knowledge_centre" => "knowledge_centre#index"
  get "/kc/:page_url" => "knowledge_centre#index"

  get "/settings/profile" => "settings#profile"       # profile setting
  get "/settings/account" => "settings#account"       # account setting
  get "/settings/payment" => "settings#payment"       # payment setting
  get "/settings/notification" => "settings#notification"       # payment setting

  match "/profile/update" =>  "profiles#update"
  match "/profiles/account" =>  "profiles#account"
  match "/profiles/change_password" =>  "profiles#change_password"

  match "/profiles/notification" => "profiles#notification"

  get "invitations/:token/confirm" => "users/invitation_registrations#new", as: :invitation_confirmation

  resources :payment_profiles
  get '/edit' => "payment_profiles#edit"

  scope module: 'doctors' do
    resources :profiles, only: [:show]
  end

  get "prescriptions/upload"
  post "prescriptions/create"

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users,:controllers => {:registrations => "users/registrations", :confirmations => "users/confirmations"}

  devise_scope :user do
    get "registrations/profile", :to => "users/registrations#profile"
    get "registrations/invitation_profile", :to => "users/registrations#invitation_profile"
    post "users/registrations/complete_profile"
    get "registrations/find_doctor", :to => "users/registrations#find_doctor"
    get "registrations/welcome", :to => "users/registrations#welcome"
    get "registrations/:role", to: "users/registrations#new", as: :registrations_by_role
  end


  match 'users/dashboard' => 'users#dashboard', :via => :get
  match 'doctors/dashboard' => 'doctors#dashboard', via: :get

  resources :doctors do
    collection do
      get 'search'
      get 'claim_profile'
      get 'invite_patient'
      get 'search_patients'
      get 'pending_claim'
    end
  end

  resources :doctor_patients do
    resources :prescriptions, only: [:new, :create, :index, :show], controller: 'doctors/prescriptions'
  end

  resources :prescriptions do
    member do
      get 'review'
    end
  end

  get "dashboard", :to => "dashboard#index"


  resources :orders do
    # TODO define orders related routes here..
    get 'complete', on: :collection
  end

  resources :notifications

  root :to => 'home#index'

  ActiveAdmin.routes(self)

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
