class ProfileController < ApplicationController
	before_filter :authenticate_user!

  def parent_profile
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'parent'
    redirect_to root_url  if session[:selected_parent_id].nil? and params[:id].nil?
    session[:selected_parent_id] = params[:id] if params[:id].present?
  	@profile = selected_parent.profile
    if @profile.blank?
      @profile = selected_parent.build_profile
      @profile.email = selected_parent.email
      @profile.first_name = selected_parent.first_name
      @profile.last_name = selected_parent.last_name
      @profile.save
    end    
  end

  def parent_occupational
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'parent'
    redirect_to root_url  if session[:selected_parent_id].nil?
    @occupation = selected_parent.occupation
    @occupation = selected_parent.build_occupation unless @occupation.present?
    @occupation.save
  end

  def parent_financial
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'parent'
    redirect_to root_url  if session[:selected_parent_id].nil?
    @finance = selected_parent.finance
    @finance = selected_parent.build_finance unless @finance.present?
    @finance.save
    @advances_paids = @finance.advances_paids
    @child_related_policies = @finance.child_related_policies
  end

  def parent_policies
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'parent'
    redirect_to root_url  if session[:selected_parent_id].nil?
    @policies = selected_parent.policies
    #@policies = selected_parent.policies.build unless @policies.present?
    #@policies.save
  end  

  def save_policy
    policy = selected_parent.policies.build
    policy.particular  = params[:val1]
    policy.date_paid   = params[:val2]
    policy.amount      = params[:val3]
    policy.description = params[:val4]
    policy.save
    @policies = selected_parent.policies

    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "policy_data")
        @return_content
      }
    end
    
  end
  def delete_policy
    policy = selected_parent.policies.where(:id=>params[:id]).first
    policy.destroy if policy
    @policies = selected_parent.policies
    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "policy_data")
        @return_content
      }
    end
  end
  def edit_policy
    policy = selected_parent.policies.where(:id=>params[:id]).first    
    policy.particular   = params[:val1]
    policy.date_paid    = params[:val2]
    policy.amount       = params[:val3]
    policy.description  = params[:val4]
    policy.save
    @policies = selected_parent.policies
    
    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "policy_data")
        @return_content
      }
    end
  end


  def child_profile
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @profile = selected_member.profile
    if @profile.blank?
      @profile = selected_member.build_profile
      @profile.email = selected_member.email
      @profile.first_name = selected_member.first_name
      @profile.last_name = selected_member.last_name
      @profile.save
    end    
  end

  def child_milestone
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil?
    @milestone = selected_member.milestone
    @milestone = selected_member.build_milestone unless @milestone.present?
    @milestone.save
  end

  def child_interest
    session[:show_variable_home] = 'Profile'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil?
    @interest = selected_member.interest
    @interest = selected_member.build_interest unless @interest.present?
    @interest.save
  end

  def parent_save_value
    state = false
    obj_name = params[:obj]
    field = params[:field]
    value = params[:value]
    case obj_name
    when 'profile'
      profile = selected_parent.profile
      profile.update_attribute(field, value)
      state = profile.save
    when 'occupation'
      occupation = selected_parent.occupation
      occupation.update_attribute(field, value)
      state = occupation.save
    when 'finance'
      finance = selected_parent.finance
      finance.update_attribute(field, value)
      state = finance.save
    when 'policy'
      policy = selected_parent.policy
      policy.update_attribute(field, value)
      state = policy.save
    end

    if state
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end
  
  def child_save_value
    state = false
    obj_name = params[:obj]
    field = params[:field]
    value = params[:value]    
    case obj_name
    when 'profile'
      profile = selected_member.profile
      profile.update_attribute(field, value)
      state = profile
    when 'milestone'
      milestone = selected_member.milestone
      milestone.update_attribute(field, value)
      state = milestone
    when 'interest'
      type = params[:type]
      interest = selected_member.interest
      if type=='new'
        interest = selected_member.build_interest
        interest.option_name = field
        interest.option_value = value
      elsif type='edit'
        interest=Interest.where(:id=>params[:id]).first
        interest.option_name = field
        interest.option_value = value
      end
      state = interest
    end
    if state.save
      if obj_name == "interest"
        @interest = selected_member.interest
        if field=="academic"
          render :layout => false,:partial => "interest_academic" and return        
        elsif field=="sport"
          render :layout => false,:partial => "interest_sports" and return
        elsif field=="visual_performing_art"
          render :layout => false,:partial => "interest_vp_a" and return
        elsif field=="public_speaking_intereaction"
          render :layout => false,:partial => "interest_ps" and return
        elsif field=="personal"
          render :layout => false,:partial => "interest_personal" and return
        elsif field=="volunary"
          render :layout => false,:partial => "interest_v_sc" and return
        end
      end
      render :text => state.id, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end
  def interest_save_value
    state = false
    obj_name = params[:obj]
    field = params[:field]
    value = params[:value]    
    case obj_name
    when 'interest'
      type = params[:type]
      interest = selected_member.interest
      if type=='new'
        interest = selected_member.build_interest
        interest.option_name = field
        interest.option_value = value
      elsif type='edit'
        interest=Interest.where(:id=>params[:id]).first
        interest.option_name = field
        interest.option_value = value
      end
      state = interest
    end
    if state.save
      render :text => state.id, :status=>200
    else
      render :nothing => true, :status=>409
    end
    return
  end
  def delete_child_interest
    interest=Interest.where(:id=>params[:id]).first    
    if interest.destroy
      render :nothing => true, :status=>200
    else
      render :nothing => true, :status=>409
    end
  end
  def upload
    if params[:type] == 'parent'
      profile = selected_parent.profile      
      profile.picture.destroy if profile.picture
      img = profile.build_picture(params[:profile])
      path = parent_profile_path
    elsif params[:type] == 'child'
      profile = selected_member.profile
      profile.picture.destroy if profile.picture
      img = profile.build_picture(params[:profile])
      path = child_profile_path
    elsif params[:type] == 'milestone'
      milestone = selected_member.milestone
      milestone.picture.destroy if milestone.picture
      img = milestone.build_picture(params[:profile])
      path = child_milestone_path
    end
    if img.save
      flash[:notice] = "Succcessfully uploaded"
    else
      flash[:notice] = "upload error"
    end
    redirect_to path
  end

  def save_advaces_paid
    finance = selected_parent.finance
    ad_paid = finance.advances_paids.build
    ad_paid.title = params[:val1]
    ad_paid.date = params[:val2]
    ad_paid.amount = params[:val3]
    ad_paid.description = params[:val4]
    ad_paid.save
    @advances_paids = finance.advances_paids

    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "advances_paid")
        @return_content
      }
    end
    
  end
  def delete_advaces_paid
    finance = selected_parent.finance
    p=finance.advances_paids.where(:id=>params[:id]).first
    p.destroy if p
    @advances_paids = finance.advances_paids
    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "advances_paid")
        @return_content
      }
    end
  end
  def edit_advances_paid
    finance = selected_parent.finance
    ad_paid=finance.advances_paids.where(:id=>params[:id]).first
    ad_paid.title = params[:val1]
    ad_paid.date = params[:val2]
    ad_paid.amount = params[:val3]
    ad_paid.description = params[:val4]
    ad_paid.save
    @advances_paids = finance.advances_paids
    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "advances_paid")
        @return_content
      }
    end
  end

  def save_child_related_policies
    finance = selected_parent.finance
    cr_policy = finance.child_related_policies.build
    cr_policy.name = params[:val1]
    cr_policy.type = params[:val2]
    cr_policy.amount = params[:val3]
    cr_policy.description = params[:val4]
    cr_policy.save
    @child_related_policies = finance.child_related_policies

    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "child_related_policies")
        @return_content
      }
    end
    
  end
  def delete_child_related_policies
    finance = selected_parent.finance
    cr_policy = finance.child_related_policies.where(:id=>params[:id]).first
    cr_policy.destroy if cr_policy
    @child_related_policies = finance.child_related_policies

    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "child_related_policies")
        @return_content
      }
    end
  end
  def edit_child_related_policies
    finance = selected_parent.finance
    cr_policy = finance.child_related_policies.where(:id=>params[:id]).first
    cr_policy.name = params[:val1]
    cr_policy.type = params[:val2]
    cr_policy.amount = params[:val3]
    cr_policy.description = params[:val4]
    cr_policy.save
    @child_related_policies = finance.child_related_policies

    respond_to do |format|
      format.js {    
        @return_content = render_to_string(:partial => "child_related_policies")
        @return_content
      }
    end
  end
end
