# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price       :decimal(, )
#  stock       :integer
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create :product }

  subject { product }

  context "attributes" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:price) }
    it { is_expected.to respond_to(:stock) }
    it { is_expected.to respond_to(:author) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:price) }
    it { is_expected.to validate_numericality_of(:stock) }
  end

  context "associations" do
    it { is_expected.to belong_to(:author) }
  end
end
