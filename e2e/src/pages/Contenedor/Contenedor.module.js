const I = actor();
const config = require("./Contenedor.locator");
const utils=require("./../../utils/utils");
let wait = { retries: 5, minTimeout: 2000 };
let locator = config.locator;
let locatorSeccion = "";

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

  ValidacionContenedor() {
    var archivo=utils.nomFichero("Contenedor");
    var ruta="./../report/".concat(archivo);
    I.seeInCurrentUrl("fertas");
    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);
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

  VerDetalleElemento(){
    I.wait(1);
    I.click(locator.btnVerDetalle(this.Seccion, this.CUV));
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
    for (var i = 1; i < this.Cantidad; i++) {//El carrito ya parte de 1 elemento.
      I.click(locator.btnSubirCant(this.Seccion, this.CUV));
      I.wait(1);
    }
    var archivo=utils.nomFichero("Contenedor");
    var ruta="./../report/".concat(archivo);
    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);

    I.click(locator.btnAgregar(this.Seccion, this.CUV));
  },

  IrALandingATP(){ 
    I.retry(wait).click(locator.btnIrATP);
    I.retry(wait).seeInCurrentUrl('/ArmaTuPack/Detalle');
  }

};
