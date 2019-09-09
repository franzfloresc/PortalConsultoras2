
config = {

    locator: {
        
        botonAgregarFP:{
            xpath:"//div[@id='dvContenedorAgregar']/a[@id='btnAgregalo']"
        },

        botonCantidadFP:{
            xpath:"//a[@class='txt_mas']"
        },

        btnIrContenedor:{
            xpath:"//a[@id='lnk-pri-ofertas']"
        },

        regresoHome:{
            xpath:"//section/picture[contains(@class,'d-block')]"
        }
    }
}
  
module.exports.config=config;
module.exports.locator=config.locator;
  