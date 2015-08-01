class AddTaxesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax_amount, :decimal, default: 0
    add_column :orders, :subtotal, :decimal, default: 0
  end
end
