const I = actor();
let wait = { retries: 5, minTimeout: 2000 };
const config = require("./Home.locator");
let locator = config.locator;
let locatorSeccion = "";

module.exports = {
  /**
   * Constructor de clase para sección Home.
   */
  Constructor(Seccion, CUV, Cantidad) {
    this.locator = config.locator;
    this.Seccion = Seccion;
    this.CUV = CUV;
    this.Cantidad = Cantidad;
  },

  /**
   * Validación inicial de URL.
   */
  async ValidacionHome() {
    I.seeInCurrentUrl("/Bienvenida");
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

  async AgregarElemento() {
    for (var i = 1; i < this.Cantidad; i++) {
      //El carrito ya parte de 1 elemento.
      I.click(locator.btnSubirCant(locatorSeccion.xpath, this.CUV));
      I.wait(1);
    }
    await I.click(locator.btnAgregar(locatorSeccion.xpath, this.CUV));
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
