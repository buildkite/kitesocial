class Chirp < ApplicationRecord
  belongs_to :author, class_name: "User"

  def self.firehose
    all.includes(:author).order(created_at: :desc)
  end
end
