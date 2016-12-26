class KnowledgeCentreController < ApplicationController
  before_filter :authenticate_user!

  # The Knowledge Centre Page
  # 
  # @route      GET /kc/index , GET /kc/:page_url
  # @wireframe  https://projects.invisionapp.com/d/main#/console/381469/8769338/preview
  # @renders    knowledge_centre/index.html.haml
  
  def index
    @titles = []
    if current_user.role? :doctor
      @titles = KcPage.select('kc_pages.*').where(:published=>true, :visible_to_doctors=>true).order(:sort_order)
    elsif current_user.role? :patient
      @titles = KcPage.select('kc_pages.*').where(:published=>true, :visible_to_patients=>true).order(:sort_order)
    end

    if params[:page_url].present?
      @page = KcPage.where(:url=>params[:page_url], :published=>true, :visible_to_doctors=>current_user.role?(:doctor), :visible_to_patients=>current_user.role?(:patient)).first
    end
    @page ||= KcPage.where(:published=>true, :visible_to_doctors=>current_user.role?(:doctor), :visible_to_patients=>current_user.role?(:patient)).first

    if @page.nil?
      flash[:notice] = "The Knowledge Centre section isn't available"
      redirect_to root_url
    end
  end
end
