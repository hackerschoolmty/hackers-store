# == Schema Information
#
# Table name: order_items
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  product_id :integer
#  quantity   :integer          default(1)
#  subtotal   :decimal(, )      default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  unit_price :decimal(, )
#
class OrderItem < ActiveRecord::Base
  before_save :compute_subtotal
  after_destroy :update_order
  after_save :update_order

  belongs_to :order
  belongs_to :product

  def compute_subtotal
    self.unit_price = product.price
    self.subtotal = unit_price * quantity
  end

  def update_order
    order.compute_total
    order.save
  end
end
