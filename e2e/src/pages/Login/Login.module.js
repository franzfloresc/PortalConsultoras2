const I = actor();
const config = require("./Login.locator");
const utils=require("./../../utils/utils");
let wait = { retries: 5, minTimeout: 2000 };
let locator = config.locator;

module.exports = {
  Constructor() {
    I.retry(wait).amOnPage("/");
    this.locator = config.locator;
  },

  LoginPage(Pais, Usuario, Password) {
    this.ValidacionInicialLogin();
    this.IngresarCredenciales(Pais, Usuario, Password);
    this.ClickBotonLogin();
    this.ValidacionFinalLogin();
  },

  ValidacionInicialLogin() {

    var archivo=utils.nomFichero("Login");
    var ruta="./../report/".concat(archivo);

    I.retry(wait).say("Validación inicial antes del Login");
    I.retry(wait).see("¡Bienvenida");
    I.retry(wait).seeElement(locator.listPais);
    I.retry(wait).seeElement(locator.fieldUsuario);
    I.retry(wait).seeElement(locator.fieldContrasenia);
    I.retry(wait).seeElement(locator.btnLogin);
    I.retry(wait).seeElement(locator.btnLoginFB);

    I.saveScreenshot(archivo);
    I.addMochawesomeContext(ruta);
  },

  /**
   * Método que setea el país y las credenciales de la consultora
   * @param {*} Pais
   * @param {*} Usuario
   * @param {*} Password
   */
  IngresarCredenciales(Pais, Usuario, Password) {
    I.retry(wait).say("Ingresando las credenciales para el Login");
    I.retry(wait).selectOption(locator.listPais, Pais);
    I.retry(wait).fillField(locator.fieldUsuario, Usuario);
    I.retry(wait).fillField(locator.fieldContrasenia, Password);
  },

  ClickBotonLogin() {
    I.retry(wait).say("Dando click al botón Login");
    I.retry(wait).click(locator.btnLogin);
  },

  ValidacionFinalLogin() {
    I.retry(wait).say(
      "Validando que nos encontramos en la ventana de bienvenida"
    );
    I.retry(wait).seeInCurrentUrl("/Bienvenida");
  },

  async SiPopUp_Cerrar() {
    let flagShowRoom = await I.grabValueFrom(locator.fieldIdShowRoomVenta);
    if (flagShowRoom != "") {
      I.retry(wait).click(locator.btnCerrarPopupSR);
    }
  },

  CerrarSesion() {
    I.retry(wait).click(locator.btnLogout);
  }
};
