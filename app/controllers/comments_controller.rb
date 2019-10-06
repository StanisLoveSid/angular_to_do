class CommentsController < ApplicationController
  # before_action :authenticate_user!
  load_resource

  def create
    if @comment.save
      respond_with @comment
    else
      render(status: 422, json: @comment.errors.full_messages)
    end
  end

  def update
    @comment.attachment = params[:attachment]
    if @comment.save
      render json: @comment.attachment
    else
      render(status: 422, json: @comment.errors.full_messages)
    end
  end

  def destroy
    respond_with @comment.destroy
  end

  private

  def comment_params
    params.permit(:title, :task_id)
  end
end
