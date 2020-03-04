# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @timeline = current_user.timeline.limit(50)
  end
end
