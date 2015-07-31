class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  # before_create :compute_subtotal

  # after_save :compute_order_total

  # def compute_subtotal
  #   self.subtotal = self.product.price * self.quantity
  # end


  # def compute_order_total
  #   self.order.order_items.map { |oi|   }
  #   self.order.update_attributes()
  # end
end
