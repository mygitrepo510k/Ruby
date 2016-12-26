require 'faker'
puts "Generating sample data....."
10.times do |t|
  User.create(:email => "user#{t+1}@hircle.com",
              :password => "pleaseplease",
              :password_confirmation => "pleaseplease",
              :first_name => Faker::Name.first_name,
              :last_name => Faker::Name.last_name)
end

puts "Finished to sample data"