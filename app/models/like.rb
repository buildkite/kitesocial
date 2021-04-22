class Like < ApplicationRecord
  belongs_to :liker, class_name: "User"
  belongs_to :chirp, class_name: "Chirp"
end
