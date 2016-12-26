class Admin::FlirtsController < AdminController
  def index
    @flirts = Flirt.all.page(params[:page])
  end
  def show
    @flirt = Flirt.find(params[:id])
  end
  def new
    @flirt = Flirt.new
  end
  def create
    @flirt = Flirt.new(flirt_params)
    if @flirt.save
      redirect_to admin_flirts_path, notice: I18n.t('controllers.admin.flirts.create.success')
    else
      render :new, notice: "Please correct the errors and try again"
    end
  end
  def sort
    params[:flirt].each_with_index do |q, i|
      Flirt.update_all({ position: i + 1 }, { id: q })
    end
    render nothing: true
  end
  def edit
    @flirt = Flirt.find(params[:id])
  end
  def update
    @flirt = Flirt.find(params[:id])
    if @flirt.update_attributes(flirt_params)
      redirect_to admin_flirt_path(@flirt)
    else
      render :edit, notice: "Please correct the errors and try again"
    end
  end
  def destroy
    @flirt = Flirt.find(params[:id])
    @flirt.destroy!
    redirect_to admin_flirts_path
  end
  private
  def flirt_params
    params.require(:flirt).permit(:message)
  end
end
