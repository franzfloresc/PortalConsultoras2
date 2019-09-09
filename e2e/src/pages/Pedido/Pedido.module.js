const I = actor();
const config = require("./Pedido.locator");
const assert = require("assert");
const utils=require("./../../utils/utils");
let wait = { retries: 5, minTimeout: 2000 };
let locator = config.locator;
let intCantIni = 0;
let intCantFin = 0;
let intValorEsperado = 0;

module.exports = {
  Constructor() {
    this.locator = config.locator;
  },

  ValidacionMsjProdAdd() {

    I.retry(wait).say(
      "Se validará que haya aparecido el popup de Producto Agregado"
    );
    I.retry(wait).seeElement(locator.popupAgregado);
    var archivo=utils.nomFichero("ProductoAgregado");
    var ruta="./../report/".concat(archivo);
    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);
    I.retry(wait).dontSeeElement(locator.popupAgregado);

  },

  irPasePedido() {
    I.moveCursorTo(locator.lblCarritoCompras);
    I.retry(wait).click(locator.btnIrVerPedido);
  },

  async vaciarPasePedido() {
    var contenido="";

    I.wait(1);
    var archivo=utils.nomFichero("PasePedido");
    var ruta="./../report/".concat(archivo);
    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);

    do{

      I.retry(wait).click(locator.btnEliminarPedido);
      contenido=await I.grabCssPropertyFrom(
        locator.popupEliminarPedido,"display"
      );

    }while((contenido[0])=="none");

    I.retry(wait).click(locator.btnEliminarSi);
  },

  guardarValorEsperado(valor) {
    intValorEsperado = valor;
    intValorEsperado = parseInt(intValorEsperado);
  },

  async capturarCantInicial() {
    intCantIni = await I.grabTextFrom(locator.lblCantProd);
    intCantIni = parseInt(intCantIni);
  },

  async capturarCantFinal() {
    intCantFin = await I.grabTextFrom(locator.lblCantProd);
    intCantFin = parseInt(intCantFin);
  },

  ValidacionCantCarrito() {
    assert(intValorEsperado == (intCantFin - intCantIni));
  }
};
