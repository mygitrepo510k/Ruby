class Admin::UsersController < AdminController
  helper_method :sort_column, :sort_direction
  before_action :find_user, only: [:show, :edit, :destroy, :update, :login, :resend_activation, :block, :unblock]
  skip_filter :require_admin, only: :logout
  before_action :require_admin_for_logout, only: :logout

  def index
    @q = User.search(params[:q])
    @users = @q.result(:distinct => true).order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    changed_gender = @user.gender != params[:gender]
    @user.country = Country.find_by_code(params[:user][:country_code].upcase).name
    if @user.update_attributes(user_params)
      RatingCalculator.new(@user).recalculate_rating
      if changed_gender
        @user.user_activity.update_attribute(:gender, @user.gender)
      end
      flash[:notice] = 'User updated!'
      redirect_to admin_users_path
    else
      flash.now[:error] = 'There are some errors you need to look into'
    end
  end

  def show
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path
  end

  def destroy_photo
    @photo = UserPhoto.find(params[:id])
    user = @photo.user
    @photo.destroy
    RatingCalculator.new(user).recalculate_rating
  end

  def approve_photos
    photos = UserPhoto.unapproved.where(id: params[:user_photos])
    photos.each do |photo|
      photo.approve!
      photo.user.log_activity('photo_upload')
    end
    redirect_to admin_root_url, notice: "Photos approved"
  end

  def resend_activation
    UserMailer.activation_needed_email(@user).deliver
    redirect_to admin_users_path, notice: 'Activation mail resent succesfully'
  end

  def login
    session[:admin_id] = current_user.id
    auto_login(@user)
    redirect_to users_path, notice: "You are now logged in as #{@user.username}"
  end

  def logout
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    current_user = Admin.find(session[:user_id])
    redirect_to admin_users_path, notice: 'You are now an admin user once again'
  end

  def block
    @user.block!
    redirect_to admin_users_path, notice: 'User blocked'
  end

  def unblock
    @user.unblock!
    redirect_to admin_users_path, notice: 'User unblocked'
  end

  private
  def user_params
    params.
      require(:user).
      permit(:username,
             :premium,
             :email,
             :firstname,
             :lastname,
             :gender,
             :address,
             :zip_code,
             :city,
             :state,
             :country_code)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_admin_for_logout
    unless admin_user && admin_user.is_a?(Admin)
      redirect_to root_url, notice: "You are not authorized to access this page"
    end
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
