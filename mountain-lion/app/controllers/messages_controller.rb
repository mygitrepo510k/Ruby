class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_user
  before_action :check_premium_user, only: [:create]

  # GET /messages
  def index
    redirect_to inbox_messages_path
  end

  def inbox
    @messages = current_user.
      received_messages.
      includes(:sender).
      visible_to_recipient.
      order('messages.created_at DESC').
      page(params[:page])
  end

  def sent
    @messages = current_user.
      sent_messages.
      includes(:recipient).
      visible_to_sender.
      order('messages.created_at DESC').
      page(params[:page])
  end

  def deleted
    @messages = current_user.
      received_messages.
      deleted_by_recipient.
      order('messages.created_at DESC').
      page(params[:page])
  end
  # GET /messages/1
  def show
    if @message
      @message.set_read if @message.recipient == current_user
    else
      redirect_to '/404'
    end
  end

  # GET /messages/new
  def new
    @message = Message.new(recipient_id: params[:recipient])
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    if params[:flirt_id].present?
      if current_user.
        sent_messages.
        where(recipient_id: message_params[:recipient_id]).
        where(subject: "You have received a new flirt!").
        count >= 10
        flash[:error] = "You can't send more than 10 flirts to one person"
        return redirect_to(users_path)
      end
      flirt = Flirt.find(params[:flirt_id])
      @message = current_user.sent_messages.new(message_params.merge(subject: "You have received a new flirt!", body: flirt.message))
    else
      @message = current_user.sent_messages.new(message_params)
    end

    if @message.save
      if params[:flirt_id].present?
        Thread.new do
          UserMailer.flirt_received_email(@message).deliver
        end
        redirect_to users_path, notice: 'Flirt sent!'
      else
        Thread.new do
          UserMailer.message_received_email(@message).deliver
        end
        redirect_to sent_messages_path, notice: 'Message sent!'
      end
    else
      render action: 'new'
    end
  end

  def new_flirt
    @message = Message.new(recipient_id: params[:recipient])
  end

  def destroy
    if @message.deleted_by_recipient
      undelete_message(@message)
    else
      delete_message(@message)
    end
    redirect_to inbox_messages_path
  end

  def delete
    Message.where(id: params[:messages]).each do |message|
      if message.deleted_by_recipient
        undelete_message(message)
      else
        delete_message(message)
      end
    end
    redirect_to inbox_messages_path
  end

  def abuse
    @message = Message.find(params[:id])
    @message.abuse = true
    @message.save
    redirect_to inbox_messages_path
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    begin
      begin
        @message = current_user.sent_messages.find(params[:id])
      rescue
        @message = current_user.received_messages.find(params[:id])
      end
    rescue
      return :not_found
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:subject, :body, :recipient_id)
  end

  def undelete_message(message)
    message.deleted_by_recipient = false
    message.save
  end

  def delete_message(message)
    case message.sender
    when current_user
      message.deleted_by_sender = true
    else
      message.deleted_by_recipient = true
    end
    message.save
  end

  def check_premium_user
    unless current_user.premium || params[:flirt_id].present? || (params[:message] && params[:message][:recipient_id].to_i == -1)
      flash[:error] = 'Only premium members can send messages'
      return redirect_to inbox_messages_path
    end
  end
end
