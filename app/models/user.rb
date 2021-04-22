class User < ApplicationRecord
  has_secure_password

  has_many :chirps, foreign_key: :author_id, inverse_of: :author
  has_many :follows, foreign_key: :follower_id, inverse_of: :follower
  has_many :likes, foreign_key: :liker_id, inverse_of: :liker
  has_many :incoming_follows, class_name: "Follow", foreign_key: :friend_id, inverse_of: :friend
  has_and_belongs_to_many :mentions, class_name: "Chirp"

  has_many :friends, through: :follows
  has_many :liked_chirps, through: :likes, source: :chirp
  has_many :followers, through: :incoming_follows

  validates :name, format: /\A\w+\z/

  def timeline
    Chirp.timeline_for(self).includes(:author).order(created_at: :desc)
  end

  def following?(other)
    friends.where(id: other).exists?
  end

  def liked?(chirp)
    liked_chirps.where(id: chirp).exists?
  end
end
