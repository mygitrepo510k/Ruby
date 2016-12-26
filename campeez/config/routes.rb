Campeez::Application.routes.draw do
  get "home/rv_list" => "home#rv_list"
  devise_for :users
  root "home#index"

  end
