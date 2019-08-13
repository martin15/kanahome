class ProductImage < ApplicationRecord
  belongs_to  :product

  mount_uploader :image, ProductImageUploader

  validates :image, presence: true

end
