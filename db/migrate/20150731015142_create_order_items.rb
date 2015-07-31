class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity, default: 1
      t.decimal :subtotal, default: 0

      t.timestamps null: false
    end
  end
end
