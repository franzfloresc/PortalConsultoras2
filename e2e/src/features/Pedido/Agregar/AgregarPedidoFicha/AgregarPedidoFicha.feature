@AgregarPedido @AgregarPedidoFicha
Feature: Agregar pedido desde Ficha Producto
Como cualquier consultora
Quiero agregar una o mas ofertas a mi carrito
Para verlas en mi carrito de compras

@CPA033
Scenario Outline: Agregar varias ofertas desde Ficha Producto ingresando pasando por Home
Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>"
When Me encuentro en la seccion "<Seccion>"
Then  Ir a ficha de cuvs "<CUVS>" desde la seccion "<Seccion>" y agregar "<Cantidades>" del cuv
And Ingresar a pase pedido

Examples:
| Pais | Usuario         | Password | Seccion | CUVS              | Cantidades |
| PE   | usuariopruebape | 1234567  | Dorada  | 48385             | 5          |
#| PE   | usuariopruebape | 1234567  | Dorada  | 48385,71756      | 5,12       |


@CPA034
Scenario Outline: Agregar varias ofertas desde ficha en seccion ShowRoom del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>"
  When Me dirijo al contenedor de Palancas 
  Then En el contenedor en la seccion "<Seccion>" ingresar a la ficha del cuv "<CUVS>" y agregar "<Cantidades>" cuvs
  Then Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario         | Password| Seccion | CUVS          | Cantidades |
  | PE   | usuariopruebape | 1234567 | SR      | 61096, 31521  | 5,6        |