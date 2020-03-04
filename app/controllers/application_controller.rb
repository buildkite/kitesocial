class ApplicationController < ActionController::Base
  before_action :require_authenticated_user

  def require_authenticated_user
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
