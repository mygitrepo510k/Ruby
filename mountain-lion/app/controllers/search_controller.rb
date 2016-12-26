class SearchController < ApplicationController
  before_action :check_logged_user

  def index
    redirect_to users_url unless @users
  end

  def advanced
    @profile_sections = ProfileSection.
      all(include: [:profile_questions]).
      select { |s| s.profile_questions.where("answer_type != 'string'").count > 0 }
  end

  def create
    @users = Search.new(current_user.gender, params[:search]).users.page(params[:page]).per(20)
    if @users
      render :index
    else
      flash[:error] = "No results match your search"
      redirect_to users_url
    end
  end

  def simple
    @users = Search.new(current_user.gender,
                        params[:search_distance],
                        latitude: current_user.latitude,
                        longitude: current_user.longitude).users.page(params[:page]).per(20)
    if @users
      render :index
    else
      flash[:error] = "No results match your search"
      redirect_to users_url
    end
  end
end
