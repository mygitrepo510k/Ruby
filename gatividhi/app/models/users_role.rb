class UsersRole
  include Mongoid::Document
  embedded_in :user
  embedded_in :role
end
