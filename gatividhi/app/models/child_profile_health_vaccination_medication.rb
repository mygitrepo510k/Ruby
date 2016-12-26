class ChildProfileHealthVaccinationMedication
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,           :type=> String
  field :title_text,      :type=> String
  field :due_date,        :type=> Date
  field :date_finalised,  :type=> Boolean
  field :from,            :type=> String
  field :reminder,        :type=> String
  field :job_number,      :type=> String
  field :parent_res,      :type=> String
  field :description,     :type=> String
  
  validate :title, :presence => true
  belongs_to :family_member

  def self.upcomming_lists
    #ChildProfileHealthVaccinationMedication.where('due_date >= "#{t}"').order_by('created_at desc')
    upcomming_lists=[]    
    current_date = DateTime.now
    ChildProfileHealthVaccinationMedication.all.each do |cp|
      if cp.due_date >= DateTime.now
        upcomming_lists << cp
      end
    end
    return upcomming_lists
  end
  def self.past_lists 
    pst_lists=[]    
    current_date = DateTime.now
    ChildProfileHealthVaccinationMedication.all.each do |cp|
      if cp.due_date < DateTime.now
        pst_lists << cp
      end
    end
    return pst_lists
  end

end
