
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
            btnSiguiente1: "#btnSiguiente1",
            btnSiguiente2: "#btnSiguiente2",
            btnSiguiente3: "#btnSiguiente3",
            btnSiguiente4: "#btnSiguiente4",
            Enlace_regresar: ".enlace_regresar",

            ComboCampania: "#ddlCampania",
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

                $(me.Variables.txtCuvMobile).on('keyup', function (evt) {
                    cuvKeyUp = true;
                    EvaluarCUV();
                });

                $(me.Variables.EnlaceCambiarProducto).click(function (e) {
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();
                });

                $(me.Variables.btnSiguiente1).click(function (e) {
                    $(me.Variables.Registro1).hide();
                    $(me.Variables.Registro2).show();
                    $(me.Variables.btnSiguiente1).hide();
                    $(me.Variables.btnSiguiente2).show();
                });

                $(me.Variables.btnSiguiente2).click(function (e) {
                    //$("#txtCUVDescripcion2").val('')
                    //$("#txtCUV2").val('');
                    //$("#txtCUVPrecio2").val('');

                    if (ValidarPaso1()) {
                        paso2Actual = 1;
                        CambioPaso();
                        CargarOperacion();
                    }

                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro3).show();

                    //$(me.Variables.btnSiguiente1).hide();
                    //$(me.Variables.btnSiguiente2).show();
                });

                $(me.Variables.Enlace_regresar).click(function (e) {
                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro1).show();
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

            if (pedido.CDRWebID > 0 && pedido.CDRWebEstado != 1 && pedido.CDRWebEstado != 4) {
                //alert_msg("Lo sentimos, ya cuentas con una solicitud web para este pedido. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text("Lo sentimos, ya cuentas con una solicitud web para este pedido. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                $('#popupInformacionSB2Error').show();
                return false;
            } else {
                pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
                var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $(me.Variables.txtCuvMobile).val() || "");
                var data = detalle.length > 0 ? detalle[0] : new Object();

                $(me.Variables.txtCantidad).removeAttr("disabled");
                $(me.Variables.txtCantidad).attr("data-maxvalue", data.Cantidad);
                //$("#txtCUVDescripcion").val(data.DescripcionProd);
                $("#txtPedidoID").val(data.PedidoID);
                $("#txtNumeroPedido").val(pedido.NumeroPedido);

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

        var CargarOperacion = function () {
            debugger
            var item = {
                CampaniaID: $.trim($("#ddlCampania").val()),
                PedidoID: $("#txtPedidoID").val(),
                Motivo: $("#divMotivo [data-check='1']").attr("id")
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
                    SetHandlebars("#template-operacion", data.detalle, "#divOperacion");

                },
                error: function (data, error) {
                    closeWaitingDialog();
                    if (checkTimeout(data)) {
                    }
                }
            });
        }

        var BuscarMotivo = function () {

            var PedidoId = $.trim($("#txtPedidoID").val()) || 0;
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

                    SetHandlebars("#template-motivo", data.detalle, "#divMotivo");
                },
                error: function (data, error) {
                    //closeWaitingDialog();
                    if (checkTimeout(data)) { }
                }
            });
        }

        function DetalleCargar() {
            var item = {
                CDRWebID: $("#CDRWebID").val() || 0,
                PedidoID: $("#txtPedidoID").val() || 0
            };

            //waitingDialog();
            jQuery.ajax({
                type: 'POST',
                url: baseUrl + 'MisReclamos/DetalleCargar',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(item),
                cache: false,
                success: function (data) {
                    //closeWaitingDialog();
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
                    //closeWaitingDialog();
                    if (checkTimeout(data)) { }
                }
            });
        }
        
        me.Constantes = {
            //PromocionNoDisponible: "Esta promoción no se encuentra disponible."
        };

        me.Funciones = {
            //BuscarPorCUV: function (CUV) { }
        };

        me.Inicializar = function () {
            me.Eventos.bindEvents();
        };
    };

    misReclamosRegistro = new PortalConsultorasReclamoRegistro();
    misReclamosRegistro.Inicializar();
});
