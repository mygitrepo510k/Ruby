# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Seeding ..."
	User.find_or_create_by_email(email: "parknow@admin.com", password: "adminadmin", password_confirmation: "adminadmin", role: 'admin')
	
	un = User.find_or_create_by_email(email: "tester@email.com", password: "asdfasdf", password_confirmation: "asdfasdf")
	un.auth_tokens.find_or_create_by_device_id_and_app_type_and_device_type(device_id:'xxx-123456-xxx',app_type:'customer',device_type:'ios')
	customer = un.create_customer(name:'customer',balance:26,available_balance:17)
	vehicle = customer.vehicles.create(license_plate:'license_plate',make:'make',model:'model',color:'color')
puts "Complete!"