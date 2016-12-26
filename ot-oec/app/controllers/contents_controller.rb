class ContentsController < ApplicationController
  before_filter :require_login
  layout false, only: [:new]
  respond_to :json

  def new
    html = render_to_string(
      template: '/contents/_%s_form.slim' % params[:type], 
      formats: ['html'], layout: false )
    render json: { html: html }
  end

  #def main
  #end

  def get_contents
  end

  def main
    prog = current_user.current_program
    @node = prog.root_content_node
    if not @node
      @node = ContentNode.create!(name: "#{prog.name} root node")
      prog.update!(root_content_node: @node)
    end
  end

  def content_load
  	@month = params[:month]
    @option = params[:option]

    @contents = Content.where(program: current_user.current_program)
   	
    if @month.present?
      @contents = @contents.where(month: Date::MONTHNAMES.index(@month))
    end
    if @option.present?
      @contents = @contents.where(option: Content::CONTENT_OPTIONS.index(@option).to_s)
    end

    if params[:files]
      @contents = Content.where(program: current_user.current_program).select { |c| c.file? }
    end

    respond_to do |format|
      format.json {
        render json: { html: render_to_string(partial: 'contents', layout: false) }
      }
    end
  end
end
