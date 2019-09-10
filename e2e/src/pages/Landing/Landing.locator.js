
config = {
    locator: {
        seccionLanding:(nro)=>{return {xpath:`//div[@id='grupos']/section[${nro}]`};},
        elementoAgregado:(cuv)=>{return {xpath:`//div[@id='seleccionados']//button[@data-cuv-componente='${cuv}']`};},
        Elemento:(nro,cuv)=>{ return {xpath:`//div[@id='grupos']/section[${nro}]//button[@data-cuv-componente='${cuv}']`};},
        seccionSeleccionados:{xpath:"//div[@id='seleccionados']"},
        btncontenedor: {xpath:'//*[@id="lnk-pri-ofertas"]/img'},
        btnAgregar: {xpath:"//*[@id='btnAgregalo']"},
    }
}
module.exports.config=config;
module.exports.locator=config.locator;