class AddCompatibilityToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :compatibility, :string
  end
end
