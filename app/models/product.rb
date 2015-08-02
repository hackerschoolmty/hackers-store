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
class Product < ActiveRecord::Base
  before_create :ensure_slug

  validates :price, :stock, numericality: true
  validates :name, presence: true

  belongs_to :author, inverse_of: :products, class_name: 'User',
                      foreign_key: 'author_id'

  def ensure_slug
    self.slug = name.parameterize if slug.blank?
  end

  def self.fix_slugs
    Product.all.each do |p|
      p.ensure_slug
      p.save
    end
  end

  def self.fake_products
    50.times do
      Product.create(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price,
        stock: Faker::Number.number(6).to_i
      )
    end
  end
end
