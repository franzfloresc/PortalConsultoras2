var cuponModule = (function () {
    "use strict"

    var CONS_CUPON = {
        NO_MOSTRAR_CUPON: 0,
        MOSTRAR_CUPON: 1,
        CUPON_RESERVADO: 1,
        CUPON_ACTIVO: 2,
        TIPO_CUPON_MONTO: 'MONTO',
        TIPO_CUPON_PORCENTAJE: 'PORCENTAJE'
    };

    var CONS_PAGINA_ORIGEN = {
        DESKTOP_BIENVENIDA: 1,
        MOBILE_BIENVENIDA: 2,
        DESKTOP_PEDIDO: 11,
        MOBILE_PEDIDO: 21,
    };
    
    var elements = {
        PopupCuponPaginaBienvenida: '#Cupon1',
        ContenedorConfirmacion: '#',
        ContenedorGanaste: '#',
        ContenedorGana: '#',
        LinkVer: '#linkConocerDescuento',
        Body: 'body',
        BtnConfirmar: '#',
        TxtCorreoIngresado: '#',
        HdCorreoOriginal: '#',
        ContenedorTituloGana: '#Cupon1 .monto_gana'
    };

    var setting = {
        MostrarContenedorCupon: false,
        PaginaOrigen: 0,
        EsEmailActivo: false,
        BaseUrl: '',
        UrlActualizarCupon: 'Cupon/ActualizarCupon',
        UrlEnviarCorreoGanaste: '',
        UrlEnviarCorreoConfirmacion: '',
        UrlObtenerCupon: 'Cupon/ObtenerCupon',
        Cupon: null,
        SimboloMoneda:''
    };

    var bindEvents = function () {
        $(elements.LinkVer).on("click", function () {
            if (setting.Cupon != null && setting.Cupon != undefined) {
                if (setting.Cupon.EstadoCupon == CONS_CUPON.CUPON_RESERVADO) {
                    procesarGana();
                }
                else if (setting.Cupon.EstadoCupon == CONS_CUPON.CUPON_ACTIVO) {
                    validarEstadoEmail();
                }
            }
        });

        $(elements.BtnConfirmar).on("click", function () {
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
        var model = { estado: CONS_CUPON.CUPON_ACTIVO };// Actualizar Estado cupon a 2 (Activo)
        var cuponPromise = actualizarCuponPromise(model);
        cuponPromise.then(function (response) {
            var result = response;// Enviar correo de confirmación cambio de email
        }, function (xhr, status, error) {});
    }

    var procesarGanaste = function () {
        $(elements.ContenedorGanaste).show();
        var model = { estado: CONS_CUPON.CUPON_ACTIVO };// Actualizar Estado cupon a 2 (Activo)
        var cuponPromise = actualizarCuponPromise(model);
        cuponPromise.then(function (response) {
            var result = response;// Enviar correo "Ganaste"
        }, function (xhr, status, error) {});
    }

    var procesarGana = function () {
        var simbolo = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.SimboloMoneda : "%");
        $(elements.ContenedorTituloGana).empty();
        $(elements.ContenedorTituloGana).append("<span class='tipo_moneda'>" + simbolo + "</span> " + setting.Cupon.FormatoValorAsociado);
        $(elements.PopupCuponPaginaBienvenida).show();
    }

    var inizializer = function (parameters) {
        setting.MostrarContenedorCupon = (parameters.tieneCupon == CONS_CUPON.MOSTRAR_CUPON);
        setting.PaginaOrigen = parseInt(parameters.paginaOrigenCupon);
        setting.EsEmailActivo = (parameters.esEmailActivo.toLowerCase() == "true");
        setting.BaseUrl = parameters.baseUrl;
        setting.SimboloMoneda = parameters.simboloMoneda;
        mostrarContenedorCuponPorPagina();
        bindEvents();
    }

    var mostrarContenedorCuponPorPagina = function () {
        if (setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_BIENVENIDA || setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_PEDIDO) {
            if (setting.MostrarContenedorCupon) {
                $(elements.PopupCuponPaginaBienvenida).show();
            } else {
                $(elements.PopupCuponPaginaBienvenida).hide();
            }
        }
    }

    var obtenerCupon = function () {
        var cuponPromise = obtenerCuponPromise();
        cuponPromise.then(function (response) {
            setting.Cupon = response.data;
        }, function (xhr, status, error) {
            console.log(xhr.responseText);
        });
    }

    var actualizarCuponPromise = function (estadoCupon) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.BaseUrl + setting.UrlActualizarCupon,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(estadoCupon),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    var enviarCorreoGanasteCuponPromise = function (model) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.BaseUrl + setting.UrlEnviarCorreoGanaste,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(model),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    var enviarCorreoConfirmacionCuponPromise = function (model) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.BaseUrl + setting.UrlEnviarCorreoConfirmacion,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(model),
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    var obtenerCuponPromise = function () {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'GET',
            url: setting.BaseUrl + setting.UrlObtenerCupon,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    }

    return {
        ini: function (parameters) {
            inizializer(parameters);
        },
        obtenerCupon: obtenerCupon
    };
})();