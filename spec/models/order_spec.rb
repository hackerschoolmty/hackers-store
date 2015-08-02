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
end
