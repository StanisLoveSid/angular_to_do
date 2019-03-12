class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    respond_with @projects
  end

  def create
    @project = current_user.projects.new
    if @project.save
      respond_with @project
    else
      render(status: 422, json: @project.errors.full_messages)
    end
  end

  def update
    if @project.update(title: params[:title])
      respond_with @project
    else
      render(status: 422, json: @project.errors.full_messages)
    end
  end

  def destroy
    respond_with @project.destroy
  end
end
