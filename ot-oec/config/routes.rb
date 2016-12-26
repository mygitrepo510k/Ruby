OtOec::Application.routes.draw do
	use_link_thumbnailer
	# get 'challenge_frames/show'

	devise_for :users

  get 'programs/:id/switch', to: 'programs#switch', as: 'switch_program'
  get 'refresh', to: 'programs#refresh', as: 'refresh'

	get 'users/change_safeword', to: 'users#change_safeword', as: 'change_safeword'
	get 'content_frames/judge', to: 'challenge_frames#judge', as: 'judge_challenge_frame'
	get 'experiece/executed', to: 'experiences#executed', as: 'experience_executed'
	get 'user/typeforms/intake', to: 'type_forms#intake', as: 'edit_intake'
	post 'user/typeforms/intake', to: 'type_forms#update_intake'
	get 'users/confirm/:token', to: 'users#confirm', as: 'confirm_user'
	get 'terms', to: 'dashboard#terms', as: 'static_terms'
	get 'support', to: 'dashboard#support', as: 'static_support'

	get 'content', to: 'contents#main', as: 'content'
	get 'content_load', to: 'contents#content_load', as: 'content_load'

	get 'admin', to: 'admin#index'
	get 'content/delete_content_group', to: 'dashboard#delete_course_content_group', as: 'delete_course_content_group'

	resources :users do
    patch 'set_password'
  end

	get 'calendar', to: 'calendar#index', as: 'calendar'
	get 'get_events', to: 'calendar#get_events', as: 'get_events'
	
	resources :users
  resources :user_programs, only: [:update]

	resources :posts do
 		post 'search', on: :collection
 	end

	resources :announcements, only: [:show]
	resources :challenges
	resources :experiences
	resources :challenge_frames
	resources :comments, except: [:show, :index]
	resources :content_groups, except: [:index]
  resources :contents, only: [:new]

  
  post 'like', to: 'likes#create'

	root 'dashboard#index'

	namespace :admin do
		resources :users do
    	get :resend_welcome_mail
      get :import
      get :get_intake
    end

    resources :pods
    resources :announcements
    resources :programs
    resources :challenges
    resources :events
    resources :contents
	  resources :experiences do
      post 'add_follower'
    end
    get :autocomplete_user_name

    get 'frames', to: 'frames#index'

		get 'grid', to: 'grid#thegrid', as: 'thegrid'
		get 'grid/challenges', to: 'grid#challenges'
		get 'grid/experiences', to: 'grid#experiences'

		get 'typeforms/associate', to: 'type_forms#associate'
		get 'typeforms/missing', to: 'type_forms#missing_intakes'
		get 'typeforms/associate/reload', to: 'type_forms#reload_intakes', as: 'reload_intake_forms'

		post 'typeforms/associate', to: 'type_forms#update_associate'
		post 'users/import', to: 'users#submit_import'

		resources :tags 		#added by leon
	end

  # get '/calendar(/:year(/:month(/:day)))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/}
end
