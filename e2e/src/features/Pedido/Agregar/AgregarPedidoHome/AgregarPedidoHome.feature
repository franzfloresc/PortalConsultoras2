@AgregarPedido @AgregarPedidoHome
Feature: Agregar pedido desde Home de SomosBelcorp Web
Como cualquier consultora
Quiero agregar una o mas ofertas a mi carrito
Para verlas en mi carrito de compras

@UnCuv @CPA020
Scenario Outline: Agregar una oferta desde seccion Home
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>"
  When Me encuentro en la seccion indicada
  And Agrego un cuv "<CUV>", <Cantidad> veces de la seccion "<Seccion>"
  Then Visualizare en mi carrito los productos que agregue
  And Ingresar a pase pedido

Examples:
  | Pais | Usuario   | Password | Seccion | CUV   | Cantidad |
  | PE   | 008424152 | 07635789 | Dorada  | 41287 | 5        |

@VariosCuvs @CPA021
Scenario Outline: Agregar varias ofertas desde seccion Home
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>"
  When Me encuentro en la seccion indicada
  And Agrego varios cuvs "<CUVS>", "<Cantidades>" veces de la seccion "<Seccion>"
  Then Visualizare en mi carrito los productos que agregue
  And Ingresar a pase pedido

Examples:
  | Pais | Usuario         | Password | Seccion | CUVS        | Cantidades |
  | PE   | usuariopruebape | 1234567  | Dorada  | 44826,48385 | 5,6      |
