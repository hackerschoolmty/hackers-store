# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  price         :decimal(, )
#  stock         :integer
#  author_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#  product_photo :string
#

FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    stock 5
    author { build(:user) }
  end
end
