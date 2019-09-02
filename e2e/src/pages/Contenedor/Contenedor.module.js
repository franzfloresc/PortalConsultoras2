const I = actor();
let wait = { retries: 5, minTimeout: 2000 };
const config = require("./Contenedor.locator");
const assert = require("assert");
let locator = config.locator;
let locatorSeccion = "";
let intCantFinal = 0;
let intCantInicio = 0;

module.exports = {
  Constructor() {
    this.locator = config.locator;
  },

  Constructor(Seccion, CUV, Cantidad) {
    this.locator = config.locator;
    this.Seccion = Seccion;
    this.CUV = CUV;
    this.Cantidad = Cantidad;
  },

  async ValidacionContenedor() {
    I.seeInCurrentUrl("/Ofertas");
  },

  IrASeccion() {
    locatorSeccion = locator.secContenedor(this.Seccion);
    I.seeElement(locatorSeccion);
    I.scrollTo(locatorSeccion, 2, 2);
  },

  async BuscarElemento() {
    var contenido = "";
    I.seeElement(locator.Elemento(this.Seccion, this.CUV));
    contenido = await I.grabAttributeFrom(
      locator.Elemento(this.Seccion, this.CUV),
      "aria-hidden"
    );
    if (contenido == "true") {
      await this.DesplazarCarrusel();
    }
  },

  async DesplazarCarrusel() {
    var contenido = "";
    do {
      contenido = await I.grabAttributeFrom(
        locator.Elemento(this.Seccion, this.CUV),
        "aria-hidden"
      );
      I.click(locator.btnDerecha(this.Seccion));
    } while (contenido == "true");
  },

  AgregarElemento() {
    for (var i = 1; i < this.Cantidad; i++) {
      //El carrito ya parte de 1 elemento.
      I.click(locator.btnSubirCant(this.Seccion, this.CUV));
      I.wait(1);
    }
    I.click(locator.btnAgregar(this.Seccion, this.CUV));
  },

  async ValidacionCantCarrito() {
    I.retry(wait).say(
      "Se validará que la cantidad mostrada en el carrito corresponde a la cantidad de productos agregados."
    );
    intCantFinal = await I.grabTextFrom(locator.lblCantProd);
    intCantFinal = parseInt(intCantFinal);
    assert(this.Cantidad == intCantFinal - intCantInicio);

    //Código opcional
    I.moveCursorTo(locator.lblCarritoCompras);
    textoCarrito = await I.grabTextFrom(locator.lblContenedorItems);
  }
};
