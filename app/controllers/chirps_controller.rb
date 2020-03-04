# frozen_string_literal: true

class ChirpsController < ApplicationController
  def create
    current_user.chirps.create!(chirp_params)

    redirect_to root_path
  end

  private

  def chirp_params
    params.require(:chirp).permit(:content)
  end
end
