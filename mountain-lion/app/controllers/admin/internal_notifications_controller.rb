class Admin::InternalNotificationsController < AdminController
  before_action :find_notification, except: [ :index, :new, :create]
  def index
    @internal_notifications = InternalNotification.all.page(params[:page])
  end
  def new
    @internal_notification = InternalNotification.new
  end
  def create
    @internal_notification = InternalNotification.new(internal_notification_params)
    if @internal_notification.save
      redirect_to admin_internal_notifications_path, notice: I18n.t('controllers.admin.internal_notifications.create.success')
    else
      render :new, notice: "Please correct the errors and try again"
    end
  end
  def show
  end
  def edit
  end
  def update
    if @internal_notification.update_attributes(internal_notification_params)
      redirect_to admin_internal_notification_path(@internal_notification)
    else
      render :edit, notice: "Please correct the errors and try again"
    end
  end
  def destroy
    @internal_notification.destroy!
    redirect_to admin_internal_notifications_path
  end

  private
  def find_notification
    @internal_notification = InternalNotification.find(params[:id])
  end
  def internal_notification_params
    params.require(:internal_notification).permit(:message, :displayed)
  end
end
