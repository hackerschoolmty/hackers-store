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

  context 'methods' do
    describe '#compute_subtotal' do
      it 'should update subtotal' do
        product = create :product, price: 100
        oi = create(:order_item, product: product)
        expect(oi.subtotal).to eq 100
      end
    end

    describe '#update_order' do
      it 'should update order total after save' do
        product = create :product, price: 100
        oi = create(:order_item, product: product)
        expect(oi.order.total).to eq 116
      end
      
      it 'should update order total after destroy' do
        product = create :product, price: 100
        order = create(:order_item, product: product).order
        order.order_items.first.destroy
        expect(order.subtotal).to eq 0
        expect(order.tax_amount).to eq 0
        expect(order.total).to eq 0
      end
    end
  end
end
