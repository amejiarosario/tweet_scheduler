class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def require_authentication
    redirect_to sign_in_path unless user_signed_in?
  end

  helper_method :current_user, :user_signed_in?
end
