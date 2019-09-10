@AgregarPedido @AgregarPedidoLanding
Feature: Agregar pedido desde Landing de SomosBelcorp Web
Como cualquier consultora
Quiero agregar uno o mas productos a mi carrito de compra de diferentes Landings
Para verlas en mi carrito de compras

@ATP @CPA032
Scenario Outline: Agregar un pack de ofertas desde Landing Arma tu Pack     
Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>"
When Me dirijo al contenedor de Palancas    
And Me dirijo al landing de Arma tu pack
Then Puedo agregar los productos deseados "<Productos>"
And Puedo ir a pase pedido

Examples:
| Pais | Usuario        | Password | Productos         | 
| PE   | usuariodummy1  | 1234567  | 32006,32008,32007 |