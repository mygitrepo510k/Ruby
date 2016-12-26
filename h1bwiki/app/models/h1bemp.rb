class H1bemp < ActiveRecord::Base
	
  has_many :h1bemp_filling,   :dependent=>:destroy
  has_many :h1bemp_topjob,    :dependent=>:destroy
  has_many :reviews,          :dependent=>:destroy
  attr_accessible :workforcesize, :empaddress, :empcity, :empstate, :empzip, :employername, :everifiedflag, :gcarateflag, :gcapprovalrate, :gctotalapplied, :gctotaldenied, :h1btotalapplied, :h1totaldenied, :h1barateflag, :h1bapprovalrate, :prevgcflag, :prevgccount, :prevh1count, :prevh1flag

  ajaxful_rateable :stars => 5, :dimensions =>[:company], :allow_update=>true
  acts_as_commentable

  
  FILING_TYPE = ["H1B", "GC"]
  FILING_STATUS = ["CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN" ]
  TOP_JOB_TYPES = ["TopAvg", "TopHired"]
  def get_filing_data type, status
    type = type.upcase
    status = status.upcase
    if FILING_TYPE.include?(type) && FILING_STATUS.include?(status)
	    gc_c_data = []
	    (2010..2013).each do |y|
	      gcdata = self.h1bemp_filling.where(:filingtype=>type, :filingyear=>y.to_s, :filingstatus => status ).first
	      count = gcdata.present? ? gcdata.filingcount.to_i : 0
	      gc_c_data << count
	    end
    	return gc_c_data
    else
    	return
    end
  end

  def get_year(type)
    self.h1bemp_filling.select(:filingyear).where(:filingtype=>type).group(:filingyear).count.count
  end

  def get_data type
    type = type.upcase
    if FILING_TYPE.include?(type)
      gc_c_data = []
      gc_c_data << ["Year","CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN"]
      (2010..2013).each do |y|
        chart_data = []          
        chart_data << y.to_s
        FILING_STATUS.each do |st|          
          gcdata = self.h1bemp_filling.where(:filingtype=>type, :filingyear=>y.to_s, :filingstatus => st ).first
          count = gcdata.present? ? gcdata.filingcount.to_i : 0
          chart_data << count
        end
        gc_c_data << chart_data  
      end      
      return gc_c_data
    else
      return
    end
  end
  def get_top_job_data type
    return if !TOP_JOB_TYPES.include?(type)
    top_job_datas=[]
    top_job_datas << ["Title", "#{type=='TopHired' ? 'Total Hired' : 'Avg Salary' }"]
    self.h1bemp_topjob.where(:flag => type).each do |t_data|
      top_job_data = []
      top_job_data << t_data.employertitle.to_s
      if type == TOP_JOB_TYPES[1]
        top_job_data << t_data.totalcount.to_f
      else
        top_job_data << t_data.avgsalary.to_f
      end
      
      top_job_datas << top_job_data
    end
    return top_job_datas
  end
  def get_top_job_table_data type
    return if !TOP_JOB_TYPES.include?(type)
    top_job_datas=[]
    if type == TOP_JOB_TYPES[1]
      data = self.h1bemp_topjob.where(:flag => type)
    else
      data = self.h1bemp_topjob.where(:flag => type)
    end
    data.each_with_index do |t_data, index|
      top_job_data = []
      top_job_data << t_data.employertitle.to_s
      top_job_data << t_data.totalcount.to_f
      top_job_data << t_data.avgsalary.to_f
      top_job_data << index+1

      top_job_datas << top_job_data
    end
    return top_job_datas
  end
end
