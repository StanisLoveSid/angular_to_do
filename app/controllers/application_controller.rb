class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  respond_to :json

  helper_method :current_user

  rescue_from CanCan::AccessDenied do
    head :unauthorized
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end
