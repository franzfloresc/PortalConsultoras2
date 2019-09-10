const I = actor();
let wait = { retries: 5, minTimeout: 2000 };
const config= require('./FichaProducto.locator');
let locator=config.locator; 

module.exports = {

    Constructor(){
        this.locator=config.locator;
    },

    /**
     * Constructor de clase para sección Home.
     */
    Constructor(Cantidad){
        this.locator=config.locator; 
        this.Cantidad=Cantidad;
    },
    
    /**
     * Validación inicial de URL.
     */
    ValidacionFicha(){
        I.seeInCurrentUrl("Detalles");
    },

    AgregarCantidadFicha(){
        console.log("Ingresamos a AgregarCantidadFicha...", this.Cantidad);
        for(var i=1;i<this.Cantidad;i++){//El carrito ya parte de 1 elemento.
            I.retry(wait).click(locator.botonCantidadFP);
            I.wait(1);
        }  
    },

    AgregarElementoFicha(){
        I.retry(wait).click(locator.botonAgregarFP);
    },

    async VolverHome(){
        let url="";
        do{
            I.retry(wait).click(locator.regresoHome);
            I.wait(1);
            url=await I.grabCurrentUrl();
        }while(url.includes("Detalles"));
    },

    async VolverContenedor(){
        let url='';
        do{
            I.retry(wait).click(locator.btnIrContenedor);
            I.wait(1);
            url=await I.grabCurrentUrl();
        }while(url.includes("Detalles"));
    }
}