# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.friends << @user

    redirect_back fallback_location: user_path(@user)
  end

  def destroy
    current_user.friends.delete(@user)

    redirect_back fallback_location: user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
