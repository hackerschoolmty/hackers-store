Hackers Store
================

A payments implementation example


```
rails g scaffold product name:string description:text price:decimal stock:integer author_id:integer

rails g scaffold order user_id:integer total:decimal status:integer token:string

rails g scaffold order_items order_id:integer product_id:integer quantity:integer subtotal:decimal
```

# steps:
  - Use roles [:admin, customer].
  - Generate products.
  - Fix routes.
  - Show products in front store.
  - Products with slug
  - add quantity input in product.
  - add to cart button.
  - checkout page.
  - process payment with conekta.
  - Remove product_item from cart.
  - Send email to admin when user place order.


