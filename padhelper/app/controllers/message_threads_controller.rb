class MessageThreadsController < ApplicationController
  # GET /message_threads
  # GET /message_threads.json
  def index
    @message_threads = MessageThread.all

    render json: @message_threads
  end

  # GET /message_threads/1
  # GET /message_threads/1.json
  def show
    @message_thread = MessageThread.find(params[:id])

    render json: @message_thread
  end

  # GET /message_threads/new
  # GET /message_threads/new.json
  def new
    @message_thread = MessageThread.new

    render json: @message_thread
  end

  # POST /message_threads
  # POST /message_threads.json
  def create
    @message_thread = MessageThread.new(params[:message_thread])

    if @message_thread.save
      render json: @message_thread, status: :created, location: @message_thread
    else
      render json: @message_thread.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /message_threads/1
  # PATCH/PUT /message_threads/1.json
  def update
    @message_thread = MessageThread.find(params[:id])

    if @message_thread.update_attributes(params[:message_thread])
      head :no_content
    else
      render json: @message_thread.errors, status: :unprocessable_entity
    end
  end

  # DELETE /message_threads/1
  # DELETE /message_threads/1.json
  def destroy
    @message_thread = MessageThread.find(params[:id])
    @message_thread.destroy

    head :no_content
  end
end
