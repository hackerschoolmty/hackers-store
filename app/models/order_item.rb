class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product


  before_save :compute_subtotal
  after_destroy :update_order

  after_save :update_order


  def compute_subtotal
    self.unit_price = product.price
    self.subtotal = unit_price * quantity
  end

  def update_order
    self.order.compute_total
    self.order.save
  end

end
