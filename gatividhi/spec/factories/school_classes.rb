# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school_class do
    current_class false
    start_date "2013-06-25"
    end_date "2013-06-25"
    class_name "MyString"
    section "MyString"
    roll_number "MyString"
    class_teacher "MyString"
  end
end
