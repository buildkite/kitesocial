# frozen_string_literal: true

class ChirpsController < ApplicationController
  def create
    @chirp = current_user.chirps.create!(chirp_params)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("new_chirp", partial: "chirps/form"),
          turbo_stream.prepend("timeline", partial: "chirps/chirp", locals: { chirp: @chirp })
        ]
      end
    end
  end

  private

  def chirp_params
    params.require(:chirp).permit(:content)
  end
end
