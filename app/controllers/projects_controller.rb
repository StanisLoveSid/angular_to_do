class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  load_resource

  def index
    respond_with @projects
  end

  def create
    @project = Project.new(title: params[:title])
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

  def project_params
    params.permit(:done, :important, :attachment, :positions, :title)
  end
end
