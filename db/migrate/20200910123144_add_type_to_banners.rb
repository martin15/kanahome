class AddTypeToBanners < ActiveRecord::Migration[5.1]
  def change
    add_column :banners, :b_type, :string
  end
end
