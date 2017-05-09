var cuponModule = (function () {
    "use strict"

    var CONS_CUPON = {
        NO_MOSTRAR_CUPON: 0,
        MOSTRAR_CUPON: 1
    };

    var CONS_PAGINA_ORIGEN = {
        DESKTOP_BIENVENIDA: 1,
        MOBILE_BIENVENIDA: 2,
        DESKTOP_PEDIDO: 11,
        MOBILE_PEDIDO: 21,
    };
    
    var elements = {
        ContenedorCuponPaginaBienvenida: '#contenedorCupon',
        PopupCuponPaginaBienvenida: '#Id2',
        LinkVer: '#linkConocerDescuento',
        Body: 'body'
    };

    var setting = {
        MostrarContenedorCupon: false,
        PaginaOrigen: 0
    };

    var bindEvents = function () {
        $(elements.Body).on("click", elements.LinkVer, function (e) {
            console.log("click");
        });
    }

    var inizializer = function (parameters) {
        setting.MostrarContenedorCupon = (parameters.tieneCupon == CONS_CUPON.MOSTRAR_CUPON);
        setting.PaginaOrigen = parseInt(parameters.paginaOrigenCupon);
        mostrarContenedorCuponPorPagina();
        bindEvents();
    }

    var mostrarContenedorCuponPorPagina = function () {
        if (setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_BIENVENIDA || setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_PEDIDO) {
            if (setting.MostrarContenedorCupon) {
                $(elements.ContenedorCuponPaginaBienvenida).show();
            } else {
                $(elements.ContenedorCuponPaginaBienvenida).hide();
            }
        }
        
    }

    return {
        ini: function (parameters) {
            inizializer(parameters);
        }
    };
})();