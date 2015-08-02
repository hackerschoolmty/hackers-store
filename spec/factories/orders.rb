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

FactoryGirl.define do
  factory :order do
    user
    status 0
  end
end
