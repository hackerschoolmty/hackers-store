json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :stock, :author_id
  json.url product_url(product, format: :json)
end
