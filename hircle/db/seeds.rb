# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "----create demo data for department,company,activity,comment-------"
company=Company.create!(:name=>'sohu',:website=>'www.sohu.com')

department1=Department.create!(:name=>'UI Design ',:company_id=>company.id)
department2=Department.create!(:name=>'Rails developer',:company_id=>company.id)

puts "##### Creating Demo Roles #####"


admin = Role.create!(:name=>"Admin",:description=>"Administrator role")
role1=Role.create!(:name=>"Employee",:description=>"Employee role")
hr_role = Role.create!(:name=>"HR",:description=>"HR manager role")
job_seeker_role = Role.create!(:name=>"Job Seeker",:description=>"Job seeker role")


puts "##### Creating Demo Users #####"
#Modify by Yang

admin_user = User.create!(:email=>'admin@hircle.com',:password=>"pleaseplease",:password_confirmation=>"pleaseplease",:role_id=>admin.id,:first_name =>"fadmin",:last_name =>"ladmin",:company_id =>company.id,:department_id=>department1.id)
job_seeker_user = User.create!(:email=>'jobseeker@hircle.com',:password=>"pleaseplease",:password_confirmation=>"pleaseplease",:role_id=>job_seeker_role.id,:first_name =>"fjs",:last_name =>"ljs")
employee_user = User.create!(:email=>'employee@hircle.com',:password=>"pleaseplease",:password_confirmation=>"pleaseplease",:role_id=>role1.id,:first_name =>"femp",:last_name =>"lemp",:company_id =>company.id,:department_id=>department1.id)
hr_user = User.create!(:email=>'hr@hircle.com',:password=>"pleaseplease",:password_confirmation=>"pleaseplease",:role_id=>hr_role.id,:first_name =>"fhr",:last_name =>"lhr",:company_id =>company.id,:department_id=>department1.id)


user1 = User.create(:email => "user1@example.com",:password => "pleaseplease",:password_confirmation => "pleaseplease",:role_id=>role1.id,:first_name =>"fuser1",:last_name =>"luser1",:company_id=>company.id,:department_id=>department2.id)
user2 = User.create(:email => "user2@example.com",:password => "pleaseplease",:password_confirmation => "pleaseplease",:role_id=>role1.id,:first_name =>"fuser2",:last_name =>"luser2",:company_id=>company.id,:department_id=>department2.id)
user3 = User.create(:email => "user3@example.com",:password => "pleaseplease",:password_confirmation => "pleaseplease",:role_id=>role1.id,:first_name =>"Martin",:last_name =>"Flower",:company_id=>company.id)
user4 = User.create(:email => "user4@example.com",:password => "pleaseplease",:password_confirmation => "pleaseplease",:role_id=>role1.id,:first_name =>"Catava ",:last_name =>"Enki",:company_id=>company.id)

puts "##### Creating Demo Profiles #####"

Profile.create!(:alternate_email=>'admin@gmail.com',:phone=>'13688798864',:address=>'BeiJing',:user_id=>admin_user.id,:motto=>'Work hard and Quality life')
Profile.create!(:alternate_email=>'job_seeker@gmail.com',:phone=>'12344798864',:address=>'Madurai',:user_id=>job_seeker_user.id,:motto=>'Work hard & life will be easy')
Profile.create!(:alternate_email=>'employee@gmail.com',:phone=>'12344798864',:address=>'Trichy',:user_id=>employee_user.id,:motto=>'No pain, no Gain')
Profile.create!(:alternate_email=>'hr@gmail.com',:phone=>'12847798764',:address=>'Chennai',:user_id=>hr_user.id,:motto=>'Everything is possible')

Profile.create!(:alternate_email=>'user1@gmail.com',:phone=>'13688798864',:address=>'Huston',:user_id=>user1.id,:motto=>'Quality life')
Profile.create!(:alternate_email=>'user2@gmail.com',:phone=>'13600472356',:address=>'Huston',:user_id=>user2.id,:motto=>'Quality life')
Profile.create!(:alternate_email=>'user3@gmail.com',:phone=>'13688008864',:address=>'Gani',:user_id=>user3.id,:motto=>'Happy life')
Profile.create!(:alternate_email=>'user4@gmail.com',:phone=>'13681198864',:address=>'New York City',:user_id=>user4.id,:motto=>'Good luck every day')

puts "##### Creating Activity for Demo #####"

activity1=Activity.create!(:activity_type=>'document',:create_date=>'2013-05-09 10:35:42',:activity_by_id=>user1.id,:department_id=>department2.id)
activity2=Activity.create!(:activity_type=>'conversation',:create_date=>'2013-05-08  07:35:42',:activity_by_id=>user1.id,:activity_with_id=>user2.id,:department_id=>department2.id)
Activity.create!(:activity_type=>'task',:create_date=>'2013-05-09 14:35:42',:activity_by_id=>user1.id,:activity_with_id=>user2.id,:department_id=>department2.id)
Activity.create!(:activity_type=>'task',:create_date=>'2013-05-08 22:35:42',:activity_by_id=>user1.id,:activity_with_id=>user2.id,:department_id=>department2.id)

puts "### creating comments for demo#"

 
comment1=Comment.create!(:content=>'The requirment doc is not very clear',:create_at=>'2013-05-09 12:35:42',:activity_id=>activity1.id,:user_id=>user2.id)
Comment.create!(:content=>'Update the doc,please check it',:create_at=>'2013-05-09 22:35:42',:activity_id=>activity1.id,:user_id=>user1.id,:parent_id=>comment1.id)

comment2=Comment.create!(:content=>'Let us discuss the UI of department model.',:create_at=>'2013-05-09 12:35:42',:activity_id=>activity2.id,:user_id=>user2.id)
comment21=Comment.create!(:content=>'The css need more brightness.do you think so.',:create_at=>'2013-05-09 13:35:42',:activity_id=>activity2.id,:user_id=>user1.id,:parent_id=>comment2.id)
comment211=Comment.create!(:content=>'Maybe.oh,I will take a change and contrast with before.',:create_at=>'2013-05-09 13:50:42',:activity_id=>activity2.id,:user_id=>user2.id,:parent_id=>comment21.id)
Comment.create!(:content=>'oooh',:create_at=>'2013-05-09 13:35:42',:activity_id=>activity2.id,:user_id=>user2.id)


puts "##### Creating Demo Tasks #####"

task = admin_user.tasks.build(
  :title => "SeedTask", 
  :description=>"Task from Seed", 
  :priority=>"medium", 
  :document=> File.open("#{Rails.root}/test/fixtures/task_test.png"), 
  :due_date=>"1/ 05/2013 0:0:00",
  :department_id=>department2.id
)
task.save

[user1.id].each do |i|
  task.assignments.create(:assignee_id => i)
end

task = admin_user.tasks.build(
  :title => "SeedTask2", 
  :description=>"Task2 from Seed", 
  :priority=>"medium", 
  :document=> File.open("#{Rails.root}/test/fixtures/task_test.png"), 
  :due_date=>"1/ 05/2013 0:0:00",
  :department_id=>department2.id 
)
task.save

[user2.id].each do |i|
  task.assignments.create(:assignee_id => i)
end

task = admin_user.tasks.build(
  :title => "SeedTask3", 
  :description=>"Task3 from Seed", 
  :priority=>"medium", 
  :document=> File.open("#{Rails.root}/test/fixtures/task_test.png"), 
  :due_date=>"1/ 05/2013 0:0:00",
  :department_id=>department1.id
)
task.save
[user1.id,user2.id].each do |i|
  task.assignments.create(:assignee_id => i)
end

