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

FactoryGirl.define do
  factory :order_item do
    order
    product
    quantity 1
    unit_price { Faker::Commerce.price }
  end
end
