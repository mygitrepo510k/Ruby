# == Schema Information
#
# Table name: cities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  latitude     :float
#  longitude    :float
#  country_code :string(255)
#  state_code   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class City < ActiveRecord::Base

  def state
    State.find_by_country_code_and_state_code(self.country_code, self.state_code)
  end

  def state_name
    self.state.name
  end

  def country
    Country.find_by_code(self.country_code)
  end
end
