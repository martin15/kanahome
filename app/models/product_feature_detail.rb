class ProductFeatureDetail < ApplicationRecord
  belongs_to  :product

  mount_uploader :image, ProductFeatureDetailImageUploader
  mount_uploader :icon, ProductFeatureDetailIconUploader
  
end
