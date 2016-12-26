class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :selected_parent, :selected_member, :user_family_members, :parent_dashboard?

  def selected_parent
  	@selected_parent = User.where(:id=>session[:selected_parent_id]).first if session[:selected_parent_id]
  end

  def selected_member
    @selected_member = FamilyMember.where(:id=>session[:selected_member_id]).first if session[:selected_member_id]
  end

  def parent_dashboard?
    return true if session[:dashboard]=='parent'
  end

  def user_family_members
  	@user_family_members = current_user.family_members(FamilyMember::STATUS[:accepted]) if current_user
  end

  def after_sign_in_path_for(resource)
		if resource.families.present?
			session[:have_family] = true      
		else
    	session[:have_family] = false
    end
    if current_user.request_family_members.count > 0
      flash[:notice] = "An email has been sent to the primary owner of the family ID. You will become member of the family, once your request is approved." 
    end
    return  dashboard_path
  end
end
