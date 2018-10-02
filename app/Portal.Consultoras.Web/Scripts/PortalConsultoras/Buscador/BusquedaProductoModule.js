var BusquedaProductoModule = (function () {

   var _elementos = {
        body: "body"
        
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        
    };
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
         
        },
        CargarProductos: function() {
            
        }
    };
    var _eventos = {
        Ordenar: function () {
           
        }
    };


    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
    }
    
    function MostrarProductos() {
        console.log("Scroll page");
    }

    return {
        Inicializar: Inicializar,
        MostrarProductos: MostrarProductos
    };
})();

$(document).ready(function () {

    BusquedaProductoModule.Inicializar();

    $(window).scroll(function () {
        BusquedaProductoModule.MostrarProductos();
    });

    $(window).scroll();
});