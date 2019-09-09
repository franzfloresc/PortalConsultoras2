const I = actor();
const config = require("./Home.locator");
const utils=require("./../../utils/utils");
let wait = { retries: 5, minTimeout: 2000 };
let locator = config.locator;
let locatorSeccion = "";

module.exports = {

  Constructor(){
    this.locator=config.locator;
    console.log("constructor vacio");
  },

  Constructor3(Seccion, CUV, Cantidad) {    
    this.locator = config.locator;
    this.Seccion = Seccion;
    this.CUV = CUV;
    this.Cantidad = Cantidad;
},

  Constructor2(Seccion, CUV){
    this.locator=config.locator; 
    this.Seccion=Seccion;
    this.CUV=CUV;
  },

  /**
   * Validación inicial de URL.
   */
  ValidacionHome() {
    var archivo=utils.nomFichero("Home");
    var ruta="./../report/".concat(archivo);
    I.seeInCurrentUrl("/Bienvenida");
    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);
  },

  /**
   * Método que guarda el locator según la sección pasada como parámetro.
   * @param {*} Seccion parámetro que indica la Seccion
   */
  //AsignarSeccion(Seccion){
  AsignarSeccion() {
    switch (this.Seccion) {
      case "Dorada":
        locatorSeccion = locator.secContenedorDorado;
        break;
      default:
        locatorSeccion = locator.secContenedorDorado;
    }
  },

  /**
   * Método que busca un cuv dentro de la sección especificada,
   * de no encontrarla en la sección visible,
   * dará click en las flechas laterales para visualizar las otras ofertas y continuar con la búsqueda
   * En caso no encuentre el cuv buscado, mostrará un mensaje de error y terminará la ejecución.
   * @param {*} Seccion Sección en la que se buscará el cuv.
   * @param {*} CUV Oferta a encontrar
   */
  //async BuscarElemento(Seccion,CUV){
  async BuscarElemento() {
    var contenido = "";
    this.AsignarSeccion(this.Seccion);
    I.scrollTo(locatorSeccion);
    I.seeElement(locator.Elemento(locatorSeccion.xpath, this.CUV));
    do {
      contenido = await I.grabAttributeFrom(
        locator.Elemento(locatorSeccion.xpath, this.CUV),
        "aria-hidden"
      );
      I.click(locator.btnDerecha(locatorSeccion.xpath));
    } while (contenido == "true");
  },

  VerDetalleElemento(){
    I.wait(1);
    I.click(locator.btnVerDetalle(locatorSeccion.xpath, this.CUV));
  },
  
  AgregarElemento() {
    console.log("Cantidad: ", this.Cantidad);
    for (var i = 1; i < this.Cantidad; i++) {
      //El carrito ya parte de 1 elemento.
      I.click(locator.btnSubirCant(locatorSeccion.xpath, this.CUV));
      I.wait(1);
    }

    var archivo=utils.nomFichero("AgregandoElemento");
    var ruta="./../report/".concat(archivo);
    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);

    I.click(locator.btnAgregar(locatorSeccion.xpath, this.CUV));
  },

  /**
   * Método que da click sobre el botón Gana+ u Ofertas Digitales
   * dependiendo del tipo de Consultora (Suscrita , No Suscrita).
   */
  async irContenedor() {
    let url = "";
    do {
      I.retry(wait).click(locator.btnIrContenedor);
      I.wait(1);
      url = await I.grabCurrentUrl();
    } while (url.includes("Bienvenida"));
    I.dontSeeElement(locator.secContenedorDorado);
  }
};
