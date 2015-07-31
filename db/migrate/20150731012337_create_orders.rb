class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :total, default: 0
      t.integer :status, default: 0
      t.string :token

      t.timestamps null: false
    end
  end
end
