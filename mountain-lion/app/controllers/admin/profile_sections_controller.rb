class Admin::ProfileSectionsController < AdminController
  def index
    @profile_sections = ProfileSection.all.page(params[:page])
  end
  def new
    @profile_section = ProfileSection.new
  end
  def create
    @profile_section = ProfileSection.new(profile_section_params)
    if @profile_section.save
      redirect_to admin_profile_sections_path, notice: I18n.t('controllers.admin.profile_sections.create.success')
    else
      render :new, notice: "Please correct the errors and try again"
    end
  end
  def show
    @profile_section = ProfileSection.find(params[:id])
  end
  def edit
    @profile_section = ProfileSection.find(params[:id])
  end
  def sort_questions
    profile_section = ProfileSection.find(params[:id])
    params[:profile_question].each_with_index do |q, i|
      ProfileQuestion.update_all({ position: i + 1 }, { id: q, profile_section_id: profile_section.id })
    end
    render nothing: true
  end
  def sort_sections
    params[:profile_section].each_with_index do |q, i|
      ProfileSection.update_all({ position: i + 1 }, { id: q })
    end
    render nothing: true
  end
  def update
    @profile_section = ProfileSection.find(params[:id])
    if @profile_section.update_attributes(profile_section_params)
      redirect_to admin_profile_section_path(@profile_section)
    else
      render :edit, notice: "Please correct the errors and try again"
    end
  end
  def destroy
    @profile_section = ProfileSection.find(params[:id])
    @profile_section.destroy!
    redirect_to admin_profile_sections_path
  end

  private
  def profile_section_params
    params.require(:profile_section).permit(:name, :reverse_name, :displayed)
  end
end
