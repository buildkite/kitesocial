# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_chirp

  def create
    current_user.liked_chirps << @chirp

    respond_to do |format|
      format.html do
        redirect_back fallback_location: user_path(@user)
      end
      format.json do
        render json: ChirpPresenter.to_hash(@chirp.reload, current_user)
      end
    end
  end

  def destroy
    current_user.liked_chirps.delete(@chirp)

    respond_to do |format|
      format.html do
        redirect_back fallback_location: user_path(@user)
      end
      format.json do
        render json: ChirpPresenter.to_hash(@chirp.reload, current_user)
      end
    end
  end

  private

  def set_chirp
    @chirp = Chirp.find(params[:chirp_id])
  end
end
