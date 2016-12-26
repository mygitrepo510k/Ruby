class HomeController < ApplicationController
	#before_filter :authenticate_user!, :except=>[:index, :blog, :contact_us, :couchcounselor_signup, :signup]
	def index
	end
	def signup		
	end

	def couchcounselor_signup
	end

	def find_motivation_partner
		@parent_cat = []
		@sub_cat=[]
		temp = []
		Category.find(:all, :conditions=>{:parent_id=>nil, :kind=>0}, :order=>'id DESC').each_with_index do |ct, index|
			@parent_cat.push([ct.name,ct.id])
			ct.subcategories.each do |sub_cat|
				temp.push([sub_cat.id,sub_cat.name])
			end
			@sub_cat.push([ct.id, temp])
			temp=[]
		end
		
		if params[:parent_category_id].blank?
			
			#if current_user.present?
			#	users = User.members.where("email != ?", current_user.email) 
			#	users.each do |user| 
		  #   Friend.make_friend(current_user, user)
		  #  end
		  #  @partners=current_user.friends.paginate(:page => params[:partner_page], :per_page => 20)
			#else			
			#	@partners = User.members.paginate(:page => params[:partner_page], :per_page => 20)
			#end	    
			@partners = []
		else
			if params[:sub_category_id].nil?
				cat = Category.find(params[:parent_category_id].to_i)
			else
				cat = Category.find(params[:sub_category_id].to_i)
			end
			@partners = cat.users.members.joins(:user_info).where("user_infos.country=? and user_infos.state=? and user_infos.city=? and user_infos.age=?", params[:country], params[:state], params[:city], params[:age]).paginate(:page => params[:partner_page], :per_page => 20)
		end
		

		#@partners=User.members.where("email != ?", current_user.email) 
		
	end
	
	def partner_profile				
		@partner = User.find(params[:id])

		@partner = current_user.friend(@partner) if current_user.present?
=begin		
		if current_user.is_friend(friend)
			@partner = current_user.friend(friend) 
		else
			@partner=Friend.make_friend(current_user, friend)
		end			
=end		
	end

	def motivation_partner_group
	end
	def find_coach				
    if current_user.present?
			users = User.cmembers.where("email != ?", current_user.email) 
			users.each do |user| 
	      Friend.make_friend(current_user, user)
	    end
	    @partners=current_user.friends
		else			
			@partners = User.cmembers
		end
	end

	def coach_counselor_profile
		@partner = User.find(params[:id])

		@partner = current_user.friend(@partner) if current_user.present?
	end

	def blog
	end
	def motivation_video
	end
	def motivation_forum
	end
	
	def stores
		@stores = Store.all
	end
	
	def store
		if params[:id].to_i == 0
			@stores=Store.where(:author=>params[:id])
		else
			cat = Category.find(params[:id].to_i)
			@stores = cat.stores	
		end
		render "stores"
	end

	def contact_us
	end
	
	def coach_counselor_pay
	end

	def welcome
		#UserMailer.signed_success('gentle0219@gmail.com', 'Signed Success', 'Thanks').deliver
    redirect_to new_user_session_path if !user_signed_in?    
	end

# check controllers
	def check_screen_name
    sc_name=params[:sc_name]
    if( User.find_by_name(sc_name).present? )
      render :nothing => true, :status=>409
    else
      render :nothing => true, :status=>200
    end
    return
  end
 	def check_email
    mail=params[:sc_name]
    if( User.find_by_email(mail).present?)
      render :nothing => true, :status=>409
    else
      render :nothing => true, :status=>200
    end
    return
  end

end
