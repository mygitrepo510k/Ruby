class AdminController < ApplicationController
	before_filter :authenticate_user!
  def home
  	
  	redirect_to root_path if !current_user.has_role :admin
  	@category_last_id = Category.last.id+1
  	@parent_cat = []
		@all_cat=[]
		temp = []
		Category.find(:all, :conditions=>{:parent_id=>nil, :kind=>0}, :order=>'id DESC').each_with_index do |ct, index|
			@parent_cat.push([ct.name,ct.id])
			ct.subcategories.each do |sub_cat|
				temp.push([sub_cat.id,sub_cat.name])
			end
			@all_cat.push([ct.id, temp])
			temp=[]
		end
  end

  def save_category  	
  	#render :text => params.inspect and return
  	return if params[:cats].blank?
  	if params[:type] == "parent"
  		last_sort_id = Category.m_parent_categories.last.sort_id
	  	params[:cats].each do |cat|
	  		last_sort_id=last_sort_id.to_i+1
	  		Category.find_or_create_by_name(:name=>cat, :title=>cat, :sort_id=>last_sort_id)
	  	end
	  	render :nothing => true, :status=>200
	  elsif params[:type] == "child"
	  	last_item = Category.find(params[:parent_id].to_i).subcategories.last
	  	last_sort_id = last_item.nil? ? 0 : last_item.sort_id
	  	parent_id = params[:parent_id]
	  	params[:cats].each do |cat|
	  		last_sort_id=last_sort_id.to_i+1
	  		Category.find_or_create_by_name(:name=>cat, :title=>cat, :parent_id=>parent_id, :sort_id=>last_sort_id)
	  	end
	  	render :nothing => true, :status=>200
	  end
	  return
  end
	
	def delete_category
		#render :text => params.inspect and return
		return if params[:cat_id].blank?
  	if params[:type] == "parent"
  		cat=Category.find(params[:cat_id].to_i);
	  	cat.destroy
	  	render :nothing => true, :status=>200
	  elsif params[:type] == "child"
	  	cat=Category.find(params[:cat_id].to_i);
	  	cat.destroy
	  	render :nothing => true, :status=>200
	  end
	  return
  end

  def save_foundus
		return if params[:items].blank?
		params[:items].each do |item|
			Foundus.find_or_create_by_found_us_name(:found_us_name=>item)
		end
		render :nothing => true, :status=>200
		return
  end

  def delete_foundus
		return if params[:item_id].blank?
		foundus=Foundus.find(params[:item_id].to_i)
		foundus.destroy unless foundus.nil?
		render :nothing => true, :status=>200
		return
  end

  def update_option
  	opt_name = params[:opt_name]
  	opt_value = params[:opt_value]
  	
  	opt = Option.find_by_option_name(opt_name)
  	if opt.present?
  		opt.option_value = opt_value;
  		opt.save
  		render :nothing => true, :status=>200
  	else
  		opt = Option.new(:option_name=>opt_name, :option_value=>opt_value)
  		opt.save
  		render :nothing => true, :status=>200
  	end
  	return
  end

  def upload_logo_image
  	
  end

  def public_group
  	redirect_to '/groups'
  end

  def stores
  	redirect_to '/stores'
  end

  def options
  	redirect_to '/options'
  end
end
