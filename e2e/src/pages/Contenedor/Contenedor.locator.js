config = {
  locator: {
    secContenedor: seccion => {
      return { xpath: `//div[@data-seccion='${seccion}']` };
    },
    Elemento: (seccion, cuv) => {
      return {
        xpath: `//div[@data-seccion='${seccion}']//div[@role='option' and @data-item-cuv='${cuv}']`
      };
    },
    btnDerecha: seccion => {
      return {
        xpath: `//div[@data-seccion='${seccion}']//a[contains(@class,'nextArrow slick-arrow')]/img`
      };
    },
    btnAgregar: (seccion, cuv) => {
      return {
        xpath: `//div[@data-seccion='${seccion}']//div[@role='option' and @data-item-cuv='${cuv}']//a[contains(text(),'AGRÉGALO')]`
      };
    },
    btnSubirCant: (seccion, cuv) => {
      return {
        xpath: `//div[@data-seccion='${seccion}']//div[@role='option' and @data-item-cuv='${cuv}']//a[@class='mas js-no-popup']`
      };
    },
    btnReducirCant: (seccion, cuv) => {
      return {
        xpath: `//div[@data-seccion='${seccion}']//div[@role='option' and @data-item-cuv='${cuv}']//a[@class='menos js-no-popup']`
      };
    },
    popupAgregado: {
      xpath: "//div[text()='¡Listo! Agregaste con éxito a tu pedido.']"
    },
    lblContenedorItems: { xpath: "//div[@id='carrito_items']" },
    btnIrContenedor: { xpath: "//a[@id='lnk-pri-ofertas']" }
  }
};

module.exports.config = config;
module.exports.locator = config.locator;
