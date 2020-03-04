# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_authenticated_user, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to root_path
    else
      redirect_back fallback_location: new_session_path, alert: "Unknown email/password"
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil

    redirect_to new_session_path
  end
end
