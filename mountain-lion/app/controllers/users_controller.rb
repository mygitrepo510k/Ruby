class UsersController < ApplicationController
  force_ssl if: :production?, only: [ :new, :signup_one, :signup_two, :create, :password_reset ]
  before_action :check_logged_user, except: [:new, :signup_one, :signup_two, :activate, :password_reset, :unsubscribe]
  before_action :check_logged_in
  before_action :redirect_incomplete_profile, except: [:new, :signup_one, :signup_two, :activate, :password_reset, :unsubscribe, :mandatory_edit_profile, :update, :destroy]
  layout "../users/mandatory_edit_profile", only: [ :mandatory_edit_profile ]

  def index
    @lounge_obj = Lounge.new(current_user.gender, current_user.id == -1).feed.includes([:user, user: [ :subscription ]])
    @lounge = @lounge_obj.page(params[:page]).per(12) 
    @internal_notification = InternalNotification.active.first
    @rating = params[:rating].present?
  end
  def new
    @user = RegistrationOne.new
    if params[:who].present?
      ref_user = User.active.find_by_username(params[:who])
      if ref_user
        @ref_user = ref_user.decorate
        @no_footer = true
      end
    end
    render layout: 'frontpage'
  end
  def signup_one
    @user = RegistrationOne.new(params[:registration_one])
    if @user.valid?
      @user = RegistrationTwo.new(params.require(:registration_one).permit(:gender, :email, :username, :date_of_birth))
      render :signup_two, layout: 'frontpage'
    end
  end
  def signup_two
    @user = RegistrationTwo.new(params[:registration_two].merge(ip_address: request.remote_ip))
    unless params[:no_validate].present?
      if @user.save
        flash.now[:notice] = I18n.t('controllers.users.create.success')
        render :confirmation
      else
        flash.now[:error] = I18n.t('controllers.users.create.failure')
        render :signup_two, layout: 'frontpage'
      end
    end
  end
  def show
    if params[:id].present?
      user = User.includes(:user_questions, :user_photos, :user_profile).find_by_username(params[:id])
      if user && current_user != user
        if user.active && !user.blocked
          current_user.visit_profile(user)
        else
          return redirect_to user_profile_path, notice: "We're sorry... #{user.username} has deactivated #{user.gender == 'M' ? 'his' : 'hers'} account"
        end
      else
        rating = params[:rating] if params[:rating].present?
        return redirect_to user_profile_path, notice: I18n.t('controllers.users.show.user_not_found')
      end
    end
    @user = (user || current_user).decorate
    @rating = RatingCalculator.new(user || current_user).recalculate_rating
  end
  def create
    @user = User.new(user_params.merge(date_of_birth: Date.strptime(params[:user][:date_of_birth],'%m/%d/%Y')))
    if @user.save
      redirect_to confirmation_url, notice: I18n.t('controllers.users.create.success')
    else
      flash.now[:error] = I18n.t('controllers.users.create.failure')
      render :new, layout: "frontpage"
    end
  end
  def activate
    user = User.load_from_activation_token(params[:activation_token])
    if user
      user.activate!
      auto_login(user)
      session[:logged_in] = true
      @rating = RatingCalculator.new(user).recalculate_rating
      redirect_to mandatory_edit_profile_user_path(user, rating: @rating), notice: I18n.t('controllers.users.activate.success')
    else
      redirect_to welcome_url, error: I18n.t('controllers.users.activate.failure')
    end
  end
  def password_reset
    @user = User.load_from_password_reset_token(params[:password_reset_token])
    if @user
      flash[:notice] = I18n.t('controllers.users.password_reset.success')
    else
      flash[:error] = I18n.t('controllers.users.password_reset.failure')
    end
    redirect_to root_path
  end
  def edit
    @user = User.includes(:user_questions).find(current_user.id)
    @profile_sections = ProfileSection.all.includes(:profile_questions)
    @rating = params[:rating] if params[:rating].present?
  end
  def mandatory_edit_profile
    @user = User.includes(:user_questions).find(current_user.id)
    @profile_sections = ProfileSection.all.includes(:profile_questions)
    @rating = params[:rating] if params[:rating].present?
  end
  def update
    @user = User.find(current_user.id)
    user_questions = params[:user_questions]
    if user_questions
      user_questions.each do |question_id, answer|
        unless answer.empty?
          question = @user.user_questions.includes(:profile_question).find_or_initialize_by(profile_question_id: question_id.to_i)
          question.answer = answer.is_a?(Array) ? answer.join(',') : answer
          question.save
        end
      end
    end
    @user.log_activity('profile_update')
    @user.update_attributes(user_profile_params)
    redirect_to user_profile_path, notice: I18n.t('controllers.users.update.success')
  end
  def likes
    @users = current_user.
      user_likes.
      order(created_at: :desc).
      includes(:visitor).
      joins(:visitor).
      where("users.blocked = false and users.active = true and users.activation_state = 'active'").
      page(params[:page])
    current_user.write_log('likes')
  end
  def liked
    @users = current_user.
      liked_users.
      order(created_at: :desc).
      includes(:user).
      joins(:user).
      where("users.blocked = false and users.active = true and users.activation_state = 'active'").
      page(params[:page])
  end
  def matches
    @users = Kaminari.paginate_array(UserMatch.new(current_user).matched).page(params[:page])
  end
  def views
    @users = current_user.
      profile_visits.
      order(created_at: :desc).
      includes(:visitor).
      joins(:visitor).
      where("users.blocked = false and users.active = true and users.activation_state = 'active'").
      page(params[:page])
    current_user.write_log('views')
  end
  def manage_likes
    @user = User.find(params[:user_id])
    current_user.manage_like(@user) if @user
  end
  def destroy
    current_user.update_attribute(:active, false)
    logout
    redirect_to '/', notice: 'You have deactivated your account'
  end

  def unsubscribe
    @user = User.find_by_unsubscribe_token(params[:id])
    if @user
      @user.unsubscribe_all
      render layout: false
    else
      flash[:error] = "The page you are looking for isn't there"
      redirect_to users_url
    end
  end

  private
  def user_params
    params.require(:registration_two).permit(:email, :gender, :date_of_birth, :password, :password_confirmation, :username, :firstname, :lastname, :country, :city, :zip_code)
  end
  def user_profile_params
    params.require(:user).permit(user_profile_attributes: [:title, :about_me, :looking_for, :id])
  end
  def check_logged_in
    if session[:logged_in]
      @no_photo = current_user.user_photos.size == 0
      session[:logged_in] = nil
    end
  end
end
