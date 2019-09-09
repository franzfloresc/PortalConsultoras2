const I = actor();
let wait = { retries: 5, minTimeout: 2000 };
const config= require('./Landing.locator');
let locator=config.locator;

module.exports={

    Constructor(){
        this.locator=config.locator;
        I.retry(wait).seeInCurrentUrl('/ArmaTuPack/Detalle');
        I.retry(wait).seeElement(locator.seccionSeleccionados);
    },

    Constructor(Producto){
        this.locator=config.locator;
        this.Producto=Producto;
    },

    async AgregarElemento(seccion){
        var cantidad=0;
        I.scrollTo(locator.Elemento(seccion,this.Producto));
        do{
            I.click(locator.Elemento(seccion,this.Producto));
            I.wait(1);
            cantidad=await I.grabNumberOfVisibleElements(locator.elementoAgregado(this.Producto));
        }while(cantidad==0);
    },
    
    AgregarPack(){
        I.wait(1);
        I.click(locator.btnAgregar);
    },

    irContenedor(){
        I.click(locator.btncontenedor);
    }
}