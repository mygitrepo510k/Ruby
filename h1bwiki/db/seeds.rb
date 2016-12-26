# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts ">>>>>>>>>>> Create SkillList"
SkillList.find_or_create_by_name(:name=>"Ruby")
SkillList.find_or_create_by_name(:name=>"jQuery")
SkillList.find_or_create_by_name(:name=>"Ruby on Rails")
SkillList.find_or_create_by_name(:name=>"Java")
SkillList.find_or_create_by_name(:name=>"Ajax")
SkillList.find_or_create_by_name(:name=>"Python")
SkillList.find_or_create_by_name(:name=>"Django")
SkillList.find_or_create_by_name(:name=>"PHP")
SkillList.find_or_create_by_name(:name=>"Wordpress")
SkillList.find_or_create_by_name(:name=>"C#")
SkillList.find_or_create_by_name(:name=>"JavaScript")


