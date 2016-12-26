# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    current_school false
    start_date "2013-06-25"
    end_date "2013-06-25"
    country "MyString"
    state "MyString"
    city "MyString"
    school_name "MyString"
    enrolment_number "MyString"
    board "MyString"
    house "MyString"
    medium "MyString"
    category "MyString"
    type ""
    school_principle "MyString"
    child_advisor "MyString"
  end
end
