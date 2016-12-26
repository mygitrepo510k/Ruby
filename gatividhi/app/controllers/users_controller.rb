class UsersController < ApplicationController
  before_filter :authenticate_user!
    
  def dashboard
    session[:show_variable_home] = 'Dashboard'
    session[:dashboard] = 'parent'
    @user_family_member = current_user.family_members(FamilyMember::STATUS[:accepted])
  end

  def add_new_family
    if request.post? || request.put?      
      @family = current_user.families.build(params[:family])      
      @family_last = Family.last.blank? ? '1000000000' : Family.all.last.family_id
      @family.family_id = @family_last.to_i + 1
      @family.save
      FamilyMember.create(:first_name => current_user.first_name,
                       :last_name => current_user.last_name,
                       :email => current_user.email,
                       :confirm_email => current_user.email,
                       :role_name => @family.role_name,
                       :family_id =>  @family.id,
                       :user_id => current_user.id,
                       :status => FamilyMember::STATUS[:accepted],
                       :email_verification_hash=> SecureRandom.hex + Time.now.to_i.to_s)
      redirect_to :action => :dashboard and return
    else
      render :layout => false and return
    end
  end
  
  def associate_to_family
    @family = Family.find_by_family_id(params[:family_id].to_i)
    if FamilyMember.find_by_email_and_family_id(current_user.email,params[:family_id])
      flash[:notice] = "This email is already assosiated to this family. "
    else
      if !@family.blank?
        @family_member = FamilyMember.create(:first_name => current_user.first_name,
                       :last_name => current_user.last_name,
                       :email => current_user.email,
                       :confirm_email => current_user.email,
                       :role_name => params[:role_name],
                       :family_id =>  @family.id,
                       :user_id => current_user.id,
                       :status => "waiting",
                       :email_verification_hash=> SecureRandom.hex + Time.now.to_i.to_s)
        UserMailer.family_assosiate_request_email(@family_member).deliver
        flash[:notice] = "An email has been sent to the primary owner of the family ID. You will become member of the family, onece your request is approved."
      else
        flash[:notice] = "Family ID not found." 
      end
    end
    redirect_to :action => :dashboard and return
  end

  def add_new_family_member
    if request.post? || request.put?
      @family_member = FamilyMember.new(params[:family_member])
      @family_member.family_id = params[:id]
      @family_member.email_verification_hash = SecureRandom.hex + Time.now.to_i.to_s
      if FamilyMember.find_by_email_and_family_id_and_status(@family_member.email,@family_member.family_id,FamilyMember::STATUS[:accepted])
        flash[:notice] = "This email is already assosiated to this family. "
      elsif FamilyMember.find_by_email_and_family_id_and_status(@family_member.email,@family_member.family_id,FamilyMember::STATUS[:sent])
        flash[:notice] = "Please wait this email is already in proccessed for this family. "
      else
        flash[:notice] = "New family member is added."
        @family_member.status = FamilyMember::STATUS[:accepted] if @family_member.role_name == FamilyMember::ROLES[:son] || @family_member.role_name == FamilyMember::ROLES[:daughter]
        @family_member.save
        UserMailer.family_member_welcome_email(@family_member).deliver if !(@family_member.role_name == FamilyMember::ROLES[:son] || @family_member.role_name == FamilyMember::ROLES[:daughter])
      end
      redirect_to :action => :dashboard and return
    else
      @family = Family.find(params[:id])
      render :layout => false and return
    end
  end

  def verify_family_member
    session[:ses_user_id]= ""
    @family_member = FamilyMember.find_by_email_verification_hash(params[:id])
    if @family_member.status == FamilyMember::STATUS[:accepted] || @family_member.status == FamilyMember::STATUS[:reject]
      flash[:notice] = "You already #{@family_member.status}ed this family." 
    else
      @user = User.find_by_email(@family_member.email) if !@family_member.blank? 
      if !@user.blank? 
        if params[:verify_request] == 'true'
          session[:ses_user_id]=  @family_member.family.user.id
        else
          session[:ses_user_id]= @user.id
        end
        if !@family_member.blank?
          @family_member.status = params[:status]
          @family_member.user_id = @user.id
          @family_member.save
          if params[:verify_request] == 'true'
            UserMailer.family_assosiate_request_status_email(@family_member).deliver 
          else
            UserMailer.family_assosiate_request_status_email_by_user(@family_member).deliver 
          end
          flash[:notice] = params[:verify_request] == 'true' ? "Member of this family" : "Your are now member of this family"
        else
          flash[:notice] = "Your account is not exist."
        end
        render :action => :verify_account
      else
        @user = User.new(:first_name => @family_member.first_name,:last_name=>@family_member.last_name,:email=>@family_member.email,:confirm_email=>@family_member.confirm_email)
        session[:verify_email_register] = @family_member.email
        session[:verify_family_member_id] = @family_member.id
        session[:verify_family_member_status] = params[:status]
        if params[:status] == FamilyMember::STATUS[:reject]
           @family_member.status = params[:status]
           @family_member.save
           UserMailer.family_assosiate_request_status_email_by_user(@family_member).deliver 
           flash[:notice] = "You reject this family request."
        else
          flash[:notice] = "Please register first then try again."
        end
        session[:ses_user_id]= ""
        render :action => :new
      end
    end
  end  
  
  def child_profile_health
    session[:show_variable_home] = 'Health'
    session[:dashboard] = 'child'    
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = FamilyMember.find(params[:id])
    if @family_member.child_profile_healths.blank?
     @family_member.child_profile_healths.create(:name=>"Height (cm)",:value=>0)
     @family_member.child_profile_healths.create(:name=>"Weight (Kg)",:value=>0)
     @family_member.child_profile_healths.create(:name=>"BMI",:value=>0)
     @family_member.child_profile_healths.create(:name=>"Body Fat (%)",:value=>0)
     @family_member.child_profile_healths.create(:name=>"Waist (cm)",:value=>0)
     @family_member.child_profile_healths.create(:name=>"Head Circumference (in cm)",:value=>0)
     @family_member.child_profile_healths.create(:name=>"Blood Group",:value=>'B')
     @family_member.child_profile_healths.create(:name=>"Left Eye Vision",:value=>'+0.00')
     @family_member.child_profile_healths.create(:name=>"Right Eye Vision",:value=>'+0.00')
    end
    @family_member_health = @family_member.child_profile_healths.order_by(" created_at Asc  ")
  end

  def child_profile_health_value_update
    @child_profile_health = ChildProfileHealth.find(params[:id])
    @child_profile_health.value = params[:value]
    @child_profile_health.save
    @family_member = @child_profile_health.family_member
    @family_member_health = @family_member.child_profile_healths.order_by(" created_at Asc  ")
    render :action  => :child_profile_health,:layout=>false
  end
  
  def child_profile_health_record
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = FamilyMember.find(params[:id])
    @general_health_issues = @family_member.general_health_issues
    @injuries = @family_member.injuries
    @major_illnesses = @family_member.major_illnesses
  end

  def child_genral_health_data
    #render :text=> params[:general_health] and return
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = FamilyMember.find(params[:id])
    @family_member.general_health_issues.create(params[:general_health])
    @general_health_issues = @family_member.general_health_issues
    redirect_to :action => :child_profile_health_record ,:id => @family_member.id
    # respond_to do |format|
    #  format.js {render :content_type => 'text/javascript', :locals => { :profiles => @profiles}}
    # end
  end

  def genral_data_save 
    session[:dashboard] = 'child'
    @family_member = selected_member
    @family_member.general_health_issues.create(params)
    @general_health_issues = @family_member.general_health_issues

    render :layout => false, :partial=> "general_health"
    #redirect_to :action => :child_profile_health_record ,:id => @family_member.id
  end
  
  def child_genral_health_data_update
    @general_health_issue =  GeneralHealthIssue.find(params[:id])#create(params[:general_health])
    @general_health_issue.details = params[:details]
    @general_health_issue.end_date = params[:end_date]
    @general_health_issue.start_date = params[:start_date]
    @general_health_issue.health_issue = params[:health_issue]
    @general_health_issue.save
    @family_member = @general_health_issue.family_member
    @general_health_issues = @family_member.general_health_issues
    render :partial => "general_health"
  end

  def child_injuries    
    @family_member = FamilyMember.find(params[:id])
    @family_member.injuries.create(params[:general_health])
    @injuries = @family_member.injuries
    redirect_to :action => :child_profile_health_record ,:id => @family_member.id
    # respond_to do |format|
    #  format.js {render :content_type => 'text/javascript', :locals => { :profiles => @profiles}}
    # end
  end
  
  def child_injuries_update
    @injuries =  Injury.find(params[:id])#create(params[:general_health])
    @injuries.details = params[:details]
    @injuries.end_date = params[:end_date]
    @injuries.start_date = params[:start_date]
    @injuries.health_issue = params[:health_issue]
    @injuries.save
    @family_member = @injuries.family_member
    @injuries = @family_member.injuries
    render :partial => "injuries"
  end
  
  def genral_injuries_data_save 
    session[:dashboard] = 'child'
    @family_member = selected_member
    @family_member.injuries.create(params)
    @injuries = @family_member.injuries
    render :layout => false, :partial=> "injuries"
    #redirect_to :action => :child_profile_health_record ,:id => @family_member.id
  end
  def child_major_illnesses
    session[:dashboard] = 'parent'
    @family_member = FamilyMember.find(params[:id])
    @family_member.major_illnesses.create(params[:general_health])
    @major_illnesses = @family_member.major_illnesses
    redirect_to :action => :child_profile_health_record ,:id => @family_member.id
    # respond_to do |format|
    #  format.js {render :content_type => 'text/javascript', :locals => { :profiles => @profiles}}
    # end
  end
  
  def genral_major_illnesses_save
    @family_member = selected_member
    @family_member.major_illnesses.create(params)
    @major_illnesses = @family_member.major_illnesses
    render :layout => false, :partial=> "major_illnesses"
  end

  def child_major_illnesses_update
    @major_illnesses =  MajorIllness.find(params[:id])#create(params[:general_health])
    @major_illnesses.details = params[:details]
    @major_illnesses.end_date = params[:end_date]
    @major_illnesses.start_date = params[:start_date]
    @major_illnesses.health_issue = params[:health_issue]
    @major_illnesses.save
    @family_member = @major_illnesses.family_member
    @major_illnesses = @family_member.major_illnesses
    render :partial => "major_illnesses"
  end
  
  def child_profile_health_test_reports
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = selected_member
    #@child_profile_health_test_reports = @family_member.child_profile_health_test_reports.order_by(" test_date Desc ")
    @child_profile_health_test_reports = @family_member.cphtr_upcomming_lists
  end
  
  def add_child_profile_health_test_reports
    @family_member = selected_member
    @parent_list = @family_member.parent_list     
    @child_profile_health_test_report = ChildProfileHealthTestReport.find(params[:test_report_id]) if !params[:test_report_id].blank?
    if request.post? || request.put?
      if @child_profile_health_test_report.blank?
        @family_member.child_profile_health_test_reports.create(params[:test_reports])  
      else
        @child_profile_health_test_report.update_attributes(params[:test_reports])
      end
      #@child_profile_health_test_reports = @family_member.child_profile_health_test_reports.order_by(" test_date Desc ")
      @child_profile_health_test_reports = @family_member.cphtr_upcomming_lists
      render :action => :child_profile_health_test_reports and return
    end
    render :layout => false and return
  end

  def delete_child_profile_health_test_reports
    @family_member = FamilyMember.find(params[:id])
    @child_profile_health_test_report = ChildProfileHealthTestReport.find(params[:test_report_id])
    @child_profile_health_test_report.destroy
    @child_profile_health_test_reports = @family_member.child_profile_health_test_reports.order_by(" test_date Desc ")
    render :action => :child_profile_health_test_reports and return
  end


  
  def child_profile_health_vaccination_medication
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = FamilyMember.find(params[:id])
    #@child_profile_health_vaccination_medications = @family_member.child_profile_health_vaccination_medications.order_by(" due_date Desc ")
    @child_profile_health_vaccination_medications = @family_member.cphvm_upcomming_lists
  end
  
  def add_child_profile_health_vaccination_medication
    @family_member = FamilyMember.find(params[:id])
    @parent_list = @family_member.parent_list 
    @medication = ChildProfileHealthVaccinationMedication.find(params[:test_report_id]) if !params[:test_report_id].blank?
    if request.post? || request.put?
      
      if @medication.blank?
        @family_member.child_profile_health_vaccination_medications.create(params[:test_reports])  
      else
        @medication.update_attributes(params[:test_reports])
      end
      #@child_profile_health_vaccination_medications = @family_member.child_profile_health_vaccination_medications.order_by(" due_date Desc ")
      @child_profile_health_vaccination_medications = @family_member.cphvm_upcomming_lists
      render :action => :child_profile_health_vaccination_medication and return
    end
    render :layout => false and return
  end

  def delete_child_profile_health_vaccination_medication
    @family_member = FamilyMember.find(params[:id])
    @medication = ChildProfileHealthVaccinationMedication.find(params[:test_report_id])
    @medication.destroy
    #@child_profile_health_vaccination_medications = @family_member.child_profile_health_vaccination_medications.order_by(" due_date Desc ")
    @child_profile_health_vaccination_medications = @family_member.cphvm_upcomming_lists
    render :action => :child_profile_health_vaccination_medication and return
  end
  
  def show_list
    @family_member = FamilyMember.find(params[:id])
    if params[:check_order] == "Upcoming"
      #check_order = "Desc"
      @child_profile_health_vaccination_medications = @family_member.cphvm_upcomming_lists
    elsif params[:check_order] == "Past"
      #check_order = "Asc"
      @child_profile_health_vaccination_medications = @family_member.cphvm_past_lists
    else
      @child_profile_health_vaccination_medications = @family_member.child_profile_health_vaccination_medications
    end
    #@child_profile_health_vaccination_medications = @family_member.child_profile_health_vaccination_medications.order_by(" due_date #{check_order} ")
    render :layout => false,:partial => "health_v_list" and return
  end
   
  def health_test_reports_list
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = FamilyMember.find(params[:id])
    if params[:check_order] == "Upcoming"
      #check_order = "Desc"
      @child_profile_health_test_reports = @family_member.cphtr_upcomming_lists
    elsif params[:check_order] == "Past"
      #check_order = "Asc"
      @child_profile_health_test_reports = @family_member.cphtr_past_lists
    else
      #check_order = "Desc"
      @child_profile_health_test_reports = @family_member.child_profile_health_test_reports
    end
    #@child_profile_health_test_reports = @family_member.child_profile_health_test_reports.order_by(" test_date #{check_order} ")
    render :layout => false,:partial => "health_test_reports_list" and return
  end


  def delete_single_health_issue
    @family_member = selected_member
    @general_health_issue =  GeneralHealthIssue.find(params[:health_issue_id])
    @general_health_issue.destroy
    @general_health_issues = @family_member.general_health_issues
    @injuries = @family_member.injuries
    @major_illnesses = @family_member.major_illnesses
    render :action  => :child_profile_health_record and return
  end

  def delete_single_injury
    @family_member = selected_member
    @injury =  Injury.find(params[:injury_id])
    @injury.destroy
    @general_health_issues = @family_member.general_health_issues
    @injuries = @family_member.injuries
    @major_illnesses = @family_member.major_illnesses
    render :action  => :child_profile_health_record and return
  end

  def delete_single_major_illness
    @family_member = FamilyMember.find(params[:id])
    @major_illness =  MajorIllness.find(params[:major_illness_id])
    @major_illness.destroy
    @general_health_issues = @family_member.general_health_issues
    @injuries = @family_member.injuries
    @major_illnesses = @family_member.major_illnesses
    render :action  => :child_profile_health_record and return
  end

  def index
    redirect_to root_url unless current_user.email=="gentle0219@gmail.com"
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to root_path, :notice => "User deleted."
    else
      redirect_to root_path, :notice => "Can't delete yourself."
    end
  end
  
  private
    def verify_family_id(rnd_id)      
      rand_id = rnd_id
      if !Family.where(:family_id =>rand_id).first
        return rand_id
      else
        rand_id = rand(10**10)
        verify_family_id(rand_id)
      end
    end

end
