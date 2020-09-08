class Banner < ApplicationRecord
  mount_uploader :image, BannerUploader

  validates_presence_of :image
end
