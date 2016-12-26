# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload do
    upload_file_name "MyString"
    upload_content_type "MyString"
    upload_file_size "MyString"
    first_name "MyString"
    last_name "MyString"
    category "MyString"
    gender "MyString"
  end
end
