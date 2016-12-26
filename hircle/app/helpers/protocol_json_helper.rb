module ProtocolJsonHelper
  
  #definition view of employee 
  #used in two: load employees of company,load employees of department
  class Employee   
    attr_accessor :id,:email,:thumbnail,:status,:name,:tasks,:documents,:profile
  end 
  #statistical data of company
  class Statistical
    attr_accessor :id,:name,:manager,:employees,:tasks,:documents
  end
  #
  #
  #
  #Json data structure
  #It is useful to understand. 
  #one ActivityScreen has many ActivityViews
  #One ActivityView has many CommentView
  #One CommentView could has many CommentViews(replys)
  class ActivityScreen
    #time line and activities
    attr_accessor :timeline,:activities
  end
  class ActivityView
    attr_accessor :activity_id,:timeline,:time_short,:type,:from,:to,:activity_by_id,:comments
  end 
  class CommentView
    #name:user's full name
    attr_accessor :comment_id,:activity_id,:name,:thumbnail,:time_short,:content,:user_id,:replys
  end
end
