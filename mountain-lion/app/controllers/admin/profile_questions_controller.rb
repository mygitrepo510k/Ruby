class Admin::ProfileQuestionsController < AdminController
  def index
    @profile_questions = ProfileQuestion.all.order('profile_section_id ASC').page(params[:page])
  end
  def new
    @profile_question = ProfileQuestion.new
  end
  def create
    @profile_question = ProfileQuestion.new(profile_question_params)
    if @profile_question.save
      redirect_to admin_profile_questions_path, notice: I18n.t('controllers.admin.profile_questions.create.success')
    else
      render :new, notice: "Please correct the errors and try again"
    end
  end
  def show
    @profile_question = ProfileQuestion.find(params[:id])
  end
  def edit
    @profile_question = ProfileQuestion.find(params[:id])
  end
  def update
    @profile_question = ProfileQuestion.find(params[:id])
    if @profile_question.update_attributes(profile_question_params)
      redirect_to admin_profile_question_path(@profile_question)
    else
      render :edit, notice: "Please correct the errors and try again"
    end
  end
  def destroy
    @profile_question = ProfileQuestion.find(params[:id])
    @profile_question.destroy!
    redirect_to admin_profile_questions_path
  end

  private
  def profile_question_params
    params.require(:profile_question).permit(:question, :reverse_question, :profile_section_id, :answer_type, profile_answers_attributes: [ :answer, :_destroy, :id ])
  end
end
