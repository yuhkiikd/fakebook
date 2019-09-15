class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :content, presence: true
end