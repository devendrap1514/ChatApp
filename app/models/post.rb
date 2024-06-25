class Post < ApplicationRecord
  has_one_attached :video
  has_one_attached :video_thumbnail

  validates :video, presence: true
end
