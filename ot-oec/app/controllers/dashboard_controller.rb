class DashboardController < ApplicationController
  before_filter :require_login

	def index
    @items = Feed.feed(current_user.current_program, params[:page])
    @pinned = Post.where(program: current_user.current_program).pinned.sort_by_created

		common_layout_support

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end


  def delete_course_content_group
    id = params[:id]
    ContentGroup.find(id).delete
    redirect_to course_content_path
  end

  def terms
  end

  def support
  end
end
