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
        ContenedorPadreCupon: 'div.contenedorCupon',
        ContenedorCuponConocelo: 'div.contenedorCuponConocelo',
        ContenedorCuponInfo: 'div.contenedorCuponInfo',
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
        CheckTerminosCondiciones: '#Cupon1 .termino_condiciones_cupon',
        LinkTerminosCondiciones: '#lnkTerminosCondiciones'
    };

    var setting = {
        MostrarContenedorPadreCupon: false,
        MostrarContenedorInfo: false,
        PaginaOrigen: 0,
        EsEmailActivo: false,
        BaseUrl: '',
        UrlActualizarCupon: 'Cupon/ActualizarCupon',
        UrlEnviarCorreoGanaste: '',
        UrlEnviarCorreoConfirmacionEmail: 'Cupon/EnviarCorreoConfirmacionEmail',
        UrlObtenerCupon: 'Cupon/ObtenerCupon',
        UrlEnviarCorreoActivacionCupon: 'Cupon/EnviarCorreoActivacionCupon',
        UrlObtenerOfertasPlan20EnPedido: 'Cupon/ObtenerOfertasPlan20EnPedido',
        Cupon: null,
        SimboloMoneda: '',
        CampaniaActual: '',
        PaisISO: '',
        UrlS3: 'https://s3.amazonaws.com',
        Ambiente: '',
        TieneCupon: false
    };
    
    var inizializer = function (parameters) {
        setting.TieneCupon = (parameters.tieneCupon == CONS_CUPON.MOSTRAR_CUPON);
        setting.PaginaOrigen = parseInt(parameters.paginaOrigenCupon);
        setting.EsEmailActivo = (parameters.esEmailActivo.toLowerCase() == "true");
        setting.BaseUrl = parameters.baseUrl;
        setting.SimboloMoneda = parameters.simboloMoneda;
        setting.CampaniaActual = parameters.campaniaActual;
        setting.PaisISO = parameters.paisISO;
        setting.Ambiente = parameters.ambiente;
        setDefaultValues();
        mostrarPopupCuponPorPagina();
        bindEvents();
    }

    var setDefaultValues = function () {
        var urlTerminosCondiciones = setting.UrlS3 + "/" + setting.Ambiente + "/SomosBelcorp/FileConsultoras/" + setting.PaisISO + "/Contrato_Cupon.pdf";
        $(elements.LinkTerminosCondiciones).attr("href", urlTerminosCondiciones);
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

        $(document).keyup(function (e) {
            if (e.keyCode == 27) { // escape key maps to keycode `27`
                cerrarTodosPopupCupones();
            }
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
            var correoGanastePromise = enviarCorreoActivacionCuponPromise();

            $.when(cuponPromise, correoGanastePromise)
                .then(function (cuponResponse, correoResponse) {
                    if (cuponResponse.success && correoResponse.success) {
                        AbrirMensaje(cuponResponse.message, "CUPÓN");
                        AbrirMensaje(correoResponse.message, "CUPÓN");
                        obtenerCupon();
                    }
                })
                .then(function (cuponResponse, correoResponse) {
                    var test1 = cuponResponse;
                    var test2 = correoResponse;
                    var test3 = "";
                });
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
        //if (setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_BIENVENIDA || setting.PaginaOrigen == CONS_PAGINA_ORIGEN.DESKTOP_PEDIDO) { }

        if (setting.MostrarContenedorPadreCupon) {
            $(elements.ContenedorPadreCupon).show();

            if (setting.MostrarContenedorInfo) {
                mostrarContenedorInfo();
            } else {
                mostrarContenedorConocelo();
            }

        } else {
            $(elements.ContenedorPadreCupon).hide();
        }
    }

    var obtenerCupon = function () {
        var cuponPromise = obtenerCuponPromise();
        cuponPromise.then(function (response) {
            setting.Cupon = response.data;
            if (setting.Cupon) {
                setting.MostrarContenedorPadreCupon = setting.TieneCupon;
                setting.MostrarContenedorInfo = (setting.Cupon.EstadoCupon == CONS_CUPON.CUPON_ACTIVO && setting.EsEmailActivo);
                mostrarPopupCuponPorPagina();
            }
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

    var obtenerOfertasPlan20EnPedidoPormise = function () {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'GET',
            url: setting.BaseUrl + setting.UrlObtenerOfertasPlan20EnPedido,
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

    var enviarCorreoActivacionCuponPromise = function () {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.BaseUrl + setting.UrlEnviarCorreoActivacionCupon,
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
        //if (celular == "") {
        //    AbrirMensaje("Debe ingresar su número celular", "VALIDACIÓN");
        //    return false;
        //}
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

    var cerrarTodosPopupCupones = function () {
        $(elements.PopupCuponGana).hide();
        $(elements.PopupConfirmacion).hide();
        $(elements.PopupGanaste).hide();
    }

    var mostrarContenedorInfo = function () {
        var mensaje = "";
        var simbolo = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.SimboloMoneda : "%");
        var valor = (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO ? setting.Cupon.FormatoValorAsociado : parseInt(setting.Cupon.FormatoValorAsociado));

        var ofertasPlan20Promise = obtenerOfertasPlan20EnPedidoPormise();
        ofertasPlan20Promise.then(function (response) {
            if (response.success) {
                if (response.tieneOfertasPlan20) {
                    if (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO) {
                        mensaje = "¡Tu descuento de " + simbolo + " " + valor + " es válido! Lo verás reflejado en tu facturación!";
                    } else {
                        mensaje = "¡Tu descuento de " + valor + " " + simbolo + " es válido! Lo verás reflejado en tu facturación!";
                    }
                }
                else {
                    if (setting.Cupon.TipoCupon == CONS_CUPON.TIPO_CUPON_MONTO) {
                        mensaje = "Agrega alguna oferta web para hacer válido tu cupón de descuento de " + simbolo + " " + valor;
                    } else {
                        mensaje = "Agrega alguna oferta web para hacer válido tu cupón de descuento de " + valor + " " + simbolo;
                    }
                }

                $(elements.ContenedorCuponInfo).each(function (index) {
                    var existeContenedorTextoDesktop = $(this).find('div.texto_cupon_monto').length > 0;
                    var existeContenedorTextoMobile = $(this).find('div.texto_cupon').length > 0;

                    if (existeContenedorTextoDesktop) {
                        $(this).find('div.texto_cupon_monto').empty();
                        $(this).find('div.texto_cupon_monto').append(mensaje);
                        $(this).show();
                    }
                    else if (existeContenedorTextoMobile) {
                        if (existeContenedorTextoMobile) {
                            $(this).find('div.texto_cupon').empty();
                            $(this).find('div.texto_cupon').append(mensaje);
                            $(this).show();
                        }
                    } else {
                        $(this).empty();
                        $(this).append(mensaje);
                        $(this).show();
                    }
                });

                $(elements.ContenedorCuponConocelo).hide();
            }
        }, function (xhr, status, error) { });
    }

    var mostrarContenedorConocelo = function () {
        $(elements.ContenedorCuponInfo).hide();
        $(elements.ContenedorCuponConocelo).show();
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