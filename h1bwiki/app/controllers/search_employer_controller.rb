class SearchEmployerController < ApplicationController
	autocomplete :h1bemp, :name, :full => true

	def h1bemployer		
		@h1b_chart_data = @gc_chart_data = @top_hired_data = @top_avg_data = 0
		search_name = params[:h1bemp_name]

		if search_name.present?

			@search_h1bemp = H1bemp.find_by_employername(search_name) if search_name.present?
			
			redirect_to search_employer_h1bemployer_path and return if @search_h1bemp.blank? 

			@h1b_chart_data = @search_h1bemp.get_data("H1B")
			@gc_chart_data = @search_h1bemp.get_data("GC")

			@top_hired_data = @search_h1bemp.get_top_job_data("TopHired")
			@top_hired_table_data = @search_h1bemp.get_top_job_table_data("TopHired")

			@top_avg_data = @search_h1bemp.get_top_job_data("TopAvg")
			@top_avg_table_data = @search_h1bemp.get_top_job_table_data("TopAvg")

			@reviews = @search_h1bemp.reviews
			@review = @search_h1bemp.reviews.where(:user_id=>current_user.id).first if user_signed_in?
			@comments = @search_h1bemp.root_comments
			@comment = @search_h1bemp.root_comments.where(:user_id=>current_user.id).first if user_signed_in?
		end
	end
	def rate
		@search_h1bemp = H1bemp.find(params[:id].presence || 0)
		@search_h1bemp.rate(params[:stars], current_user, params[:dimension])		
		width = @search_h1bemp.rate_by(current_user, "company").stars.to_i*20
		render :json => {:id => @search_h1bemp.wrapper_dom_id(params), :width => width}
		#render :update do |page|
		#	page.replace_html @search_h1bemp.wrapper_dom_id(params), ratings_for(@search_h1bemp, params.merge(:wrap => false))
		#	page.visual_effect :highlight, @search_h1bemp.wrapper_dom_id(params)
		#end
	end
	def add_comment
		search_h1bemp = H1bemp.find(params[:id])		
		comment = search_h1bemp.root_comments.where(:user_id=>current_user.id).first.presence || Comment.build_from( search_h1bemp, current_user.id, params[:content])
		comment.body = params[:content]
		comment.subject = "#{current_user.user_name} to #{search_h1bemp.employername}"
		comment.save
		review = search_h1bemp.reviews.where(:user_id=>current_user.id).first.presence || search_h1bemp.reviews.build
		review.user_id = current_user.id
		review.paidontime=params[:paid_time]
		review.placement=params[:placement]
		review.legal = params[:legal]
		review.save

		@reviews = search_h1bemp.reviews

		@comment = search_h1bemp.root_comments.where(:user_id=>current_user.id).first
		
		average = search_h1bemp.rate_average(true, "company")
		@width = (average/search_h1bemp.class.max_stars.to_f)*100
		@child_width = search_h1bemp.rate_by(current_user, "company").stars.to_i*20
		respond_to do |format|
      format.js {
        @return_content = render_to_string(:partial => "comments")
        @return_content
      }
    end
	end

	def h1bemp_name
		h1bemp = H1bemp.find(:all, :conditions =>['employername LIKE ?', "%#{params[:term].upcase}%"])
		#h1bemp = H1bemp.select('employername').where(['employername LIKE ? ' "%#{params[:term]}"])
		names = h1bemp.map{|e| e.employername}
		render :json=> names.to_json				
	end
end
