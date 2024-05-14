class BroadcastChirpJob < ApplicationJob
  queue_as :default

  def perform(chirp)
    chirp_html_fragment = ChirpsController.render(partial: "chirps/chirp", locals: { chirp: chirp })
    chirp_message = { chirp: chirp_html_fragment }

    ActionCable.server.broadcast "firehose", chirp_message
    ChirpsChannel.broadcast_to chirp.author, chirp_message

    chirp.interested_users.each do |follower|
      TimelinesChannel.broadcast_to follower, chirp_message
    end
  end
end
