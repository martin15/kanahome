class Category < ApplicationRecord
  has_permalink :name, :update => true

  has_many :products, dependent: :destroy
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent_category,  class_name: "Category", optional: true 

  validates :name, presence: true 

  scope :parent_categories, -> { where("parent_id is null") }
  scope :child_categories, -> { where("parent_id is not null") }

  def default_category
    self.first
  end

  def is_parent?
    !!self.parent_id.nil?
  end

end
