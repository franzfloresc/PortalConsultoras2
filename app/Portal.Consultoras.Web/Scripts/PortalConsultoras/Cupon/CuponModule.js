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
        PopupCuponGana: '#Cupon1',
        PopupConfirmacion: '#Cupon2',
        PopupGanaste: '#Cupon3',
        ContenedorCuponExclusivo: '#contenedorCupon',
        ContenedorCuponExclusivo2: 'div.content_pedido_cupon_monto',
        ContenedorGana: '#',
        LinkVer: '#linkConocerDescuento',
        LinkVer2: '#linkConocerDescuento2',
        Body: 'body',
        BtnConfirmar: '#',
        TxtCelular: '#Cupon1 #txtCelular',
        TxtCorreoIngresado: '#Cupon1 #txtEmailIngresado',
        HdCorreoOriginal: '#Cupon1 #hdEmailOriginal',
        ContenedorTituloGana: '#Cupon1 .monto_gana',
        ContenedorTituloGanaste: '#Cupon3 .titulo_cupon2',
        ContenedorTexto02Ganaste: '#Cupon3 .texto_cupon2',
        ContenedorTextoDetalleCuponCampania: '#Cupon3 #detalleCuponCampania',
        BtnConfirmarDatos: '#Cupon1 #btnConfirmarDatos',
        BtnModificarDatos: '#Cupon2 #btnModificarDatos',
        BtnEnviarNuevamente: '#Cupon2 #btnEnviarNuevamente',
        ContenedorMostrarCorreo: '#Cupon2 div.correo_confirmacion',
        CheckTerminosCondiciones: '#Cupon1 .termino_condiciones_cupon'
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
        SimboloMoneda: '',
        CampaniaActual: ''
    };

    var inizializer = function (parameters) {
        setting.MostrarContenedorCupon = (parameters.tieneCupon == CONS_CUPON.MOSTRAR_CUPON);
        setting.PaginaOrigen = parseInt(parameters.paginaOrigenCupon);
        setting.EsEmailActivo = (parameters.esEmailActivo.toLowerCase() == "true");
        setting.BaseUrl = parameters.baseUrl;
        setting.SimboloMoneda = parameters.simboloMoneda;
        setting.CampaniaActual = parameters.campaniaActual
        mostrarPopupCuponPorPagina();
        bindEvents();
    }

    var bindEvents = function () {
        $(elements.LinkVer).on("click", function () {
            procesarVerOferta();
        });

        $(elements.LinkVer2).on("click", function () {
            procesarVerOferta();
        });

        $(elements.BtnConfirmarDatos).on("click", function () {
            var aceptoTerCond = $(elements.CheckTerminosCondiciones).hasClass("check_intriga");
            var correoIngresado = $(elements.TxtCorreoIngresado).val().trim();
            var correoOriginal = $(elements.HdCorreoOriginal).val().trim();
            var celular = $(elements.TxtCelular).val().trim();

            if (!aceptoTerCond) {
                AbrirMensaje("Debe aceptar los términos y condiciones", "VALIDACIÓN");
                return false;
            }

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

        $("div#chckTerminosCondiciones").click(function () {
            $(this).toggleClass('check_intriga');
        });
    }

    var procesarVerOferta = function () {
        if (setting.Cupon != null && setting.Cupon != undefined) {
            if (setting.Cupon.EstadoCupon == CONS_CUPON.CUPON_RESERVADO) {
                procesarGana();
            }
            else if (setting.Cupon.EstadoCupon == CONS_CUPON.CUPON_ACTIVO) {
                validarEstadoEmail();
            }
        }
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
                        AbrirMensaje(response.message, "CORREO DE CONFIRMACIÓN");
                    } else {
                        AbrirMensaje(response.message, "MENSAJE DE VALIDACIÓN");
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
        var valor = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.Cupon.FormatoValorAsociado : parseInt(setting.Cupon.FormatoValorAsociado));

        $(elements.ContenedorTituloGana).empty();

        if (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO) {
            $(elements.ContenedorTituloGana).append("<span class='tipo_moneda'>" + simbolo + "</span> " + valor);
        } else {
            $(elements.ContenedorTituloGana).append(valor + " <span class='tipo_moneda'>" + simbolo + "</span> ");
        }

        mostrarPopupGana();
    }

    var mostrarPopupCuponPorPagina = function () {
        if (setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_BIENVENIDA || setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_PEDIDO) {
            
        }

        if (setting.MostrarContenedorCupon) {
            if ($(elements.ContenedorCuponExclusivo2).length > 0) {
                $(elements.ContenedorCuponExclusivo2).show();
            }
            $(elements.ContenedorCuponExclusivo).show();
        } else {
            $(elements.ContenedorCuponExclusivo).hide();
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
            AbrirMensaje("Debe ingresar su correo actual", "VALIDACIÓN");
            return false;
        }
        if (emailIngresado == "") {
            AbrirMensaje("Debe ingresar su correo", "VALIDACIÓN");
            return false;
        }
        if (celular == "") {
            AbrirMensaje("Debe ingresar su número celular", "VALIDACIÓN");
            return false;
        }
        return true;
    }

    var mostrarPopupGanaste = function () {
        var simbolo = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.SimboloMoneda : "%");
        var valor = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.Cupon.FormatoValorAsociado : parseInt(setting.Cupon.FormatoValorAsociado));
        var campania = setting.CampaniaActual.substring(4);

        $(elements.ContenedorTituloGanaste).empty();
        if (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO) {
            $(elements.ContenedorTituloGanaste).append("¡GANASTE TU CUPÓN DE DSCTO DE " + simbolo + " " + valor + "!");
        } else {
            $(elements.ContenedorTituloGanaste).append("¡GANASTE TU CUPÓN DE DSCTO DE " + valor + " " + simbolo + "!");
        }
        
        $(elements.ContenedorTexto02Ganaste).empty();
        $(elements.ContenedorTexto02Ganaste).append("Debes agregar alguna oferta en web* en la campaña C" + campania);
        $(elements.ContenedorTextoDetalleCuponCampania).empty();
        $(elements.ContenedorTextoDetalleCuponCampania).append("Sólo válido en la campaña C" + campania);
        $(elements.PopupGanaste).show();
        $(elements.PopupCuponGana).hide();
        $(elements.PopupConfirmacion).hide();
    }

    var mostrarPopupGana = function () {
        $(elements.PopupCuponGana).show();
        $(elements.PopupGanaste).hide();
        $(elements.PopupConfirmacion).hide();
    }

    var mostrarPopupConfirmacion = function () {
        var correoIngresado = $(elements.TxtCorreoIngresado).val().trim();
        $(elements.ContenedorMostrarCorreo).empty();
        $(elements.ContenedorMostrarCorreo).append(correoIngresado);
        $(elements.PopupCuponGana).hide();
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