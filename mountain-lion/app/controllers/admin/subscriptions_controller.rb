class Admin::SubscriptionsController < AdminController
  before_action :set_user
  before_action :set_subscription

  # GET /admin/subscriptions/1/edit
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = @user.subscription
    end
    def set_user
      @user = User.find(params[:user_id])
    end
end
