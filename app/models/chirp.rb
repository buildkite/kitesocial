class Chirp < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes, foreign_key: :chirp_id, inverse_of: :chirp
  has_and_belongs_to_many :mentions, class_name: "User"

  has_many :likers, through: :likes

  before_create :record_mentions
  after_create :broadcast

  def self.timeline_for(user)
    where(author: user).or(where(author: user.friends)).or(where(id: user.mentions))
  end

  def interested_users
    [author] | author.followers | mentions
  end

  def self.firehose
    all.includes(:author).order(created_at: :desc)
  end

  def broadcast
    BroadcastChirpJob.perform_later(self)
  end

  private

  def record_mentions
    self.mentions = mentioned_users
  end

  def mentioned_users
    User.where("LOWER(name) IN (?)", possible_mentions)
  end

  def possible_mentions
    content.scan(/(?<!\w)@\K\w+/).map(&:downcase).uniq
  end
end
