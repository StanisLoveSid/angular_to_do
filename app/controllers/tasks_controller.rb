class TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    if @task.save
      respond_with @task
    else
      render(status: 422, json: @task.errors.full_messages)
    end
  end

  def update
    if @task.update(task_params)
      respond_with @task
    else
      render(status: 422, json: @task.errors.full_messages)
    end
  end

  def destroy
    respond_with @task.destroy
  end

  def reorder
    @task = Task.find(params[:id])
    authorize! :update, @task
    respond_with reorder_task(params[:direction])
  end

  private

  def task_params
    params.require(:task).permit(:title, :project_id, :done, :deadline)
  end

  def reorder_task(direction)
    if direction == 'down'
      @task.move_lower
    else
      @task.move_higher
    end
  end
end
