class SeoController < ApplicationController
  layout 'frontpage'

  def landing1
    render layout: nil
  end

  def men
    @no_footer = true
    @users = User.seo_gender('M').page(params[:page]).per(per_page)
    render :people
  end

  def women
    @no_footer = true
    @users = User.seo_gender('F').page(params[:page]).per(per_page)
    render :people
  end

  private
  def per_page
    Rails.env.staging? ? 3 : 15
  end
end
