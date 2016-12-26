class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def limited
    authorize! :view, :silver, :message => 'Limited member login.'
  end
  
  def full
    authorize! :view, :gold, :message => 'Full Access member login.'
  end

  def free
    authorize! :view, :platinum, :message => 'Free member login.'
  end
  def coach    
    @partner = current_user
  end
  def counselor
    @partner = current_user
  end
end