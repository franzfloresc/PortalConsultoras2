
var misReclamosRegistro
var cuvKeyUp = false, cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';

$(document).ready(function () {
    'use strict';

    var PortalConsultorasReclamoRegistro;
    PortalConsultorasReclamoRegistro = function () {
        var me = this;

        me.Variables = {
            alturaListaMiSolicitud: $(document).height(),
            datosSolicitudOpened: ".datos_solicitud_opened",
            miSolicitudCDR: ".mi_solicitud_cdr",
            numSolicitudes: ".num_solicitudes",
            pestaniaVerMiSolicitud: ".pestania_ver_mi_solicitud",
            listadoProductosAgregados: ".listado_productos_agregados",
            txtCuvMobile: "#cuvmobile",
            DescripcionCuv: "#DescripcionCuv",
            txtCuv: "#txtCuv",
            txtDescripcionCuv: "#txtDescripcionCuv",
            EnlaceCambiarProducto: ".enlace_cambiar_producto",
            txtCantidad: "#txtCantidadFichaOPT",
            Registro1: ".Registro1",
            Registro2: ".Registro2",
            Registro3: ".Registro3",
            Registro4: ".Registro4",
            btnSiguiente1: "#btnSiguiente1",
            btnSiguiente2: "#btnSiguiente2",
            btnSiguiente3: "#btnSiguiente3",
            btnSiguiente4: "#btnSiguiente4",
            btnAceptarSolucion: "[data-cambiopaso]",
            Enlace_regresar: ".enlace_regresar",
            RegistroAceptarSolucion: ".AceptarSolucion",
            ComboCampania: "#ddlCampania",
            SolicitudEnviada: "#SolicitudEnviada",
            hdPedidoId: "#txtPedidoID",
            hdCDRID: "#CDRWebID"
        };

        me.Eventos = {
            bindEvents: function () {

                $(me.Variables.miSolicitudCDR).click(function (e) {

                    e.stopPropagation();

                    $(me.Variables.numSolicitudes).fadeOut(150);

                    $(me.Variables.pestaniaVerMiSolicitud).addClass("crece");

                    $(me.Variables.miSolicitudCDR).animate({

                        "width": "222px"

                    }, 120, function () {

                        $(me.Variables.miSolicitudCDR).animate({

                            "height": "291px"

                        }, 220);

                    });

                    setTimeout(function () {

                        $(me.Variables.datosSolicitudOpened).fadeIn(200);

                    }, 220);

                });

                $("body, .ocultar_mi_solicitud").click(function (e) {

                    e.stopPropagation();

                    $(me.Variables.datosSolicitudOpened).fadeOut(200);

                    $(me.Variables.miSolicitudCDR).animate({

                        "height": "35px"

                    }, 220, function () {

                        $(me.Variables.pestaniaVerMiSolicitud).removeClass("crece");

                        $(me.Variables.miSolicitudCDR).animate({

                            "width": "35px"

                        }, 120);

                    });

                    setTimeout(function () {

                        $(me.Variables.numSolicitudes).fadeIn(200);

                    }, 450);

                });

                $(".enlace_ir_al_final a").click(function (e) {

                    e.preventDefault();
                    $(me.Variables.listadoProductosAgregados).animate({
                        scrollTop: me.Variables.alturaListaMiSolicitud + "px"
                    }, 500);

                });

                $(".listado_soluciones_cdr").on('click', '.solucion_cdr', function () {

                    $(".solucion_cdr").attr("data-check", "0");

                    var id = $.trim($(this).attr("id"));
                    if (id == "") return false;

                    $(this).attr("data-check", "1");
                    me.Funciones.AnalizarOperacion(id);

                    $(me.Variables.Registro3).hide();
                    $(me.Variables.btnAceptarSolucion).show();
                });

                $(me.Variables.txtCuvMobile).on('keyup', function (evt) {
                    cuvKeyUp = true;
                    EvaluarCUV();
                });

                $(me.Variables.EnlaceCambiarProducto).click(function (e) {
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();
                });

                $(me.Variables.btnSiguiente1).click(function (e) {

                    me.Funciones.BuscarMotivo();

                    $(me.Variables.Registro1).hide();
                    $(me.Variables.Registro2).show();
                    $(me.Variables.btnSiguiente1).hide();
                    $(me.Variables.btnSiguiente2).show();
                });

                $(me.Variables.btnSiguiente2).click(function (e) {
                    //$("#txtCUVDescripcion2").val('')
                    //$("#txtCUV2").val('');
                    //$("#txtCUVPrecio2").val('');
                    console.log('Siguiente 2.. ');
                    if (me.Funciones.ValidarPaso1()) {
                        console.log(' Paso 1 validado... ');
                        //paso2Actual = 1;
                        //me.Funciones.CambioPaso();
                        me.Funciones.CargarOperacion();
                    }

                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro3).show();
                    $(me.Variables.btnSiguiente2).hide();
                    $(me.Variables.btnSiguiente3).hide();
                });

                $(me.Variables.btnSiguiente3).click(function (e) {
                    console.log('Siguiente 3 ');
                });

                $(me.Variables.btnAceptarSolucion).click(function () {
                    console.log('Aceptar solucion..');
                    me.Funciones.DetalleGuardar();

                    $(me.Variables.Registro4).hide();
                    $(me.Variables.btnAceptarSolucion).hide();

                    $(me.Variables.btnSiguiente4).show();
                    $(me.Variables.RegistroAceptarSolucion).show();
                });

                $(me.Variables.Enlace_regresar).click(function (e) {
                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro1).show();
                });

                $(me.Variables.btnSiguiente4).click(function () {
                    console.log('Finalizar y enviar solicitud');

                    me.Funciones.SolicitudEnviar();

                    $(me.Variables.RegistroAceptarSolucion).hide();
                    $(me.Variables.SolicitudEnviada).show();
                });
            }
        };

        var EvaluarCUV = function () {
            if (!CUVCambio()) return false;

            $(me.Variables.txtCantidad).attr("disabled", "disabled");
            $(me.Variables.txtCantidad).attr("data-maxvalue", "0");
            //$("#txtCUVDescripcion").val("");

            if (cuvPrevVal.length == 5) {
                BuscarCUV(cuvPrevVal);
            }
        };

        var CUVCambio = function () {
            var cuvVal = $(me.Variables.txtCuvMobile).val();
            if (cuvVal == null) cuvVal = '';
            if (cuvVal.length > 5) {
                cuvVal = cuvVal.substr(0, 5);
                $(me.Variables.txtCuvMobile).val(cuvVal);
            }

            var cambio = (cuvVal != cuvPrevVal);
            cuvPrevVal = cuvVal;
            return cambio;
        };

        var BuscarCUV = function (CUV) {
            CUV = $.trim(CUV) || $.trim($(me.Variables.txtCuvMobile).val());
            var CampaniaId = $.trim($(me.Variables.ComboCampania).val()) || 0;
            if (CampaniaId <= 0 || CUV.length < 5) return false;

            var PedidoId = $.trim($(me.Variables.hdPedidoId).val()) || 0;

            var item = {
                CampaniaID: CampaniaId,
                PedidoID: PedidoId,
                CDRWebID: $(me.Variables.hdCDRID).val(),
                CUV: CUV
            };


            jQuery.ajax({
                type: 'POST',
                url: UrlBuscarCuv,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(item),
                cache: false,
                success: function (data) {
                    if (!checkTimeout(data))
                        return false;

                    if (data.success == false) {
                        alert_msg(data.message);
                        return false;
                    }

                    data.detalle = data.detalle || new Array();
                    if (data.detalle.length <= 0) {
                        //$("#divMotivo").html("");
                        //alert_msg("Producto no disponible para atención por este medio, comunícate con el <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                        Console.log("Producto no disponible para atención por este medio, comunícate con el <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                    } else {
                        if (data.detalle.length > 1) PopupPedido(data.detalle);
                        else AsignarCUV(data.detalle[0]);
                    }
                },
                error: function (data, error) {
                    checkTimeout(data);
                }
            });
        };

        var AsignarCUV = function (pedido) {
            pedido = pedido || new Object();
            //$("#divMotivo").html("");
            console.log('Asignar CUV');
            if (pedido.CDRWebID > 0 && pedido.CDRWebEstado != 1 && pedido.CDRWebEstado != 4) {
                //alert_msg("Lo sentimos, ya cuentas con una solicitud web para este pedido. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text("Lo sentimos, ya cuentas con una solicitud web para este pedido. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                $('#popupInformacionSB2Error').show();
                return false;
            } else {
                pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
                var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $(me.Variables.txtCuvMobile).val() || "");
                var data = detalle.length > 0 ? detalle[0] : new Object();
                console.log('Asignar data CUV');
                $(me.Variables.txtCantidad).removeAttr("disabled");
                $(me.Variables.txtCantidad).attr("data-maxvalue", data.Cantidad);
                //$("#txtCUVDescripcion").val(data.DescripcionProd);
                $("#hdPedidoID").val(data.PedidoID);
                $("#hdNumeroPedido").val(pedido.NumeroPedido);

                $("#txtPrecioUnidad").val(data.PrecioUnidad);
                $("#hdImporteTotalPedido").val(pedido.ImporteTotal);
                $("#CDRWebID").val(pedido.CDRWebID);

                /*Seteando cuv y descripcion*/
                $(me.Variables.txtCuv).html(data.CUV);
                $(me.Variables.txtDescripcionCuv).html(data.DescripcionProd);

                $(me.Variables.txtCuvMobile).hide();
                $(me.Variables.DescripcionCuv).fadeIn();

                //BuscarMotivo();
                //DetalleCargar();
            }
        }

        me.Constantes = {
            //PromocionNoDisponible: "Esta promoción no se encuentra disponible."
        };

        me.Funciones = {

            BuscarMotivo: function () {
                debugger;
                var PedidoId = $.trim($("#hdPedidoID").val()) || 0;
                var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
                if (PedidoId <= 0 || CampaniaId <= 0)
                    return false;
               
                //waitingDialog();

                var item = {
                    CampaniaID: $.trim($("#ddlCampania").val()),
                    PedidoID: PedidoId
                };

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/BuscarMotivo',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        //closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            alert_msg(data.message);
                            return false;
                        }

                        SetHandlebars("#template-motivo", data.detalle, "#listaMotivos");
                    },
                    error: function (data, error) {
                        //closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            },

            ValidarPaso1: function () {
                var ok = true;

                ok = $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").size() == 0 ? false : ok;
                console.log('ok' + ok);
                if (!ok) {
                    alert_msg("Datos incorrectos");
                    return false;
                }

                var item = {
                    PedidoID: $("#hdPedidoID").val(),
                    CUV: $("#txtCuv").text(),
                    Cantidad: $.trim($("#txtCantidadFichaOPT").val()),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    CampaniaID: $("#ddlCampania").val()
                };

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/ValidarPaso1',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) {
                            ok = data.success;

                            //if (!data.success && data.message != "") {
                            //    alert_msg(data.message);
                            //}
                        }
                    },
                    error: function (data, error) {
                        console.log('Error en validar pasos');
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });

                return ok;

            },

            AnalizarOperacion: function (id) {

                if (id == "C") {

                }
                if (id == 'D') {
                    if (me.Funciones.ValidarPaso2Devolucion(id)) {
                        //CambioPaso2(100);
                        //$("[data-tipo-confirma='cambio']").hide();
                        //$("[data-tipo-confirma=canje]").show();
                        console.log('termino de validar,..');
                        me.Funciones.CargarPropuesta(id);
                    }
                }

                if (id == "F") {
                }

                if (id == "G") {
                }

                if (id == "T") {
                }
            },

            CambioPaso: function () {

            },

            CargarPropuesta: function (codigoSsic) {
                var tipo = (codigoSsic == "C" || codigoSsic == "D" || codigoSsic == "F" || codigoSsic == "G") ? "canje" : "cambio";

                var item = {
                    CUV: $.trim($("#txtCuv").text()),
                    DescripcionProd: $.trim($("#DescripcionCuv").text()),
                    Cantidad: $.trim($("#txtCantidadFichaOPT").val()),
                    EstadoSsic: $.trim(codigoSsic)
                };

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/BuscarPropuesta',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            alert_msg(data.message);
                            return false;
                        }

                        $(me.Variables.Registro4).show();
                        if (tipo == "canje") {
                            SetHandlebars("#template-confirmacion", data.detalle, "[data-tipo-confirma='" + tipo + "'] [data-detalle-confirma]");
                        }
                        //$(me.Variables.Registro3).hide();

                        $("#spnMensajeTenerEnCuentaCanje").html(data.descripcionTenerEnCuenta);
                        $("#spnMensajeTenerEnCuentaCambio").html(data.descripcionTenerEnCuenta);
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            },

            CargarOperacion: function () {
                // debugger;
                var item = {
                    CampaniaID: $.trim($("#ddlCampania").val()),
                    PedidoID: $("#hdPedidoID").val(),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id")
                };

                waitingDialog();

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/BuscarOperacion',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            alert_msg(data.message);
                            return false;
                        }
                        SetHandlebars("#template-operacion", data.detalle, "#listado_soluciones_cdr");

                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) {
                        }
                    }
                });
            },
            
            DetalleGuardar: function () {
                //debugger;
                var item = {
                    CDRWebID: $("#CDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoID").val() || 0,
                    NumeroPedido: $("#hdNumeroPedido").val() || 0,
                    CampaniaID: $("#ddlCampania").val() || 0,
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"), //$(".reclamo_motivo_select[data-check='1']").attr("id"),
                    Operacion: $(".solucion_cdr[data-check='1']").attr('id'),
                    CUV: $("#txtCuv").text(),
                    Cantidad: $.trim($("#txtCantidadFichaOPT").val()),
                    CUV2: $("#txtCUV2").val(),
                    Cantidad2: $("#txtCantidad2").val()
                };

                waitingDialog();

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/DetalleGuardar',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data)) {
                            return false;
                        }

                        if (data.success == false) {
                            alert_msg(data.message);
                            return false;
                        }
                        debugger;
                        $("#CDRWebID").val(data.detalle);
                        me.Funciones.CambioPaso();
                        me.Funciones.DetalleCargar();
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            },

            DetalleCargar: function () {

                var item = {
                    CDRWebID: $("#CDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoID").val() || 0
                };
                debugger;
                waitingDialog();
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/DetalleCargar',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success != true) {
                            alert_msg(data.message);
                            return false;
                        }

                        $("#spnCantidadUltimasSolicitadas").html(data.detalle.length);
                        SetHandlebars("#template-detalle-banner", data.detalle, "#divDetalleUltimasSolicitudes");
                        ValidarVisualizacionBannerResumen();

                        SetHandlebars("#template-detalle-paso3", data, "#divDetallePaso3");
                        SetHandlebars("#template-detalle-paso3-enviada", data, "#divDetalleEnviar");

                        //EPD-1919 INICIO
                        if (data.esCDRExpress) $("#TipoDespacho").show();
                        else $("#TipoDespacho").hide();
                        //EPD-1919 FIN

                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            },

            ValidarVisualizacionBannerResumen: function () {
                var cantidadDetalles = $("#spnCantidadUltimasSolicitadas").html();

                if ($('#Paso2:visible').length > 0 || cantidadDetalles == 0) $("#btn_ver_solicitudes").hide();
                else $("#btn_ver_solicitudes").show();
                if ($('#Paso3:visible').length > 0) $("#divUltimasSolicitudes").hide();
                else $("#divUltimasSolicitudes").show();
            },

            ValidarPaso2Devolucion: function (codigoSsic) {

                var montoMinimoPedido = $("#hdMontoMinimoPedido").val();
                var montoTotalPedido = $("#hdImporteTotalPedido").val();
                var montoProductosDevolverActual = me.Funciones.ObtenerMontoProductosDevolver(codigoSsic);

                var diferenciaMonto = montoTotalPedido - montoMinimoPedido;
                var montoCuvActual = (parseFloat($("#txtPrecioUnidad").val()) || 0) * (parseInt($("#txtCantidad").val()) || 0);
                var montoDevolver = montoProductosDevolverActual + montoCuvActual;

                if (diferenciaMonto < montoDevolver) {
                    alert_msg("Por favor, selecciona otra solución, ya que tu pedido está quedando por debajo del monto mínimo permitido");
                    return false;
                }

                me.Funciones.ObtenerValorParametria(codigoSsic);
                var valorParametria = $("#hdParametriaCdr").val() || 0;

                valorParametria = parseFloat(valorParametria);
                console.log('Validar paso2 : ' + valorParametria);
                var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

                if (montoMaximoDevolver < montoDevolver) {
                    alert_msg("Por favor, selecciona otra solución, ya que superas el porcentaje de devolución permitido en tu pedido facturado");
                    return false;
                }

                return true;
            },

            ObtenerValorParametria: function (codigoSsic) {
                var item = {
                    EstadoSsic: codigoSsic
                };

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/BuscarParametria',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        var parametria = data.detalle;
                        var parametriaAbs = data.detalleAbs;

                        $("#hdParametriaCdr").val(parametria.ValorParametria);
                        $("#hdParametriaAbsCdr").val(parametriaAbs.ValorParametria);
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) {
                        }
                    }
                });
            },

            ObtenerMontoProductosDevolver: function (codigoOperacion) {
                var resultado = 0;
                console.log('ObtenerMontoProductosDevolver .. ');
                var item = {
                    CDRWebID: $("#CDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoID").val() || 0,
                    EstadoSsic: codigoOperacion
                };
                waitingDialog();

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/ObtenerMontoProductosCdrByCodigoOperacion',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success != true) {
                            alert_msg(data.message);
                            return false;
                        }

                        resultado = data.montoProductos;
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });

                return resultado;

            },        

            SolicitudEnviar: function () {
                var ok = true;
                var correo = $.trim($("#txtEmail").val());
                var celular = $.trim($("#txtTelefono").val());

                if (IfNull(validarCorreoVacio, true) && correo == "") {
                    ControlSetError('#txtEmail', '#spnEmailError', '*Correo Electrónico incorrecto');
                    ok = false;
                }
                if (IfNull(validarCelularVacio, true) && celular == "") {
                    ControlSetError('#txtTelefono', '#spnTelefonoError', '*Celular incorrecto');
                    ok = false;
                }
                if (!ok) {
                    alert_msg("Debe completar la sección de VALIDA TUS DATOS para finalizar");
                    return false;
                }

                if (correo != "" && !validateEmail(correo)) {
                    ControlSetError('#txtEmail', '#spnEmailError', '*Correo Electrónico incorrecto');
                    ok = false;
                }
                if (celular != "" && celular.length < 6) {
                    ControlSetError('#txtTelefono', '#spnTelefonoError', '*Celular incorrecto');
                    ok = false;
                }
                if (!ok) return false;

                if (celular != "" && !ValidarTelefono(celular)) {
                    ControlSetError('#txtTelefono', '#spnTelefonoError', '*Este número de celular ya está siendo utilizado. Intenta con otro.');
                    return false;
                }

                var correoActual = $.trim($("#hdEmail").val());
                if (correo != "" && correo != correoActual && !ValidarCorreoDuplicado(correo)) {
                    ControlSetError('#txtEmail', '#spnEmailError', '*Este correo ya está siendo utilizado. Intenta con otro');
                    return false;
                }

                if (!$("#btnAceptoPoliticas").hasClass("politica_reclamos_icono_active")) {
                    alert_msg("Debe aceptar la política de Cambios y Devoluciones");
                    return false;
                }
                debugger;
                var item = {
                    CDRWebID: $("#CDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoID").val() || 0,
                    Email: $("#txtEmail").val(),
                    Telefono: $("#txtTelefono").val(),
                    TipoDespacho: false,
                    FleteDespacho: 0,
                    MensajeDespacho: ''
                };
                if ($("#hdTieneCDRExpress").val() == '1') {
                    item.TipoDespacho = tipoDespacho;
                    item.FleteDespacho = !tipoDespacho ? 0 : $("#hdFleteDespacho").val();
                    item.MensajeDespacho = $(!tipoDespacho ? '#divDespachoNormal' : '#divDespachoExpress').CleanWhitespace().html();
                }

                waitingDialog();
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/SolicitudEnviar',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data)) return false;

                        if (data.success != true) {
                            alert_msg(data.message);
                            return false;
                        }

                        var formatoFechaCulminado = "";
                        var numeroSolicitud = 0;
                        var formatoCampania = "";
                        var mensajeDespacho = IfNull(data.cdrWeb.MensajeDespacho, '');
                        if (data.cdrWeb.CDRWebID > 0) {
                            if (data.cdrWeb.FechaCulminado != 'null' || data.cdrWeb.FechaCulminado != "" || data.cdrWeb.FechaCulminado != undefined) {
                                var dateString = data.cdrWeb.FechaCulminado.substr(6);
                                var currentTime = new Date(parseInt(dateString));
                                var month = currentTime.getMonth() + 1;
                                var day = currentTime.getDate();
                                var year = currentTime.getFullYear();
                                formatoFechaCulminado = (day < 10 ? "0" + day : day) + "/" + (month < 10 ? "0" + month : month) + "/" + year;
                            }

                            numeroSolicitud = data.cdrWeb.CDRWebID;

                            if (data.cdrWeb.CampaniaID.toString().length == 6) {
                                formatoCampania = data.cdrWeb.CampaniaID.toString().substring(0, 4) + "-" + data.cdrWeb.CampaniaID.toString().substring(4);
                            }
                        }

                        $("#spnSolicitudFechaCulminado").html(formatoFechaCulminado);
                        $("#spnSolicitudNumeroSolicitud").html(numeroSolicitud);
                        $("#spnSolicitudCampania").html(formatoCampania);
                        if (mensajeDespacho == '') $("#spnTipoDespacho").hide();
                        else $("#spnTipoDespacho").show().html(mensajeDespacho);
                        $("#divProcesoReclamo").hide();
                        $("#divUltimasSolicitudes").hide();
                        $("#TituloReclamo").hide();
                        $("#SolicitudEnviada").show();

                        if (data.Cantidad == 1) alertEMail_msg(data.message, "MENSAJE");
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            }
        };

        me.Inicializar = function () {
            me.Eventos.bindEvents();
        };
    };

    misReclamosRegistro = new PortalConsultorasReclamoRegistro();
    misReclamosRegistro.Inicializar();
});
