# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  code       :string(2)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Country < ActiveRecord::Base

  def states
    State.where(country_code: self.code)
  end

  def cities
    City.where(country_code: self.code)
  end
end
