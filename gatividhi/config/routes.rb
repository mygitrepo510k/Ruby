Gatividhi::Application.routes.draw do
  

  get "calendar/month"
  get "calendar/week"
  get "calendar/day"
  get "calendar/get_data"
  
  get "calendar/parent_month"
  get "calendar/parent_week"
  get "calendar/parent_day"
  get "calendar/get_parent_data"

  get "calendar/time_line"
  get "calendar/time_line_data"

  get "school/general"
  post "school/save_school"
  post "school/delete_school"

  get "school/timetable"  
    
  get "school/assignments"
  match "school/add_new_assignment" => "school#add_new_assignment"
  match "school/edit_assignment"    => "school#edit_assignment"
  post "school/delete_assignment"   => "school#delete_assignment"
  match 'school/show_list'          => 'school#show_list'
  match 'add_assignments_outcome'   => 'school#add_assignments_outcome'
  

  get "school/feedback"
  post "school/delete_feedback"     => "school#delete_feedback"
  match "school/add_new_feedback"   => "school#add_new_feedback"
  match "school/edit_feedback"      => "school#edit_feedback"  
  match 'school/show_feedback'      => 'school#show_feedback'

  get "school/holidays"
  post "school/delete_holiday"     => "school#delete_holiday"  
  match "school/add_new_holiday"   => "school#add_new_holiday"
  match "school/edit_holiday"      => "school#edit_holiday"  
  match 'school/show_holidays'      => 'school#show_holidays'

  get "school/teachers"
  post "school/delete_teacher"     => "school#delete_teacher"  
  match "school/add_new_teacher"   => "school#add_new_teacher"
  match "school/edit_teacher"      => "school#edit_teacher"  
  match 'school/show_teacher'      => 'school#show_teacher'

  get 'parent_profile'        => 'profile#parent_profile',      :as => :parent_profile
  get 'parent_occupational'   => 'profile#parent_occupational', :as => :parent_occupational
  get 'parent_financial'      => 'profile#parent_financial',    :as => :parent_financial
  get 'parent_policies'       => 'profile#parent_policies',     :as => :parent_policies
  get 'child_profile'         => 'profile#child_profile',       :as => :child_profile
  get 'child_milestone'       => 'profile#child_milestone',     :as => :child_milestone
  get 'child_interest'        => 'profile#child_interest',      :as => :child_interest
  
  post 'profile/delete_child_interest'

  post 'profile/parent_save_value'
  post 'profile/child_save_value'
  post 'profile/upload'
  
  post 'profile/interest_save_value'


  post 'profile/save_advaces_paid'
  post 'profile/edit_advances_paid'  
  post 'profile/delete_advaces_paid'

  post 'profile/save_child_related_policies'
  post 'profile/edit_child_related_policies'
  post 'profile/delete_child_related_policies'

  post 'profile/save_policy'
  post 'profile/edit_policy'
  post 'profile/delete_policy'
  

  
  resources :families

  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  get "/home/dashboard", :as => :dashboard

  devise_for :users


  match 'dashboard'             => 'users#dashboard', :as => :dashboard
  match 'add_new_family'        => 'users#add_new_family', :as => :add_new_family
  match 'associate_to_family'   => 'users#associate_to_family', :as => :associate_to_family
  match 'add_new_family_member' => 'users#add_new_family_member', :as => :add_new_family_member
  match 'verify_family_member'  => 'users#verify_family_member', :as => :verify_family_member
  
  match 'child_profile_health'                            => 'users#child_profile_health',                            :as => :child_profile_health 
  match 'child_profile_health_value_update'               => 'users#child_profile_health_value_update',               :as => :child_profile_health_value_update 
  match 'child_profile_health_vaccination_medication'     => 'users#child_profile_health_vaccination_medication',     :as => :child_profile_health_vaccination_medication
  match 'child_profile_health_record'                     => 'users#child_profile_health_record',                     :as => :child_profile_health_record
  match 'child_profile_health_test_reports'               => 'users#child_profile_health_test_reports',               :as => :child_profile_health_test_reports
  match 'child_genral_health_data'                        => 'users#child_genral_health_data',                        :as => :child_genral_health_data
  match 'child_genral_health_data_update'                 => 'users#child_genral_health_data_update',                 :as => :child_genral_health_data_update
  post 'users/genral_data_save'                           => 'users#genral_data_save'
  post 'users/genral_injuries_data_save'                  => 'users#genral_injuries_data_save'
  post 'users/genral_major_illnesses_save'                => 'users#genral_major_illnesses_save'

  match 'child_injuries'                                  => 'users#child_injuries',                                  :as => :child_injuries
  match 'child_injuries_update'                           => 'users#child_injuries_update',                           :as => :child_injuries_update

  match 'child_major_illnesses'                           => 'users#child_major_illnesses',                           :as => :child_major_illnesses
  match 'child_major_illnesses_update'                    => 'users#child_major_illnesses_update',                    :as => :child_major_illnesses_update

  match 'add_child_profile_health_test_reports'           => 'users#add_child_profile_health_test_reports',           :as => :add_child_profile_health_test_reports
  match 'add_child_profile_health_vaccination_medication' => 'users#add_child_profile_health_vaccination_medication', :as => :add_child_profile_health_vaccination_medication
  

  match 'delete_child_profile_health_test_reports'            => 'users#delete_child_profile_health_test_reports',            :as => :delete_child_profile_health_test_reports
  match 'delete_child_profile_health_vaccination_medication'  => 'users#delete_child_profile_health_vaccination_medication',  :as => :delete_child_profile_health_vaccination_medication
  
  match 'show_list'                => 'users#show_list',                :as => :show_list
  match 'health_test_reports_list' => 'users#health_test_reports_list', :as => :health_test_reports_list


  match 'delete_single_health_issue'  => 'users#delete_single_health_issue',  :as => :delete_single_health_issue
  match 'delete_single_injury'        => 'users#delete_single_injury',        :as => :delete_single_injury
  match 'delete_single_major_illness' => 'users#delete_single_major_illness', :as => :delete_single_major_illness
  


  match "/album/add_album"      => 'album#add_album'
  match "/album/add_photo"      => 'album#add_photo'
  match 'photo_list'            => 'album#photo_list', :as => :photo_list
  match 'album_list'            => 'album#album_list', :as => :album_list
  match 'destroy_photo'         => 'album#destroy_photo', :as => :destroy_photo
  match 'destroy_album'         => 'album#destroy_album', :as => :destroy_album

  get "child_family_activities/child_activities_list"
  match 'add_child_activities_list'     => 'child_family_activities#add_child_activities_list', :as => :add_child_activities_list
  match 'child_activities_list'         => 'child_family_activities#child_activities_list', :as => :child_activities_list
  match 'show_child_activities_list'    => 'child_family_activities#show_child_activities_list', :as => :show_child_activities_list
  match 'child_awards_and_honours'      => 'child_family_activities#child_awards_and_honours', :as => :child_awards_and_honours
  
  match 'child_awards_and_honours/filter' => 'child_family_activities#ha_filter'

  match 'add_child_profile_awards'      => 'child_family_activities#add_child_profile_awards', :as => :add_child_profile_awards
  match 'delete_child_profile_awards'   => 'child_family_activities#delete_child_profile_awards', :as => :delete_child_profile_awards
  
  match 'delete_child_activities_list'  => 'child_family_activities#delete_child_activities_list', :as => :delete_child_activities_list
  match 'add_child_activities_outcome'  => 'child_family_activities#add_child_activities_outcome', :as => :add_child_activities_outcome
  match 'view_single_test_report_photo' => 'child_family_activities#view_single_test_report_photo', :as => :view_single_test_report_photo
  match 'view_child_profile_photo'      => 'child_family_activities#view_child_profile_photo', :as => :view_child_profile_photo

  match 'child_upcoming_exam'   => 'child_family_activities#child_upcoming_exam',   :as => :child_upcoming_exam
  match 'create_exam'           => 'child_family_activities#create_exam',           :as => :create_exam
  match 'delete_exam'           => 'child_family_activities#delete_exam',           :as => :delete_exam
  match 'create_exam_schedule'  => 'child_family_activities#create_exam_schedule',  :as => :create_exam_schedule
  match 'delete_exam_schedule'  => 'child_family_activities#delete_exam_schedule',  :as => :delete_exam_schedule
  match 'show_exam'             => 'child_family_activities#show_exam',             :as => :show_exam
  match 'child_exam_result'     => 'child_family_activities#child_exam_result',     :as => :child_exam_result
  
  resources :users
end