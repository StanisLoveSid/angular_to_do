class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  respond_to :json

  rescue_from CanCan::AccessDenied do
    head :unauthorized
  end

  def angular
    render 'layouts/application'
  end
end
