const login = require("./../../pages/Login/Login.module");

const I = actor();

Given("Ingreso el {string}  mi {string} y mi {string}", async function(
  Pais,
  Usuario,
  Password
) {
  login.Constructor();
  login.ValidacionInicialLogin();
  this.Pais = Pais;
  this.Usuario = Usuario;
  this.Password = Password;
  login.IngresarCredenciales(this.Pais, this.Usuario, this.Password);
});

When('click en el boton "Ingresa a tu cuenta"', function() {
  login.ClickBotonLogin();
});

Then(
  "puedo ver mi estado de cuenta, mis ganancias e ingresar mi pedido",
  async function() {
    login.ValidacionFinalLogin();
    await login.SiPopUp_Cerrar();
  }
);

Then("cierro la sesion", function() {
  login.CerrarSesion();
});
