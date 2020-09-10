class Banner < ApplicationRecord
  TYPE = [["mobile", "mobile"], ["web", "web"]]
  mount_uploader :image, BannerUploader

  validates_presence_of :image
end
