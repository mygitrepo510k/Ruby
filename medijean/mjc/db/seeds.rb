# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Loading seed data"

require './db/seeds/doctors.rb'

Dir[Rails.root.join("db/seeds/essentials/*.rb")].each {|f| require f}

if User.find_by_email("test.user@example.com").nil?
  test_user = User.create!(:email => "test.user@example.com", :password => "password", :password_confirmation => "password", profile_updated: 'true')
  test_user.roles << Role.find_or_create_by_name("patient")
  test_user.skip_confirmation!
  test_user.save
  Profile.create(health_card_number: '123-1233-12-321', first_name: 'User', last_name: 'Test', gender: 'male', phone: '123-123-321', user_id: test_user.id)
end

if User.find_by_email("test.doctor@example.com").nil?
  test_doctor = User.create!(:email => "test.doctor@example.com", :password => "password", :password_confirmation => "password", profile_updated: 'true')
  test_doctor.roles << Role.find_or_create_by_name("doctor")
  test_doctor.skip_confirmation!
  test_doctor.save
  clinic = Clinic.create!({"name"=>"", "website"=>"", "address_attributes"=> {"street"=>"test123", "city"=>"test", "province"=>"testt"}, "phone"=>"--"})
  Doctor.create({"physician_id"=>"1", "first_name"=>"Doctor", "last_name"=>"Test", "gender"=>"male", "clinic_id"=>clinic.id, "phone"=>"123-321-1233", "user_id"=>test_doctor.id})
end

if AdminUser.find_by_email("admin@example.com").nil?
  admin = AdminUser.create!(:email => "admin@example.com", :password => "password", :password_confirmation => "password")
  admin.roles << Role.find_or_create_by_name("sysadmin")
  admin.save
end
