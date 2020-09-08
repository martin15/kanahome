class Product < ApplicationRecord
  has_permalink :name, :update => true

  has_many :product_images, inverse_of: :product
  has_many :product_feature_details, inverse_of: :product

  belongs_to  :category

  validates :name, presence: true
  validates :short_description, presence: true

  accepts_nested_attributes_for :product_images, allow_destroy: true

  def category_name
    self.try(:category).try(:name)
  end

  def image(size)
    img = self.product_images.first
    if img.nil?
      return "/assets/no-image-yet.jpg"
    else
      return img.image.url(size.to_sym)
    end
  end

  def primary_image
    img = self.product_images.where("is_primary is not null and is_primary = true").first
    img = self.product_images.first if img.nil?
    if img.nil?
      return "/assets/no-image-yet.jpg"
    else
      puts img.inspect
      return img.image.url(:medium)
    end
  end
end
