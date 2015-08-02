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

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create :order_item }

  subject { order_item }

  context "attributes" do
    it { is_expected.to respond_to(:order) }
    it { is_expected.to respond_to(:product) }
    it { is_expected.to respond_to(:quantity) }
    it { is_expected.to respond_to(:subtotal) }
    it { is_expected.to respond_to(:unit_price) }
  end

  context "associations" do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end
end
