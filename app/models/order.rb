# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  total      :decimal(, )      default(0.0)
#  status     :integer          default(0)
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tax_amount :decimal(, )      default(0.0)
#  subtotal   :decimal(, )      default(0.0)
#
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

  def send_confirmation
    Notifier.purchase_confirmation(self).deliver
  end

  handle_asynchronously :send_confirmation, run_at: proc { 10.seconds.from_now }
end
