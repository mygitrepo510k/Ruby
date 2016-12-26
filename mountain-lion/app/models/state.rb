# == Schema Information
#
# Table name: states
#
#  id           :integer          not null, primary key
#  country_code :string(255)
#  state_code   :string(255)
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class State < ActiveRecord::Base

  def cities
    City.where(country_code: self.country_code.upcase, state_code: self.state_code.upcase)
  end

  def country
    Country.find_by_code(country_code.upcase)
  end
end
