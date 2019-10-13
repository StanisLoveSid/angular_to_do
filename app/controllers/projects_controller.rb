class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_current_user

  def index
    respond_with(Project.all)
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      respond_with @project
    else
      render(status: 422, json: @project.errors.full_messages)
    end
  end

  def update_position
    params[:positions].each do |id, index|
      Project.find(id).update(position: index)
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project.attachment
    else
      render(status: 422, json: @project.errors.full_messages)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    respond_with @project.destroy
  end

  private

  def set_current_user
    @current_user ||= User.find(session[:user_id])
  end

  def project_params
    params.permit(:done, :important, :attachment, :positions, :title, :user_id)
  end
end
