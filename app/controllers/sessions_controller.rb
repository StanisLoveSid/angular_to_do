class SessionsController < ApplicationController
  before_action :set_current_user, accept: [:facebook_login]

  def create
    user = User.find_by(email: params['user']['email'])
               .try(:authenticate, params['user']['password'])

    if user
      session[:user_id] = user.id
      render json: { status: :created, logged_in: true, user: user }
    else
      render json: { status: 401 }
    end
  end

  def logged_in
    if @current_user
      render json: { logged_in: true, user: @current_user }
    else
      render json: { logged_in: false }
    end
  end

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  def facebook_login
    @user = User.find_or_create_by(email: params[:email]) do |user|
      user.email = params[:email]
      user.password = Devise.friendly_token[0, 20]
    end

    if @user
      session[:user_id] = @user.id
      render json: { logged_in: true, user: @user }
    else
      render json: { status: 500 }
    end
  end

  def set_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
