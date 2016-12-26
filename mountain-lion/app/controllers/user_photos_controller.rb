class UserPhotosController < ApplicationController
  before_action :check_logged_user, :find_user
  before_action :check_current_user, except: [ :index, :show ]
  def index
    if @user == current_user
      @user_photos = @user.user_photos
    else
      @user_photos = @user.user_photos.approved
    end
    arr = []
    photos = @user_photos.to_a
    while photos.count > 0
      arr << photos.slice!(0..2)
    end
    @user_photos = arr
  end
  def new
    @user_photo = current_user.user_photos.build
  end
  def create
    @user_photo = current_user.user_photos.new(photo_params)
    if @user_photo.save
      @rating = RatingCalculator.new(current_user).recalculate_rating
      if current_user.user_photos.count == 1
        redirect_to edit_user_user_photo_path(current_user.username, @user_photo, rating: true)
      else
        redirect_to user_user_photos_path(current_user.username)
      end
    else
      render :new
    end
  end
  def edit
    @user_photo = current_user.user_photos.find(params[:id])
    @rating = params[:rating].present?
  end
  def update
    @user_photo = current_user.user_photos.find(params[:id])
    unless crop_params[:crop_w].to_i == 0 or crop_params[:crop_h].to_i == 0
      @user_photo.update_attributes(crop_params)
      @user_photo.reprocess_image
      current_user.profile_photo = @user_photo
      current_user.log_activity('profile_photo')
      redirect_to user_user_photos_url(current_user.username)
    else
      flash[:notice] = "The photo hasn't been cropped, please try again."
      render :edit
    end
  end

  def show
    begin
      @user_photo = @user.user_photos.approved.find(params[:id])
    rescue
      flash[:error] = I18n.t('controllers.user_photos.show.error')
      redirect_to user_user_photos_url(@user.username)
    end
  end
  def destroy
    begin
      photo = @user.user_photos.find(params[:id])
      if current_user == @user && photo.destroy
        flash[:success] = I18n.t('controllers.user_photos.destroy.success')
      else
        flash[:error] = I18n.t('controllers.user_photos.destroy.error')
      end
    rescue
      flash[:error] = I18n.t('controllers.user_photos.destroy.error')
    end
    @rating = RatingCalculator.new(@user).recalculate_rating
    redirect_to user_user_photos_url(@user.username)
  end
  private
  def photo_params
    params.require(:user_photo).permit(:user_id, :description, :image)
  end
  def crop_params
    params.require(:user_photo).permit(:crop_x, :crop_y, :crop_w, :crop_h)
  end
  def find_user
    @user = User.where('lower(username) = ?', params[:user_id].downcase).first
    if @user.present? && @user.blocked
      return redirect_to(root_path, notice: "User has deactivated their profile")
    end
  end
  def check_current_user
    unless params[:user_id].downcase == current_user.username.downcase || params[:user_id] == current_user.id.to_s
      redirect_to root_url
    end
  end
end
