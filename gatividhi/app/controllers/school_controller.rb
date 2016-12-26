class SchoolController < ApplicationController
  def general
    session[:show_variable_home] = 'School'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    
    @school_names = selected_member.school_name_list
    @class_names = selected_member.class_name_list
    @schools = selected_member.schools
    if @schools.blank?
      @school = selected_member.schools.build
      @school.name = 'New School'
      @school.save
      @class= @school.school_cls.build
      @class.name = 'New Class'
      @class.save
    else
      @school = @schools.last
      @class=@school.school_cls.last
    end    
  end

  def save_school
    state = false
    obj_name = params[:obj]
    field = params[:field]
    value = params[:value]
    case obj_name
    when 'general'
      if params[:id].blank?
        school = selected_member.schools.build
      else
        school = selected_member.schools.where(:id=>params[:id]).first
      end
      school.update_attribute(field, value)
      state = school.save
    end

    if state
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end

  def delete_school    
    school = School.where(:id=>params[:id]).first
    if school.destroy
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end


  def timetable
  end
  
  def assignments
    session[:show_variable_home] = 'School'
    session[:dashboard] = 'child'
    @class_names = selected_member.class_name_list
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?    
    #@assignments = selected_member.assignments
    @assignments = selected_member.assign_upcomming_lists
  end
  
  def add_new_assignment
    @class_names = selected_member.class_name_list
    @assign = selected_member.assignments.build params[:assignment]    
    if request.post? || request.put?
      @assign.save
      redirect_to school_assignments_path and return
    else
      render :layout => false and return
    end
  end

  def edit_assignment
    @class_names = selected_member.class_name_list    
    @assign = selected_member.assignments.where(:id=>params[:id]).first

    if request.post? || request.put?
      @assign.update_attributes(params[:assignment])
      @assign.save
      redirect_to school_assignments_path and return
    else
      render :layout => false and return
    end
  end

  def delete_assignment
    assign = selected_member.assignments.where(:id=>params[:id]).first
    if assign.destroy
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
  end

  def show_list
    option = params[:opt]
    if option == "Upcoming"
      @assignments = selected_member.assign_upcomming_lists
    elsif option == "Past"
      @assignments = selected_member.assign_past_lists
    else
      @assignments = selected_member.assignments.where(:class_name=>params[:opt])
    end
    render :layout => false,:partial => "assignments_list" and return
  end
  def add_assignments_outcome
    @family_member = selected_member
    @assignment = @family_member.assignments.find(params[:assignment_id]) unless params[:assignment_id].blank?
    @activity_outcome = ChildActivityOutcome.find_by_assignment_id(params[:assignment_id]) unless params[:assignment_id].blank?
    @class_names = selected_member.class_name_list
    @assignments = selected_member.assign_upcomming_lists
    if request.post? || request.put?
      if @assignment.child_activity_outcomes.blank?
        @new_outcome = @assignment.child_activity_outcomes.create(params[:test_reports])
        @assignment.update_attribute('outcome',@new_outcome.status)
        flash[:notice] = "Child Assignment Outcome added successfully"
        render :action => :assignments and return
      else
        @activity_outcome = ChildActivityOutcome.find_by_assignment_id(params[:assignment_id])
        @activity_outcome.update_attributes(params[:test_reports])
        flash[:notice] = "Child Assignment Outcome Updated successfully"
        render :action => :assignments and return
      end
    end
    render :layout => false and return 
  end


  def feedback
    session[:show_variable_home] = 'School'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @class_names = selected_member.class_name_list
    @feedbacks = selected_member.feedbacks
  end

  def add_new_feedback
    @class_names = selected_member.class_name_list
    @feedback = selected_member.feedbacks.build params[:feedback]
    if request.post? || request.put?
      @feedback.save
      redirect_to school_feedback_path and return
    else
      render :layout => false and return
    end
  end

  def edit_feedback
    @class_names = selected_member.class_name_list    
    @feedback = selected_member.feedbacks.where(:id=>params[:id]).first

    if request.post? || request.put?
      @feedback.update_attributes(params[:feedback])
      @feedback.save
      redirect_to school_feedback_path and return
    else
      render :layout => false and return
    end
  end
  def delete_feedback
    feedback = selected_member.feedbacks.where(:id=>params[:id]).first
    if feedback.destroy
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
  end
  def show_feedback
    cls_name = params[:cls_name]
    @feedbacks = selected_member.feedbacks_of_class(cls_name)
    render :layout => false, :partial => "feedback_list" and return
  end


  def holidays
    session[:show_variable_home] = 'School'
    session[:dashboard] = 'child'
    @class_names = selected_member.class_name_list
    @holidays = selected_member.holidays
  end
  def add_new_holiday
    @class_names = selected_member.class_name_list
    @holiday = selected_member.holidays.build params[:holiday]
    if request.post? || request.put?
      @holiday.save
      redirect_to school_holidays_path and return
    else
      render :layout => false and return
    end
  end

  def edit_holiday
    @class_names = selected_member.class_name_list    
    @holiday = selected_member.holidays.where(:id=>params[:id]).first

    if request.post? || request.put?
      @holiday.update_attributes(params[:holiday])
      @holiday.save
      redirect_to school_holidays_path and return
    else
      render :layout => false and return
    end
  end
  def delete_holiday
    holiday = selected_member.holidays.where(:id=>params[:id]).first
    if holiday.destroy
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
  end
  def show_holidays
    cls_name = params[:cls_name]
    @holidays = selected_member.holidays_of_class(cls_name)
    render :layout => false, :partial => "holidays_list" and return
  end


  def teachers
    session[:show_variable_home] = 'School'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @teachers = selected_member.teachers
  end
  def add_new_teacher
    @teacher = selected_member.teachers.build params[:teacher]
    if request.post? || request.put?
      @teacher.save
      @teachers = selected_member.teachers 
      render :layout => false,:partial => "teacher_list" and return
    else
      render :nothing => true, :status=>409
    end
  end

  def edit_teacher
    render :layout => false and return unless params[:id]
    @teacher = selected_member.teachers.where(:id=>params[:id]).first
    @teacher.update_attribute('name', params[:val1])
    @teacher.update_attribute('position', params[:val2])
    @teacher.update_attribute('email', params[:val3])
    @teacher.update_attribute('phone_number', params[:val4])
    @teacher.update_attribute('other_details', params[:val5])
    @teacher.save
    @teachers = selected_member.teachers 
    render :layout => false,:partial => "teacher_list" and return
  end
  def delete_teacher
    teacher = selected_member.teachers.where(:id=>params[:id]).first
    if teacher.destroy
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
  end

end
