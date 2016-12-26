# Represents a Knowledge Center Page
class KcPage < ActiveRecord::Base
  attr_accessible :html, :published, :sort_order, :title, :url, :visible_to_doctors, :visible_to_patients

  validates_presence_of :url, :title, :sort_order, :html

  after_initialize :default_values

  
  private
  def default_values
    self.published = false if self.published.nil?
    self.visible_to_doctors = false if self.visible_to_doctors.nil?
    self.visible_to_patients = false if self.visible_to_patients.nil?
  end
end
