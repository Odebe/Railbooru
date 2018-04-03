class ModerateTasksController < ApplicationController
  before_action :set_moderate_task, only: [:show, :edit, :update, :destroy]

  # GET /moderate_tasks
  # GET /moderate_tasks.json
  def index
    @moderate_tasks = ModerateTask.order(:created_at).reverse_order.page params[:page]
  end

  # GET /moderate_tasks/1
  # GET /moderate_tasks/1.json
  def show
  end

  # GET /moderate_tasks/new
  def new
    @moderate_task = ModerateTask.new
  end

  # GET /moderate_tasks/1/edit
  def edit
  end

  # POST /moderate_tasks
  # POST /moderate_tasks.json
  def create
    @moderate_task = ModerateTask.new(moderate_task_params)

    respond_to do |format|
      if @moderate_task.save
        format.html { redirect_to @moderate_task, notice: 'Moderate task was successfully created.' }
        format.json { render :show, status: :created, location: @moderate_task }
      else
        format.html { render :new }
        format.json { render json: @moderate_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moderate_tasks/1
  # PATCH/PUT /moderate_tasks/1.json
  def update
    respond_to do |format|
      if @moderate_task.update(moderate_task_params)
        format.html { redirect_to @moderate_task, notice: 'Moderate task was successfully updated.' }
        format.json { render :show, status: :ok, location: @moderate_task }
      else
        format.html { render :edit }
        format.json { render json: @moderate_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moderate_tasks/1
  # DELETE /moderate_tasks/1.json
  def destroy
    @moderate_task.destroy
    respond_to do |format|
      format.html { redirect_to moderate_tasks_url, notice: 'Moderate task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moderate_task
      @moderate_task = ModerateTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moderate_task_params
      params.require(:moderate_task).permit(:type, :model_type, :model_id, :creator, :passer)
    end
end
