class ContentGroupsController < ApplicationController
  before_filter :require_login
  layout false

  def create
    type = params[:belongs_to_type].constantize

    if params[:content_group]
      group = ContentGroup.create!(params[:content_group].merge(created_by: current_user))
    else 
      group = ContentGroup.create!(created_by: current_user)
    end

    if !(params['content_group']['description'].strip.size > 0) and type == ChallengeFrame
      flash[:warn] = 'You must enter something as a frame'
      redirect_to params[:redirect] and return
    elsif !params[:content] and !(type == ChallengeFrame or type == Experience)
      flash[:warn] = 'You must upload at least one piece of content'
      redirect_to params[:redirect] and return
    elsif params[:content]
      params[:content].each do |c|
        begin
          group.contents << Content.create(c.merge(created_by: current_user))
        rescue
          flash[:notice] = 'Something went wrong, one or more items of content could not be saved'
          redirect_to params[:redirect] and return
        end
      end
    end

    if type == Experience
      exp = Experience.find(params[:belongs_to])
      unless exp.created_for == current_user; unauthorized params[:redirect] and return; end

      exp.update_attributes({ frame: group, private: params[:private] || false })
    elsif type == ContentNode
      ContentNode.find(params[:belongs_to]).content_groups << group
    elsif type == Challenge
      unless current_user.admin?; unauthorized params[:redirect] and return; end

      Challenge.find(params[:belongs_to]).update_attributes({ content_group: group, private: params[:private] || false })
    else
      frame = ChallengeFrame.find(params[:belongs_to])
      unless frame.user == current_user; unauthorized params[:redirect] and return; end

      frame.update_attributes({ content_group: group, private: params[:private] || false })
    end

    redirect_to params[:redirect]
  end

  def new
  end

  def edit
  end

  def show
    @content_group = ContentGroup.find(params[:id]).contents.group_by(&:content_type)
  end

  def update
  end

  def destroy
  end
end
