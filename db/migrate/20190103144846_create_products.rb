class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string    :name
      t.integer   :price
      t.text      :short_description
      t.text      :description
      t.integer   :category_id
      t.string    :permalink
      t.timestamps
    end
  end
end
