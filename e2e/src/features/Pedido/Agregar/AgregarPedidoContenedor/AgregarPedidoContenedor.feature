@AgregarPedido @AgregarPedidoContenedor
Feature: Agregar pedido desde Contenedor de SomosBelcorp Web
Como cualquier consultora
Quiero agregar uno o mas productos a mi carrito de compra de diferentes Palancas
Para verlas en mi carrito de compras

@ODD @UnCuv @CPA022
Scenario Outline: Agregar una oferta desde seccion Oferta Del Dia del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor me encuentro en la seccion "<Seccion>", buscare agregar <Cantidad> unidades del cuv "<CUV>"
  And En el Contenedor agrego un cuv, para la seccion buscada
  Then En el Contenedor visualizare en mi carrito el producto agregado
  And Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion | CUV   | Cantidad |
  | PE   | 008424152 | 07635789 | ODD     | 62101 | 5        |

@ODD @VariosCuvs @CPA023
Scenario Outline: Agregar varias ofertas desde seccion Oferta Del Dia del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor agrego varios cuvs "<CUVS>", "<Cantidades>" veces de la seccion "<Seccion>"
  Then Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion | CUVS         | Cantidades |
  | PE   | 008424152 | 07635789 | ODD     | 62098,62101  | 5,6        |

@SR @UnCuv @CPA024
Scenario Outline: Agregar una oferta desde seccion ShowRoom del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor me encuentro en la seccion "<Seccion>", buscare agregar <Cantidad> unidades del cuv "<CUV>"
  And En el Contenedor agrego un cuv, para la seccion buscada
  Then En el Contenedor visualizare en mi carrito el producto agregado
  And Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion | CUV   | Cantidad |
  | PE   | 008424152 | 07635789 | SR      | 61096 | 3        |

@SR @VariosCuvs @CPA025
Scenario Outline: Agregar varias ofertas desde seccion ShowRoom del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor agrego varios cuvs "<CUVS>", "<Cantidades>" veces de la seccion "<Seccion>"
  Then Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion | CUVS                        | Cantidades |
  | PE   | 008424152 | 07635789 | SR      | 61096, 61098, 61093, 31520  | 5,6,2, 8   |

@OPT @UnCuv @CPA026
Scenario Outline: Agregar una oferta desde seccion Ofertas Para Ti del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor me encuentro en la seccion "<Seccion>", buscare agregar <Cantidad> unidades del cuv "<CUV>"
  And En el Contenedor agrego un cuv, para la seccion buscada
  Then En el Contenedor visualizare en mi carrito el producto agregado
  And Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion  | CUV   | Cantidad |
  | PE   | 008424152 | 07635789 | RD       | 41287 | 3        |

@OPT @VariosCuvs @CPA027
Scenario Outline: Agregar varias ofertas desde seccion Ofertas Para Ti del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor agrego varios cuvs "<CUVS>", "<Cantidades>" veces de la seccion "<Seccion>"
  Then Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion  | CUVS          | Cantidades |
  | PE   | 008424152 | 07635789 | RD       | 41287, 41287  | 5,6        |

@LMG @UnCuv @CPA028
Scenario Outline: Agregar una oferta desde seccion Las Mas Ganadoras del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor me encuentro en la seccion "<Seccion>", buscare agregar <Cantidad> unidades del cuv "<CUV>"
  And En el Contenedor agrego un cuv, para la seccion buscada
  Then En el Contenedor visualizare en mi carrito el producto agregado
  And Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion  | CUV   | Cantidad |
  | PE   | 008424152 | 07635789 | LMG      | 61092 | 3        |

@LMG @VariosCuvs @CPA029
Scenario Outline: Agregar varias ofertas desde seccion Las Mas Ganadoras del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor agrego varios cuvs "<CUVS>", "<Cantidades>" veces de la seccion "<Seccion>"
  Then Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion  | CUVS          | Cantidades |
  | PE   | 008424152 | 07635789 | LMG      | 31685, 31686  | 5,6        |

@HV @UnCuv @CPA030
Scenario Outline: Agregar una oferta desde seccion Herramienta de Venta del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor me encuentro en la seccion "<Seccion>", buscare agregar <Cantidad> unidades del cuv "<CUV>"
  And En el Contenedor agrego un cuv, para la seccion buscada
  Then En el Contenedor visualizare en mi carrito el producto agregado
  And Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion  | CUV   | Cantidad |
  | PE   | 008424152 | 07635789 | HV       | 30209 | 3        |

@HV @VariosCuvs @CPA031
Scenario Outline: Agregar varias ofertas desde seccion Herramienta de Venta del Contenedor
  Given Realizo login en el pais "<Pais>" con mi usuario "<Usuario>" y mi password "<Password>" para ir al Contenedor
  When Me dirijo al contenedor de Palancas
  And En el Contenedor agrego varios cuvs "<CUVS>", "<Cantidades>" veces de la seccion "<Seccion>"
  Then Ingresar a pase pedido del Contenedor

Examples:
  | Pais | Usuario   | Password | Seccion  | CUVS          | Cantidades |
  | PE   | 008424152 | 07635789 | HV       | 30204, 30210  | 5,6        |
