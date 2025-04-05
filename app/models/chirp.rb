class Chirp < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_and_belongs_to_many :mentions, class_name: "User"

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
    broadcast_prepend_later_to "firehose", target: "firehose", partial: "chirps/chirp", locals: { chirp: self }

    # Update the author's page
    broadcast_prepend_later_to ["chirps", author.id], target: "chirps", partial: "chirps/chirp", locals: { chirp: self }

    # Update the timelines of all users who are interested in this chirp
    interested_users.each do |follower|
      broadcast_prepend_later_to ["timeline", follower.id], target: "timeline", partial: "chirps/chirp", locals: { chirp: self }
    end
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
