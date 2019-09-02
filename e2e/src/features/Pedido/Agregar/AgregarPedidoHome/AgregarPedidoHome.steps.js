const login = require("../../../../pages/Login/Login.module");
const home = require("../../../../pages/Home/Home.module");
const pedido = require("../../../../pages/Pedido/Pedido.module");

Given(
  "Realizo login en el pais {string} con mi usuario {string} y mi password {string}",
  async function(Pais, Usuario, Password) {
    login.Constructor();
    await login.LoginPage(Pais, Usuario, Password);
  }
);

When("Me encuentro en la seccion indicada", async function() {});

When(
  "Agrego un cuv {string}, {int} veces de la seccion {string}",
  async function(CUV, Cantidad, Seccion) {
    home.Constructor(Seccion, CUV, Cantidad);
    pedido.Constructor();
    pedido.guardarValorEsperado(Cantidad);
    await pedido.capturarCantInicial();
    await home.BuscarElemento();
    await home.AgregarElemento();
    await pedido.ValidacionMsjProdAdd();
    await pedido.capturarCantFinal();
    pedido.ValidacionCantCarrito();
  }
);

When(
  "Agrego varios cuvs {string}, {string} veces de la seccion {string}",
  async function(CUVS, Cantidades, Seccion) {
    var listaCUVS = CUVS.split(",");
    var listaCantidades = Cantidades.split(",");
    pedido.Constructor();

    for (i = 0; i < listaCUVS.length; i++) {
      home.Constructor(Seccion, listaCUVS[i], listaCantidades[i]);
      await home.BuscarElemento();
      pedido.guardarValorEsperado(listaCantidades[i]);
      await pedido.capturarCantInicial();
      await home.AgregarElemento();
      await pedido.ValidacionMsjProdAdd();
      await pedido.capturarCantFinal();
      pedido.ValidacionCantCarrito();
    }
  }
);

Then("Visualizare en mi carrito los productos que agregue", async function() {
  //await home.ValidacionCantCarrito();
});

Then("Ingresar a pase pedido", async function() {
  await pedido.irPasePedido();
  pedido.vaciarPasePedido();
});
