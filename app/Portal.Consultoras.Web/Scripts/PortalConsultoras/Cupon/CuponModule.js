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
        PopupConfirmacion: '#Cupon2',
        PopupGanaste: '#',
        ContenedorCuponExclusivo: '#contenedorCupon',
        ContenedorGana: '#',
        LinkVer: '#linkConocerDescuento',
        Body: 'body',
        BtnConfirmar: '#',
        TxtCelular: '#Cupon1 #txtCelular',
        TxtCorreoIngresado: '#Cupon1 #txtEmailIngresado',
        HdCorreoOriginal: '#Cupon1 #hdEmailOriginal',
        ContenedorTituloGana: '#Cupon1 .monto_gana',
        BtnConfirmarDatos: '#Cupon1 .btn_confirma_cupon',
        BtnModificarDatos: '#Cupon2 #btnModificarDatos',
        BtnEnviarNuevamente: '#Cupon2 #btnEnviarNuevamente'
    };

    var setting = {
        MostrarContenedorCupon: false,
        PaginaOrigen: 0,
        EsEmailActivo: false,
        BaseUrl: '',
        UrlActualizarCupon: 'Cupon/ActualizarCupon',
        UrlEnviarCorreoGanaste: '',
        UrlEnviarCorreoConfirmacionEmail: 'Cupon/EnviarCorreoConfirmacionEmail',
        UrlObtenerCupon: 'Cupon/ObtenerCupon',
        Cupon: null,
        SimboloMoneda: ''
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

        $(elements.BtnConfirmarDatos).on("click", function () {
            var correoIngresado = $(elements.TxtCorreoIngresado).val().trim();
            var correoOriginal = $(elements.HdCorreoOriginal).val().trim();
            var celular = $(elements.TxtCelular).val().trim();
            if (confirmarDatosEsValido(correoOriginal, correoIngresado, celular)) {
                if (correoIngresado == correoOriginal) {
                    validarEstadoEmail();
                } else {
                    procesarConfirmacion();
                }
            }
        });

        $(elements.BtnModificarDatos).on("click", function () {
            mostrarPopupGana();
        });

        $(elements.BtnEnviarNuevamente).on("click", function () {
            AbrirMensaje("Enviando correo de confirmación nuevamente...", "CORREO DE CONFIRMACIÓN");
            var model = {
                eMailNuevo: $(elements.TxtCorreoIngresado).val().trim(),
                celular: $(elements.TxtCelular).val().trim()
            };
            var confirmacionPromise = enviarCorreoConfirmacionEmailPromise(model);

            confirmacionPromise.then(function (response) {
                if (response.success) {
                    AbrirMensaje(response.message, "CORREO DE CONFIRMACIÓN");
                } else {
                    AbrirMensaje(response.message, "MENSAJE DE VALIDACIÓN");
                }
            }, function (xhr, status, error) { });
        });
    }

    var validarEstadoEmail = function () {
        if (setting.EsEmailActivo) {
            procesarGanaste();
        } else {
            mostrarPopupConfirmacion();
        }
    }

    var procesarConfirmacion = function () {
        mostrarPopupConfirmacion();
        var cuponPromise = actualizarCuponPromise();

        cuponPromise.then(function (response) {
            if (response.success) {
                var model = {
                    eMailNuevo: $(elements.TxtCorreoIngresado).val().trim(),
                    celular: $(elements.TxtCelular).val().trim()
                };
                var confirmacionPromise = enviarCorreoConfirmacionEmailPromise(model);
                obtenerCupon();
                confirmacionPromise.then(function (response) {
                    if (response.success) {

                    } else {
                        alert(response.message);

                    }
                }, function (xhr, status, error) { });
            }
        }, function (xhr, status, error) {});
    }

    var procesarGanaste = function () {
        mostrarPopupGanaste();

        if (!setting.Cupon.CorreoGanasteEnviado) {
            
            var cuponPromise = actualizarCuponPromise();

            cuponPromise.then(function (response) {
                if (response.success) {
                    AbrirMensaje(response.message, "CUPÓN");
                    obtenerCupon();
                }
            }, function (xhr, status, error) { });
        }
    }

    var procesarGana = function () {
        var simbolo = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.SimboloMoneda : "%");
        $(elements.ContenedorTituloGana).empty();
        $(elements.ContenedorTituloGana).append("<span class='tipo_moneda'>" + simbolo + "</span> " + setting.Cupon.FormatoValorAsociado);
        mostrarPopupGana();
    }

    var inizializer = function (parameters) {
        setting.MostrarContenedorCupon = (parameters.tieneCupon == CONS_CUPON.MOSTRAR_CUPON);
        setting.PaginaOrigen = parseInt(parameters.paginaOrigenCupon);
        setting.EsEmailActivo = (parameters.esEmailActivo.toLowerCase() == "true");
        setting.BaseUrl = parameters.baseUrl;
        setting.SimboloMoneda = parameters.simboloMoneda;
        mostrarPopupCuponPorPagina();
        bindEvents();
    }

    var mostrarPopupCuponPorPagina = function () {
        if (setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_BIENVENIDA || setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_PEDIDO) {
            if (setting.MostrarContenedorCupon) {
                $(elements.ContenedorCuponExclusivo).show();
            } else {
                $(elements.ContenedorCuponExclusivo).hide();
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

    var actualizarCuponPromise = function () {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.BaseUrl + setting.UrlActualizarCupon,
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

    var enviarCorreoConfirmacionEmailPromise = function (model) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.BaseUrl + setting.UrlEnviarCorreoConfirmacionEmail,
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

    var confirmarDatosEsValido = function (emailOriginal, emailIngresado, celular) {
        if (emailOriginal == "") {
            alert("debe ingresar su correo(original)");
            return false;
        }
        if (emailIngresado == "") {
            alert("debe ingresar su correo(ingresado)");
            return false;
        }
        if (celular == "") {
            alert("debe ingresar su número celular");
            return false;
        }
        return true;
    }

    var mostrarPopupGanaste = function () {
        $(elements.PopupGanaste).show();
        $(elements.PopupCuponPaginaBienvenida).hide();
        $(elements.PopupConfirmacion).hide();
    }

    var mostrarPopupGana = function () {
        $(elements.PopupCuponPaginaBienvenida).show();
        $(elements.PopupGanaste).hide();
        $(elements.PopupConfirmacion).hide();
    }

    var mostrarPopupConfirmacion = function () {
        $(elements.PopupCuponPaginaBienvenida).hide();
        $(elements.PopupConfirmacion).show();
    }

    return {
        ini: function (parameters) {
            inizializer(parameters);
        },
        obtenerCupon: obtenerCupon,
        mostrarObjetoCupon: function () {
            return setting.Cupon;
        }
    };
})();