const login = require("../../../../pages/Login/Login.module");
const contenedor = require("../../../../pages/Contenedor/Contenedor.module");
const home = require("../../../../pages/Home/Home.module");
const pedido = require("../../../../pages/Pedido/Pedido.module");

Given(
  "Realizo login en el pais {string} con mi usuario {string} y mi password {string} para ir al Contenedor",
  async function(Pais, Usuario, Password) {
    login.Constructor();
    await login.LoginPage(Pais, Usuario, Password);
  }
);

When("Me dirijo al contenedor de Palancas", async function() {
  home.Constructor();
  await home.irContenedor();
});

When(
  "En el Contenedor me encuentro en la seccion {string}, buscare agregar {int} unidades del cuv {string}",
  async function(Seccion, Cantidad, CUV) {
    pedido.Constructor();
    pedido.guardarValorEsperado(Cantidad);
    contenedor.Constructor(Seccion, CUV, Cantidad);
    await contenedor.ValidacionContenedor();
    contenedor.IrASeccion();
  }
);

When(
  "En el Contenedor agrego un cuv, para la seccion buscada",
  async function() {
    await pedido.capturarCantInicial();
    await contenedor.BuscarElemento();
    contenedor.AgregarElemento();
    await pedido.ValidacionMsjProdAdd();
    await pedido.capturarCantFinal();
    pedido.ValidacionCantCarrito();
  }
);

Then(
  "En el Contenedor visualizare en mi carrito el producto agregado",
  async function() {
    //await contenedor.ValidacionCantCarrito();
  }
);

Then(
  "En el Contenedor agrego varios cuvs {string}, {string} veces de la seccion {string}",
  async function(CUVS, Cantidades, Seccion) {
    var listaCUVS = CUVS.split(",");
    var listaCantidades = Cantidades.split(",");

    for (i = 0; i < listaCUVS.length; i++) {
      listaCUVS[i] = listaCUVS[i].trim();
      listaCantidades[i] = listaCantidades[i].trim();
      pedido.guardarValorEsperado(listaCantidades[i]);
      contenedor.Constructor(Seccion, listaCUVS[i], listaCantidades[i]);
      await contenedor.ValidacionContenedor();
      pedido.capturarCantInicial();
      await contenedor.BuscarElemento();
      contenedor.AgregarElemento();
      await pedido.ValidacionMsjProdAdd();
      await pedido.capturarCantFinal();
      pedido.ValidacionCantCarrito();
    }
  }
);

Then("Ingresar a pase pedido del Contenedor", async function() {
  await pedido.irPasePedido();
  pedido.vaciarPasePedido();
});
