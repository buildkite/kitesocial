# frozen_string_literal: true

class HomeController < ApplicationController
  def timeline
    @timeline = current_user.timeline.limit(50)
  end

  def firehose
    @timeline = Chirp.firehose.limit(50)
  end
end
