class Product < ActiveRecord::Base

  before_create :ensure_slug

  validates :price, :stock, numericality: true

  def ensure_slug
    self.slug = self.name.parameterize if self.slug.blank?
  end

  def self.fix_slugs
    Product.all.each do |p|
      p.ensure_slug
      p.save
    end
  end

  def self.fake_products
    50.times do
      Product.create({
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price,
        stock: Faker::Number.number(6).to_i
      })
    end
  end

end
