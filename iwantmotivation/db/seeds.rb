# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'Add Admin'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
user.add_role :admin

puts ">>>>>>>>>>>>>>>>>INSERTING OPTIONS DEMO DATAS"
Option.find_or_create_by_option_name(:option_name=>"price_page_description", :option_value=>"For a limited time, the first 250 people to join this site as a full member will get their first 3 months for free. All we ask is that you test the site out and email us if you discover anything that is not working correctly. Enjoy the site and Get Motivated for Success! Enter the code : First 350 to received 3months free ")
Option.find_or_create_by_option_name(:option_name=>"free_signup_page_description", :option_value=>"The free signup allows you to search the site for people, groups and categories. If you wish to interact with other members, you will need to sign up as a full member or limited access member.")
Option.find_or_create_by_option_name(:option_name=>"limit_signup_page_description", :option_value=>"You are Just a Few Steps away you to join and talk in the limited access frum threads. If you wish to talk use instant chat one on one or in full member forums you will have to upgrade to a full")
Option.find_or_create_by_option_name(:option_name=>"full_signup_page_description", :option_value=>"You Are Just a Few Steps away from Positive Change Full Access Membership allows you to use everything on this site along with receiving motivational emails, webinars, and much more")
Option.find_or_create_by_option_name(:option_name=>"coach_signup_page_description", :option_value=>"You Are Just a Few Steps away from Helping People with Positive Change")
Option.find_or_create_by_option_name(:option_name=>"counselor_signup_page_description", :option_value=>"You Are Just a Few Steps away from Helping People with Positive Change")

Option.find_or_create_by_option_name(:option_name=>"signup_agreement", :option_value=>"Lawyer Jargon/User Agreement")
Option.find_or_create_by_option_name(:option_name=>"full_signup_agreement", :option_value=>"Lawyer Jargon/User Agreement")
Option.find_or_create_by_option_name(:option_name=>"limited_signup_agreement", :option_value=>"Lawyer Jargon/User Agreement")

Option.find_or_create_by_option_name(:option_name=>"coach_signup_agreement", :option_value=>"Lawyer Jargon/User Agreement")
Option.find_or_create_by_option_name(:option_name=>"counselor_signup_agreement", :option_value=>"Lawyer Jargon/User Agreement")

