class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.string  :image
      t.text    :description
      t.integer :product_id
      t.boolean :is_primary
      t.timestamps
    end
  end
end
