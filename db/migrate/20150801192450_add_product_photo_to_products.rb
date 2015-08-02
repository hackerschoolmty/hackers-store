class AddProductPhotoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_photo, :string
  end
end
