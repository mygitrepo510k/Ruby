# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :child_profile_exam_schedule do
    current_class "MyString"
    exam_title "MyString"
    subject "MyString"
    description "MyString"
    date "2013-06-28"
    start_time "2013-06-28 15:25:46"
    end_time "2013-06-28 15:25:46"
    team_exam false
    exam_type "MyString"
  end
end
