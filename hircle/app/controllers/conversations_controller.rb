class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    @conversation = Conversation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @conversation = Conversation.find(params[:id])
  end

  def create
    p params
    @conversation = Conversation.new
    message = @conversation.messages.build(params[:conversation][:message])
    message.sender = current_user
    if @conversation.save
      channel = Friend.where(:user_id => current_user.id, :friend_id => message.recipient_id).first.channel 
      Pusher[channel].trigger('my-event', {:recipient_id => message.recipient_id.to_s,
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

  # POST /conversations
  # POST /conversations.json
=begin
  def create
    @conversation = Conversation.new(params[:conversation])

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :created, location: @conversation }
      else
        format.html { render action: "new" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # PUT /conversations/1
  # PUT /conversations/1.json
  def update
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      if @conversation.update_attributes(params[:conversation])
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :no_content }
    end
  end
end
