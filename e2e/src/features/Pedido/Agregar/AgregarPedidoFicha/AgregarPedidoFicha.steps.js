const login = require("../../../../pages/Login/Login.module");
const home = require("../../../../pages/Home/Home.module");
const contenedor = require("../../../../pages/Contenedor/Contenedor.module");
const ficha=require('../../../../pages/FichaProducto/FichaProducto.module')
const pedido = require("../../../../pages/Pedido/Pedido.module");

Given('Realizo login en el pais {string} con mi usuario {string} y mi password {string}', function(Pais, Usuario, Password){
    login.Constructor(Pais,Usuario,Password);
    login.LoginPage();
});

When('Me encuentro en la seccion {string}', async function(Seccion){
    await login.SiPopUp_Cerrar();
    login.ValidacionFinalLogin();
});

When("Me dirijo al contenedor de Palancas", async function() {
    home.Constructor();
    await home.irContenedor();
});

Then("En el contenedor en la seccion {string} ingresar a la ficha del cuv {string} y agregar {string} cuvs", 
    async function(Seccion, CUVS, Cantidades) {
    
    var listaCUVS = CUVS.split(",");
    var listaCantidades = Cantidades.split(",");

    for (i = 0; i < listaCUVS.length; i++) {
        listaCUVS[i] = listaCUVS[i].trim();
        listaCantidades[i] = listaCantidades[i].trim();

        pedido.guardarValorEsperado(listaCantidades[i]);
        contenedor.Constructor(Seccion, listaCUVS[i], listaCantidades[i]);
        ficha.Constructor(listaCantidades[i]);

        await pedido.capturarCantInicial();
        await contenedor.ValidacionContenedor();
        await contenedor.BuscarElemento();
        contenedor.VerDetalleElemento();
        ficha.AgregarCantidadFicha();
        ficha.AgregarElementoFicha();
        pedido.ValidacionMsjProdAdd();

        await ficha.VolverContenedor();
        await pedido.capturarCantFinal();
        pedido.ValidacionCantCarrito();

    }      
});  

Then('Ir a ficha de cuvs {string} desde la seccion {string} y agregar {string} del cuv', async function(CUVS,Seccion,Cantidades){
    var listaCUVS=CUVS.split(',');
    var listaCantidades=Cantidades.split(',');
    
    for(i=0;i<listaCUVS.length;i++){

        home.Constructor2(Seccion,listaCUVS[i]);
        ficha.Constructor(listaCantidades[i]);
        pedido.guardarValorEsperado(listaCantidades[i]);

        await pedido.capturarCantInicial();
        await home.BuscarElemento();
        home.VerDetalleElemento();

        ficha.ValidacionFicha();
        await ficha.AgregarCantidadFicha();
        await ficha.AgregarElementoFicha();
        pedido.ValidacionMsjProdAdd();
        
        await ficha.VolverHome();
        await pedido.capturarCantFinal();
        pedido. ValidacionCantCarrito();
    }
});

Then('Ingresar a pase pedido', async function(){
      pedido.irPasePedido();
      await pedido.vaciarPasePedido();
});
