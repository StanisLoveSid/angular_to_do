class TasksController < ApplicationController
  # before_action :authenticate_user!
  load_resource

  def create
    if @task.save
      respond_with @task
    else
      render(status: 422, json: @task.errors.full_messages)
    end
  end

  def update_position
    params[:positions].each do |id, index|
      Task.find(id).update(position: index)
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

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def task_params
    params.permit(:title, :project_id, :done, :deadline)
  end
end
