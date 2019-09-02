config = {
  locator: {
    popupAgregado: {
      xpath: "//div[text()='¡Listo! Agregaste con éxito a tu pedido.']"
    },
    lblCantProd: { xpath: "//*[@id='pCantidadProductosPedido']" },
    lblCarritoCompras: {
      xpath: "//div[@class='campana cart_compras visibilidadEnlaceMenu']"
    },
    btnIrVerPedido: {
      xpath: "//div[@id='vpMenu']//a[contains(text(),'Ver mi carrito')]"
    },
    btnEliminarPedido: { xpath: "//a[@title='Haz click aquí']" },
    btnEliminarSi: { xpath: "//input[@id='btnEliminarPedidoCompletoSi']" }
  }
};

module.exports.config = config;
module.exports.locator = config.locator;
