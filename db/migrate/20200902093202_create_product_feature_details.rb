class CreateProductFeatureDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :product_feature_details do |t|
      t.string    :icon_title
      t.string    :icon
      t.string    :title
      t.string    :image
      t.text      :description
      t.integer   :product_id
      t.integer   :order_no
      t.timestamps
    end
  end
end
