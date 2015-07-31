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


User stories:
  
  - Como administrador puedo entrar a la tienda y dar de alta productos

  - Como administrador puedo actualizar las existencias (stock) del producto

  - Como administrador puedo ver el listado de ordenes pendientes, pagadas, canceladas

  - Como admin debgo recibir una notificación cada que alguien me hace una compra.


  - Como comprador al entrar al home de la página debo ver todos los productos.
    incluídos los productos que no tienen existencias, estos deben aparecer bloqueados.

  - Como comprador puedo ver la página de detalles del producto (products#show)

  - Como comprador puedo agregar productos a un carrito y puede ser más de una unidad.

  - Como usuario puedo registrarme en la plataforma como customer.

  - Como comprador puedo hacer checkout (review de mi compra)

  - Como comprador puedo pagar mi compra.

  - Como comprador puedo cancelar mi compra.
  