Option.find_or_create_by_option_name(:option_name=>"coachcounselor_page_description", :option_value=>"Advertising with IWantMotivation.com will expose your business to the WORLD! If you have the heart and passion to help people, here is your opportunity to do in a big way. For just $19.95 a month, you will be in front of thousands of people who need YOU!")
Option.find_or_create_by_option_name(:option_name=>"coach_signup_item_page_description", :option_value=>"Coach signup description")
Option.find_or_create_by_option_name(:option_name=>"counselor_signup_item_page_description", :option_value=>"Counselor signup description")
Option.find_or_create_by_option_name(:option_name=>"coachcounselor_signup_page_description", :option_value=>"You Are Just a Few away from Helping People with Positive Change")
Option.find_or_create_by_option_name(:option_name=>"find_motivational_partner_page_description", :option_value=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud execitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui offcia deserunt mollit anim id est laborum")

puts ">>>>>>>>>>>>>>>>>link urls"
Option.find_or_create_by_option_name(:option_name=>"facebook_link_url", :option_value=>"http://www.facebook.com/pages/Iwantmotivation/510644052288704?ref=hl")
Option.find_or_create_by_option_name(:option_name=>"linkedin_link_url", :option_value=>"http://www.linkedin.com/profile/view?id=101806760&trk=tab_pro")
Option.find_or_create_by_option_name(:option_name=>"twitter_link_url", :option_value=>"https://twitter.com/iwantmotivation")
Option.find_or_create_by_option_name(:option_name=>"youtube_link_url", :option_value=>"http://www.youtube.com/user/iwantmotivation")
Option.find_or_create_by_option_name(:option_name=>"tumblur_link_url", :option_value=>"http://www.tumblr.com/blog/iwantmotivation")
Option.find_or_create_by_option_name(:option_name=>"pinterest_link_url", :option_value=>"http://pinterest.com/iwantmotivation")
Option.find_or_create_by_option_name(:option_name=>"blogtalkradio_link_url", :option_value=>"http://my.blogtalkradio.com/iwantmotivation")
Option.find_or_create_by_option_name(:option_name=>"instagram_link_url", :option_value=>"http://instagram.com/iwantmotivation")

puts ">>>>>>>>>>>>>>>>>INSERTING FOUND_US DEMO DATAS"
Foundus.find_or_create_by_found_us_name(:found_us_name =>"Wendy Duncan")
Foundus.find_or_create_by_found_us_name(:found_us_name =>"Blog Talk Radio")
Foundus.find_or_create_by_found_us_name(:found_us_name =>"Ellen")
Foundus.find_or_create_by_found_us_name(:found_us_name =>"Internet search")
Foundus.find_or_create_by_found_us_name(:found_us_name =>"Other")

puts ">>>>>>>>>>>>>>>>>INSERTING CATEGORIES DEMO DATAS"
Category.find_or_create_by_name(:name=>"Start a Business", :title=>"Start a Business", :description=>"Start a Business", :sort_id=>0)
Category.find_or_create_by_name(:name=>"Cancer", :title=>"Cancer", :description=>"Cancer", :sort_id=>1)
Category.find_or_create_by_name(:name=>"Stay Positive", :title=>"Stay Positive", :description=>"Stay Positive", :sort_id=>2)
Category.find_or_create_by_name(:name=>"Run a Marathon", :title=>"Run a Marathon", :description=>"Run a Marathon", :sort_id=>3)
puts ">>>>>>>>>>>>>>>>>INSERTING SUB CATEGORIES DEMO DATAS"
Category.find_or_create_by_name(:name=>"Beat Cancer", :title=>"Beat Cancer ", :description=>"Beat Cancer", :parent_id=>"2", :sort_id=>0)
Category.find_or_create_by_name(:name=>"Cancer Support", :title=>"Cancer Support ", :description=>"Cancer Support", :parent_id=>"2", :sort_id=>1)
Category.find_or_create_by_name(:name=>"Parent has cancer", :title=>"Parent has cancer ", :description=>"Parent has cancer", :parent_id=>"2", :sort_id=>2)

puts ">>>>>>>>>>>>>>>>> Create Coach Counselor categories <<<<<<<<<<<<<<<<<<<<<<<<<<"
Category.find_or_create_by_name(:name=>"Coach", :title=>"Coach", :description=>"Test Coach Category", :kind=>1, :sort_id=>0)
Category.find_or_create_by_name(:name=>"Counselor", :title=>"Counselor", :description=>"Test Counselor Category", :kind=>1, :sort_id=>1)

ch_id = Category.find_by_name("Coach").id
cn_id = Category.find_by_name("Counselor").id
Category.find_or_create_by_name(:name=>"CoachSubCat1", :title=>"CoachSubCat1", :description=>"CoachSubCat1", :parent_id=>ch_id, :kind=>false, :sort_id=>0)
Category.find_or_create_by_name(:name=>"CoachSubCat2", :title=>"CoachSubCat2", :description=>"CoachSubCat2", :parent_id=>ch_id, :kind=>1, :sort_id=>1)

Category.find_or_create_by_name(:name=>"CounselorSubCat1", :title=>"CounselorSubCat1", :description=>"CounselorSubCat1", :parent_id=>cn_id, :kind=>1, :sort_id=>2)
Category.find_or_create_by_name(:name=>"CounselorSubCat2", :title=>"CounselorSubCat2", :description=>"CounselorSubCat2", :parent_id=>cn_id, :kind=>1, :sort_id=>3)

puts ">>>>>>>>>>>>>>>>> Create Pragrams categories <<<<<<<<<<<<<<<<<<<<<<<<<<"

Category.find_or_create_by_name(:name=>"Ruby on Rails", :title=>"Coach", :description=>"Ruby on Rails", :kind=>2, :sort_id=>0)
Category.find_or_create_by_name(:name=>"jQuery", :title=>"Coach", :description=>"Test Coach Category", :kind=>2, :sort_id=>1)
Category.find_or_create_by_name(:name=>"Backbone and Rails", :title=>"Backbone and Rails", :description=>"Backbone and Rails", :kind=>2, :sort_id=>2)
Category.find_or_create_by_name(:name=>"Objective C", :title=>"Objective C", :description=>"Objective C", :kind=>2, :sort_id=>3)
