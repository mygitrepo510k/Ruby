# == Schema Information
#
# Table name: notification_settings
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  receive_message        :boolean           description: I recieve a message from a doctor on Medijean
#  has_news               :boolean          description: MediJean has news about Medican Marijuana
#  has_tagged_me          :boolean          description: A doctor on MediJean has tagged me
#  receive_prescription   :boolean          description: I receive a prescription
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe NotificationSettings do

  it { should belong_to(:user) }
  
  it { should validate_presence_of :user }

end
