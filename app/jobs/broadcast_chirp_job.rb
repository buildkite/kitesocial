class BroadcastChirpJob < ApplicationJob
  queue_as :default

  def perform(chirp)
    chirp_data = ChirpPresenter.to_hash(chirp)

    ActionCable.server.broadcast "firehose", chirp_data
    ChirpsChannel.broadcast_to chirp.author, chirp_data

    chirp.interested_users.each do |follower|
      TimelinesChannel.broadcast_to follower, chirp_data
    end
  end
end
