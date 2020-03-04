class User < ApplicationRecord
  has_secure_password
  has_many :chirps, foreign_key: :author_id

  def timeline
    Chirp.all.order(created_at: :desc)
  end
end
