const login=require('../../../../pages/Login/Login.module')
const landing=require('../../../../pages/Landing/Landing.module')
const contenedor=require('../../../../pages/Contenedor/Contenedor.module')
const home=require('../../../../pages/Home/Home.module')
const pedido = require("../../../../pages/Pedido/Pedido.module");

Given('Realizo login en el pais {string} con mi usuario {string} y mi password {string}', async function(Pais, Usuario, Password){
    login.Constructor();
    login.LoginPage(Pais,Usuario,Password);
    await login.SiPopUp_Cerrar();
});

When('Me dirijo al contenedor de Palancas', async function(){
    home.Constructor();
    await home.irContenedor();
    contenedor.Constructor();
    contenedor.ValidacionContenedor();
});

When('Me dirijo al landing de Arma tu pack', function(){
    contenedor.IrALandingATP();
});


Then('Puedo agregar los productos deseados {string}', async function(Productos){
    var ListaProductos=Productos.split(',');
      
    for(i=0;i<ListaProductos.length;i++){
        landing.Constructor(ListaProductos[i]);
        await landing.AgregarElemento((i+1));
    }

    landing.AgregarPack();
    
    landing.irContenedor();
    contenedor.ValidacionContenedor();
});

Then('Puedo ir a pase pedido', async function(){
    pedido.irPasePedido();
    await pedido.vaciarPasePedido();
});
