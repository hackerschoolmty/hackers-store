class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items

  before_save :compute_total

  def compute_total
    if self.order_items
      sum = 0
      self.order_items.map { |oi| sum += oi.quantity * oi.product.price }
    end
  end
end
