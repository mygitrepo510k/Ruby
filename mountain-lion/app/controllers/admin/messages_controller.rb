class Admin::MessagesController < AdminController
  before_action :find_user
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  def index
    @received_messages = @user.received_messages.order('created_at DESC').page(params[:page])
    render :inbox
  end

  def inbox
    @received_messages = @user.received_messages.order('created_at DESC').page(params[:page])
  end

  def sent
    @sent_messages = @user.sent_messages.order('created_at DESC').page(params[:page])
  end

  # GET /messages/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      begin
        begin
          @message = @user.sent_messages.find(params[:id])
        rescue
          @message = @user.received_messages.find(params[:id])
        end
      rescue
        nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:subject, :body, :recipient_id)
    end

    def find_user
      @user = User.find(params[:user_id])
    end
end
