class Order < ActiveRecord::Base

  before_save :compute_total
  before_update :compute_total

  belongs_to :user

  has_many :order_items, dependent: :destroy

  enum status: [:pending, :paid, :failed]

  def compute_total
    self.subtotal = order_items.sum(:subtotal)
    self.tax_amount = subtotal * 0.16
    self.total = subtotal + tax_amount
  end
end

# cowork:
# huskysea178
# cowork-guest:
# huskysea179