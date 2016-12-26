class ChatConversationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    p params
    #render :text=> params.inspect and return
    @conversation = ChatConversation.new
    message = @conversation.chat_messages.build(params[:chat_conversation][:chat_message])
    message.sender = current_user
    if @conversation.save
      channel = Friend.where(:user_id => current_user.id, :friend_id => message.recipient_id).first.channel 
      Pusher[channel].trigger('my-event', 
                                    { :recipient_id => message.recipient_id.to_s,
                                      :message => message.body,
                                      :name => message.sender.email, 
                                      :created_at => message.created_at.strftime("%I %p %a %m %d, %Y"),
                                      :channel_name => channel
                                    }
                              )  


     render :json =>  {:status => 'success',
            :message => {:body => message.body,
            :recipient_id => message.recipient_id.to_s, 
            :email => message.recipient.email,
            :created_at => message.created_at.to_s
          }} 
    else
      flash[:error] = "Cannot send message to that user."
      render :json => {:status => 'error'}
    end
  end

end
