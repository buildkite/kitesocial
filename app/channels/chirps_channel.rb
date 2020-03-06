class ChirpsChannel < ApplicationCable::Channel
  def subscribed
    if params[:user]
      stream_for User.find(params[:user])
    else
      stream_from "firehose"
    end
  end
end
