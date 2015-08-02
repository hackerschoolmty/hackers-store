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

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create :order }

  subject { order }

  context "attributes" do
    it { is_expected.to respond_to(:user) }
    it { is_expected.to respond_to(:total) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:token) }
    it { is_expected.to respond_to(:subtotal) }
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
  end

  context 'methods' do
    describe '#compute_total' do
      it 'should update subtotal, tax_amount, total' do
        product = create :product, price: 100
        order = create(:order_item, product: product).order
        expect(order.subtotal).to eq 100
        expect(order.tax_amount).to eq 16
        expect(order.total).to eq 116
      end
    end
  end
end
