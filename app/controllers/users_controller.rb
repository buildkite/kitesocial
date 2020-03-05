# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    @chirps = @user.chirps.order(created_at: :desc)
  end
end
