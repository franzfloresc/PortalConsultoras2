var cuponModule = (function () {
    "use strict"

    var CONS_CUPON = {
        NO_MOSTRAR_CUPON: 0,
        MOSTRAR_CUPON: 1,
        CUPON_RESERVADO: 1,
        CUPON_ACTIVO: 2
    };

    var CONS_PAGINA_ORIGEN = {
        DESKTOP_BIENVENIDA: 1,
        MOBILE_BIENVENIDA: 2,
        DESKTOP_PEDIDO: 11,
        MOBILE_PEDIDO: 21,
    };
    
    var elements = {
        ContenedorCuponPaginaBienvenida: '#contenedorCupon',
        ContenedorConfirmacion: '#',
        ContenedorGanaste: '#',
        ContenedorGana: '#',
        PopupCuponPaginaBienvenida: '#Id2',
        LinkVer: '#linkConocerDescuento',
        Body: 'body',
        
        BtnConfirmar: '#',
        TxtCorreoIngresado: '#',
        HdCorreoOriginal: '#'
    };

    var setting = {
        MostrarContenedorCupon: false,
        PaginaOrigen: 0,
        EsEmailActivo: false,
        CodigoCupon: 0
    };

    var bindEvents = function () {
        $(elements.Body).on("click", elements.LinkVer, function (e) {
            if (setting.CodigoCupon == CONS_CUPON.CUPON_RESERVADO) {
                procesarGana();
            }
            else if (setting.CodigoCupon == CONS_CUPON.CUPON_ACTIVO) {
                validarEstadoEmail();
            }
        });

        $(elements.Body).on("click", elements.BtnConfirmar, function (e) {
            var correoIngresado = $(elements.TxtCorreoIngresado).val().trim();
            var correoOriginal = $(elements.HdCorreoOriginal).val().trim();

            if (correoIngresado == correoOriginal) {
                validarEstadoEmail();
            } else {
                procesarConfirmacion();
            }
        });
    }

    var validarEstadoEmail = function () {
        if (setting.EsEmailActivo) {
            procesarGanaste();
        } else {
            procesarConfirmacion();
        }
    }

    var procesarConfirmacion = function () {
        $(elements.ContenedorConfirmacion).show();
        // Enviar correo de confirmación cambio de email
        // Actualizar Estado cupon a 2 (Activo)
    }

    var procesarGanaste = function () {
        $(elements.ContenedorGanaste).show();
        // Actualizar Estado cupon a 2 (Activo)
        // Enviar correo "Ganaste"
    }

    var procesarGana = function () {
        $(elements.ContenedorGana).show();
    }

    var inizializer = function (parameters) {
        setting.MostrarContenedorCupon = (parameters.tieneCupon == CONS_CUPON.MOSTRAR_CUPON);
        setting.CodigoCupon = parseInt(parameters.codigoCupon);
        setting.PaginaOrigen = parseInt(parameters.paginaOrigenCupon);
        setting.EsEmailActivo = (parameters.esEmailActivo.toLowerCase() == "true");
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