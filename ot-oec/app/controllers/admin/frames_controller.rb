class Admin::FramesController < ApplicationController
  def index
    @frames = ChallengeFrame.submitted
      .joins(:challenge).joins(:content_group)
      .where('program_id = ?', current_user.current_program)
      .order('content_groups.created_at desc')
      .paginate page: params[:page]
  end
end
