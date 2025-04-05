# frozen_string_literal: true

class ChirpsController < ApplicationController
  def create
    current_user.chirps.create!(chirp_params)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream do
        render turbo_stream: [
          # Re-render the chirps/form partial
          turbo_stream.replace("new_chirp", partial: "chirps/form")
        ]
      end
    end
  end

  private

  def chirp_params
    params.require(:chirp).permit(:content)
  end
end
