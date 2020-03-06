class Chirp < ApplicationRecord
  belongs_to :author, class_name: "User"
  after_create :broadcast

  def self.firehose
    all.includes(:author).order(created_at: :desc)
  end

  def broadcast
    BroadcastChirpJob.perform_later(self)
  end
end
