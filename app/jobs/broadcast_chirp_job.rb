class BroadcastChirpJob < ApplicationJob
  queue_as :default

  def perform(chirp)
    html_fragment = ChirpsController.render(partial: "chirps/chirp", locals: { chirp: chirp })

    ActionCable.server.broadcast "firehose", chirp: html_fragment
    ChirpsChannel.broadcast_to chirp.author, chirp: html_fragment

    chirp.author.followers.each do |follower|
      TimelinesChannel.broadcast_to follower, chirp: html_fragment
    end
  end
end
