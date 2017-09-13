var cuvKeyUp = false;
var cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';
var pasoActual = 1;
var paso2Actual = 1;
var misReclamosRegistro;

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
            txtCuvMobile2: "#cuvmobile2",
            DescripcionCuv: "#DescripcionCuv",
            DescripcionCuv2: "#DescripcionCuv2",
            txtCuv: "#txtCuv",
            txtcuv2: "txtCuv2",
            txtDescripcionCuv: "#txtDescripcionCuv",
            txtTelefono: "#txtTelefono",
            aCambiarProducto: "#aCambiarProducto",
            aCambiarProducto2: "#aCambiarProducto2",
            txtCantidad: "#txtCantidad",
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
            hdCDRID: "#CDRWebID",
            btnCambioProducto: "#btnCambioProducto",
            btn_ver_solicitudes: "#btn_ver_solicitudes",
            IrSolicitudInicial: "#IrSolicitudInicial"
        };

        me.Eventos = {
            bindEvents: function () {

                $(me.Variables.IrSolicitudInicial).click(function () {

                    if (mensajeGestionCdrInhabilitada != '') {
                        messageInfoValidado(mensajeGestionCdrInhabilitada);
                        return false;
                    }

                    //El if se hizo con !() para considerar posibles valores null o undefined de $('#ddlCampania').val()
                    if (!($('#ddlCampania').val() > 0)) {
                        messageInfoValidado(mensajeCdrFueraDeFechaCompleto);
                        return false;
                    }

                    $(me.Variables.txtCuvMobile).val("");
                    $(me.Variables.txtDescripcionCuv).val("");
                    $(me.Variables.txtCantidad).val("1");
                    $(me.Variables.txtcuv2).val("");
                    $("#txtCUVPrecio2").val("");
                    $("#spnImporteTotal2").html("");
                    $("#hdImporteTotal2").val(0);
                    $("#txtCUVDescripcion2").val("");
                    $("#txtCantidad2").val("1");
                    me.Funciones.CambioPaso(-100);
                    me.Funciones.BuscarMotivo();

                    $("#divUltimasSolicitudes").show();
                    $(me.Variables.Registro1).show();

                    $(me.Variables.RegistroAceptarSolucion).hide();
                    $(me.Variables.btnSiguiente4).hide();
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();

                    $("#ddlCampania").attr("disabled", "disabled");
                });

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

                    $(me.Variables.Registro1).hide();
                    $(me.Variables.btnSiguiente1).hide();
                    $(me.Variables.RegistroAceptarSolucion).show();
                    $(me.Variables.btnSiguiente4).show();
                });

                $(".listado_soluciones_cdr").on('click', '.solucion_cdr', function () {

                    $(".solucion_cdr").attr("data-check", "0");

                    var id = $.trim($(this).attr("id"));
                    if (id == "") return false;

                    $(this).attr("data-check", "1");
                    me.Funciones.AnalizarOperacion(id);

                    $(me.Variables.Registro3).hide();
                    //$(me.Variables.btnAceptarSolucion).show();
                });

                $('a[data-accion]').on('click', function (e) {
                    e.preventDefault(); // prevents the <a> from navigating
                //$("body").on("click", "[data-accion]", function () {
                    me.Funciones.DetalleAccion(this);
                });

                $(me.Variables.txtCuvMobile).on('keyup', function (evt) {
                    cuvKeyUp = true;
                    EvaluarCUV();
                });

                $(me.Variables.aCambiarProducto).click(function (e) {
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();
                    $(me.Variables.txtCuvMobile).focus();
                });

                $(me.Variables.aCambiarProducto2).click(function (e) {
                    $(me.Variables.DescripcionCuv2).hide();
                    $(me.Variables.txtCuvMobile2).fadeIn();
                });

                $(me.Variables.btnSiguiente1).click(function (e) {

                    if ($(me.Variables.Registro1).is(":visible")) {
                        me.Funciones.BuscarMotivo();
                        $("#pasodos").hide();
                        $("#pasodosactivo").show();
                        $(me.Variables.Registro1).hide();
                        $(me.Variables.Registro2).show();
                        return false;
                    }

                    if ($(me.Variables.Registro2).is(":visible")) {
                        //$("#txtCUVDescripcion2").val('')
                        //$("#txtCUV2").val('');
                        //$("#txtCUVPrecio2").val('');

                        if (me.Funciones.ValidarPaso1()) {
                            console.log(' Paso 1 validado... ');
                            //paso2Actual = 1;
                            //me.Funciones.CambioPaso();
                            me.Funciones.CargarOperacion();

                            $(me.Variables.Registro2).hide();
                            $(me.Variables.Registro3).show();
                            $(me.Variables.btnSiguiente2).hide();
                            $(me.Variables.btnSiguiente3).hide();
                        }
                    }
                });

                $(me.Variables.btnSiguiente2).click(function (e) {
                    ////$("#txtCUVDescripcion2").val('')
                    ////$("#txtCUV2").val('');
                    ////$("#txtCUVPrecio2").val('');

                    //if (me.Funciones.ValidarPaso1()) {
                    //    console.log(' Paso 1 validado... ');
                    //    //paso2Actual = 1;
                    //    //me.Funciones.CambioPaso();
                    //    me.Funciones.CargarOperacion();

                    //    $(me.Variables.Registro2).hide();
                    //    $(me.Variables.Registro3).show();
                    //    $(me.Variables.btnSiguiente2).hide();
                    //    $(me.Variables.btnSiguiente3).hide();
                    //}
                });

                $(me.Variables.btnSiguiente3).click(function (e) {

                    //$(me.Variables.btnSiguiente3).hide();
                    //$(me.Variables.CambioProducto).show();
                });

                $(me.Variables.btnAceptarSolucion).click(function () {

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

                    me.Funciones.SolicitudEnviar(false, true);
                });

                $(me.Variables.txtTelefono).keypress(function (evt) {
                    var charCode = (evt.which) ? evt.which : window.event.keyCode;
                    if (charCode <= 13) {
                        return false;
                    }
                    else {
                        var keyChar = String.fromCharCode(charCode);
                        var re = /[0-9+ *#-]/;
                        return re.test(keyChar);
                    }
                });

                $(me.Variables.txtCuvMobile2).on('keyup', function (evt) {
                    cuv2KeyUp = true;

                    me.Funciones.EvaluarCUV2();
                });

                $(me.Variables.btnCambioProducto).click(function (evt) {
                    me.Funciones.CambioPaso2(1);
                    $(me.Variables.btnCambioProducto).hide();
                    $(me.Variables.btnAceptarSolucion).show();
                    //if (ValidarPaso2Trueque()) {
                    //    CambioPaso2(1);

                    //    //$("#spnCuv1").html($("#txtCUV").val());
                    //    //$("#spnDescripcionCuv1").html($("#txtCUVDescripcion").val());
                    //    //$("#spnCantidadCuv1").html($("#txtCantidad").val());
                    //    //$("#spnCuv2").html($("#txtCUV2").val());
                    //    //$("#spnDescripcionCuv2").html($("#txtCUVDescripcion2").val());
                    //    //$("#spnCantidadCuv2").html($("#txtCantidad2").val());
                    //}
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
                        messageInfoValidado(data.message);
                        return false;
                    }

                    data.detalle = data.detalle || new Array();
                    if (data.detalle.length <= 0) {
                        //$("#divMotivo").html("");
                        $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text("Producto no disponible para atención por este medio, comunícate con el <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
                        $('#popupInformacionSB2Error').show()

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

            EvaluarCUV2: function () {

                if (!me.Funciones.CUV2Cambio()) return false;

                var cuv = $(me.Variables.txtCuvMobile2).val();

                if (cuv2PrevVal.length == 5) me.Funciones.BuscarCUVCambiar(cuv2PrevVal);
                else {
                    $("#txtCUVDescripcion2").val("");
                    $("#txtCUVPrecio2").val("");
                    $("#hdImporteTotal2").val(0);
                    $("#spnImporteTotal2").html("");
                    $("#CambioProducto2").addClass("disabledClick");
                }
            },

            CUV2Cambio: function () {
                var cuv2Val = $(me.Variables.txtCuvMobile2).val();
                if (cuv2Val == null) cuv2Val = '';
                if (cuv2Val.length > 5) {
                    cuv2Val = cuv2Val.substr(0, 5);
                    $(me.Variables.txtCuvMobile2).val(cuv2Val);
                }

                var cambio = (cuv2Val != cuv2PrevVal);
                cuv2PrevVal = cuv2Val;
                return cambio;
            },

            BuscarCUVCambiar: function (cuv) {
                cuv = $.trim(cuv) || $.trim(me.Variables.txtCuvMobile2).val();
                var CampaniaId = $.trim($("#ddlCampania").val()) || 0;
                if (CampaniaId <= 0 || cuv.length < 5)
                    return false;

                var PedidoId = $.trim($("#txtPedidoID").val()) || 0;

                var item = {
                    CampaniaID: CampaniaId,
                    PedidoID: PedidoId,
                    CDRWebID: $("#CDRWebID").val(),
                    CUV: cuv
                };


                jQuery.ajax({
                    type: 'POST',
                    url: UrlBuscarCuvCambiar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    cache: false,
                    success: function (data) {

                        if (!checkTimeout(data))
                            return false;

                        if (data[0].MarcaID != 0) {
                            /*Seteando cuv y descripcion*/

                            var descripcion = data[0].Descripcion;
                            var precio = data[0].PrecioCatalogo;
                            var cuv2 = data[0].CUV;

                            $(me.Variables.txtCuv2).html(cuv2);
                            $(me.Variables.txtDescripcionCuv2).html(descripcion);

                            $(me.Variables.txtCuvMobile2).hide();
                            $(me.Variables.DescripcionCuv2).fadeIn();



                            //$("#CambioProducto2").removeClass("disabledClick");
                            //var descripcion = data[0].Descripcion;
                            //var precio = data[0].PrecioCatalogo;

                            //$("#txtCUVDescripcion2").val(descripcion);
                            //$("#txtCUVPrecio2").val(DecimalToStringFormat(precio));
                            //$("#hdCuvPrecio2").val(precio);

                            //var cantidad = $("#txtCantidad2").val();
                            //$("#hdImporteTotal2").val(precio * cantidad);
                            //$("#spnImporteTotal2").html(DecimalToStringFormat(precio * cantidad));
                        } else {
                            $("#txtCUVDescripcion2").val("");
                            $("#txtCUVPrecio2").val("");
                            $("#hdImporteTotal2").val(0);
                            $("#spnImporteTotal2").html("");
                            messageInfoValidado(data[0].CUV);
                        }
                    },
                    error: function (data, error) {

                        if (checkTimeout(data)) { }
                    }
                });
            },

            BuscarMotivo: function () {

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
                            messageInfoValidado(data.message);
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
                ok = $("#ddlCampania").val() > 0 ? ok : false;
                ok = $.trim($("#hdPedidoID").val()) > 0 ? ok : false;
                ok = $.trim($(me.Variables.txtCuvMobile).val()) != "" ? ok : false;
                ok = $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").size() == 0 ? false : ok;

                if (!ok) {
                    messageInfoValidado("Datos incorrectos");
                    return false;
                }

                var item = {
                    PedidoID: $("#hdPedidoID").val(),
                    CUV: $("#txtCuv").text(),
                    Cantidad: $.trim($("#txtCantidad").val()),
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

                            if (!data.success && data.message != "") {
                                //alert_msg(data.message);
                                $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').text(data.message);
                                $('#popupInformacionSB2Error').show();
                            }
                        }
                    },
                    error: function (data, error) {

                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });

                return ok;

            },

            AnalizarOperacion: function (id) {

                if (id == "C") {
                    CambioPaso2(100);
                    $("[data-tipo-confirma='cambio']").hide();
                    $("[data-tipo-confirma=canje]").show();

                    CargarPropuesta(id);
                }
                if (id == 'D') {

                    if (me.Funciones.ValidarPaso2Devolucion(id)) {

                        $("[data-tipo-confirma='cambio']").hide();
                        $("[data-tipo-confirma=canje]").show();
                        me.Funciones.CargarPropuesta(id);

                        $(me.Variables.Registro3).hide();
                        $(me.Variables.btnAceptarSolucion).show();
                    }
                }

                if (id == "F") {
                    if (me.Funciones.ValidarPaso2Faltante(id)) {
                        me.Funciones.CambioPaso2(100);
                        $("[data-tipo-confirma='cambio']").hide();
                        $("[data-tipo-confirma=canje]").show();

                        me.Funciones.CargarPropuesta(id);
                    }
                }

                if (id == "G") {
                    if (me.Funciones.ValidarPaso2FaltanteAbono(id)) {
                        me.Funciones.CambioPaso2(100);
                        $("[data-tipo-confirma='cambio']").hide();
                        $("[data-tipo-confirma=canje]").show();

                        me.Funciones.CargarPropuesta(id);
                    }
                }

                if (id == "T") {
                    me.Funciones.CambioPaso2(); //CambioPaso2
                    $("[data-tipo-confirma='canje']").hide();
                    $("[data-tipo-confirma=cambio]").show();

                    $("#spnSimboloMonedaReclamo").html(vbSimbolo);

                    var precioUnidad = $("#txtPrecioUnidad").val();
                    var cantidad = $("#txtCantidad").val();
                    var totalTrueque = parseFloat(precioUnidad) * parseFloat(cantidad);

                    $("#hdMontoMinimoReclamo").val(totalTrueque);
                    $("#spnMontoMinimoReclamoFormato").html(DecimalToStringFormat(totalTrueque));

                    var campania = $("#ddlCampania").val() || 0;
                    var numeroCampania = '00';
                    if (campania > 0) {
                        numeroCampania = campania.substring(4);
                    }

                    $("#spnNumeroCampaniaReclamo").html(numeroCampania);
                    $(me.Variables.btnCambioProducto).show();

                    me.Funciones.ObtenerValorParametria(id);
                    me.Funciones.CargarPropuesta(id);
                }
            },

            CambioPaso: function (paso) {
                paso = paso || 1;
                pasoActual = pasoActual + paso || 1;
                pasoActual = pasoActual < 1 ? 1 : pasoActual > 3 ? 3 : pasoActual;

                $(".paso_reclamo[data-paso]").removeClass("paso_active_reclamo");
                $(".paso_reclamo[data-paso] span").html("");

                $(".paso_reclamo[data-paso]").each(function (ind, tag) {
                    var pasoTag = $(tag).attr("data-paso");
                    if (pasoTag < pasoActual) {
                        $(tag).addClass("paso_active_reclamo");
                        $(tag).find("span").html("<img src='" + imgCheck + "' />");
                    }
                    else if (pasoTag == pasoActual) {
                        $(tag).addClass("paso_active_reclamo");
                        $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoActual + "_activo") + "' />");
                    }
                    else $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoTag) + "' />");
                });

                $('div[id^=Cambio]').hide();
                $('div[id^=Paso]').hide();
                $('[id=Paso' + pasoActual + ']').show();
                $('[id=Paso' + pasoActual + '] #Cambio' + paso2Actual).show();

                me.Funciones.ValidarVisualizacionBannerResumen();
            },

            CambioPaso2: function (paso) {

                paso2Actual = paso2Actual + (paso || 1);
                paso2Actual = paso2Actual < 1 ? 1 : paso2Actual > 3 ? 3 : paso2Actual;
                $('div[id^=Cambio]').hide();
                $('[id=Cambio' + paso2Actual + ']').show();
            },

            ValidarPaso2Faltante: function (codigoSsic) {
                var esCantidadPermitidaValida = me.Funciones.ValidarCantidadMaximaPermitida(codigoSsic);

                if (esCantidadPermitidaValida) {
                    var montoTotalPedido = $("#hdImporteTotalPedido").val();
                    var montoProductosFaltanteActual = me.Funciones.ObtenerMontoProductosDevolver(codigoSsic);
                    var montoCuvActual = (parseFloat($("#txtPrecioUnidad").val()) || 0) * (parseInt($("#txtCantidad").val()) || 0);
                    var montoDevolver = montoProductosFaltanteActual + montoCuvActual;

                    me.Funciones.ObtenerValorParametria(codigoSsic);
                    var valorParametria = $("#hdParametriaCdr").val() || 0;

                    valorParametria = parseFloat(valorParametria);

                    var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

                    if (montoMaximoDevolver < montoDevolver) {
                        //alert_msg(
                        $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error')
                            .text("Por favor, selecciona otra solución, ya que superas el porcentaje de faltante permitido en tu pedido facturado");
                        $('#popupInformacionSB2Error').show();
                        return false;
                    }
                    return true;

                } else
                    return false;
            },

            ValidarPaso2FaltanteAbono: function (codigoSsic) {
                return me.Funciones.ValidarCantidadMaximaPermitida(codigoSsic);
            },

            ValidarCantidadMaximaPermitida: function (codigoSsic) {
                me.Funciones.ObtenerValorCDRWebDatos(codigoSsic);

                var cantidadProductosFaltanteActual = me.Funciones.ObtenerCantidadProductosByCodigoSsic(codigoSsic);
                var cantidadCuvActual = parseInt($("#txtCantidad").val()) || 0;

                var cantidadFaltante = cantidadProductosFaltanteActual + cantidadCuvActual;

                var valorCdrWebDatos = $("#hdCdrWebDatos_Ssic").val() || 0;
                valorCdrWebDatos = parseInt(valorCdrWebDatos);

                if (cantidadFaltante > valorCdrWebDatos) {
                    //alert_msg(
                    $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error')
                        .text("Superas la cantidad máxima permitida de (" + valorCdrWebDatos + ") unidades a reclamar para este servicio postventa, por favor modifica tu solicitud");
                    $('#popupInformacionSB2Error').show();
                    return false;
                }

                return true;
            },

            ValidarPaso2Devolucion: function (codigoSsic) {

                var montoMinimoPedido = $("#hdMontoMinimoPedido").val();
                var montoTotalPedido = $("#hdImporteTotalPedido").val();
                var montoProductosDevolverActual = me.Funciones.ObtenerMontoProductosDevolver(codigoSsic);

                var diferenciaMonto = montoTotalPedido - montoMinimoPedido;
                var montoCuvActual = (parseFloat($("#txtPrecioUnidad").val()) || 0) * (parseInt($("#txtCantidad").val()) || 0);
                var montoDevolver = montoProductosDevolverActual + montoCuvActual;

                if (diferenciaMonto < montoDevolver) {
                    //alert_msg("Por favor, selecciona otra solución, ya que tu pedido está quedando por debajo del monto mínimo permitido");
                    $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error')
                        .text('Por favor, selecciona otra solución, ya que tu pedido está quedando por debajo del monto mínimo permitido');
                    $('#popupInformacionSB2Error').show();
                    return false;
                }

                me.Funciones.ObtenerValorParametria(codigoSsic);
                var valorParametria = $("#hdParametriaCdr").val() || 0;

                valorParametria = parseFloat(valorParametria);
                var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

                if (montoMaximoDevolver < montoDevolver) {
                    //alert_msg(
                    $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error')
                        .text("Por favor, selecciona otra solución, ya que superas el porcentaje de devolución permitido en tu pedido facturado");
                    return false;
                }

                return true;
            },

            ObtenerValorCDRWebDatos: function (codigoSsic) {

                var item = {
                    EstadoSsic: codigoSsic
                };

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/BuscarCdrWebDatos',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data))
                            return false;

                        var cdrWebDatos = data.cdrWebdatos;

                        $("#hdCdrWebDatos_Ssic").val(cdrWebDatos.Valor);
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            },

            ObtenerCantidadProductosByCodigoSsic: function (codigoSsic) {

                var resultado = 0;

                var item = {
                    CDRWebID: $("#CDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoID").val() || 0,
                    EstadoSsic: codigoSsic
                };
                waitingDialog();

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/ObtenerCantidadProductosByCodigoSsic',
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
                            messageInfoValidado(data.message);
                            return false;
                        }

                        resultado = data.cantidadProductos;
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });

                return resultado;
            },

            CargarPropuesta: function (codigoSsic) {

                var tipo = (codigoSsic == "C" || codigoSsic == "D" || codigoSsic == "F" || codigoSsic == "G") ? "canje" : "cambio";

                var item = {
                    CUV: $.trim($("#txtCuv").text()),
                    DescripcionProd: $.trim($("#DescripcionCuv").text()),
                    Cantidad: $.trim($("#txtCantidad").val()),
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
                            messageInfoValidado(data.message);
                            return false;
                        }

                        //$(me.Variables.Registro4).show();
                        if (tipo == "canje") {
                            SetHandlebars("#template-confirmacion", data.detalle, "[data-tipo-confirma='" + tipo + "'] [data-detalle-confirma]");
                            //$("#eleccion").show();
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
                // 
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
                            messageInfoValidado(data.message);
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

                var item = {
                    CDRWebID: $("#CDRWebID").val() || 0,
                    PedidoID: $("#hdPedidoID").val() || 0,
                    NumeroPedido: $("#hdNumeroPedido").val() || 0,
                    CampaniaID: $("#ddlCampania").val() || 0,
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"), //$(".reclamo_motivo_select[data-check='1']").attr("id"),
                    Operacion: $(".solucion_cdr[data-check='1']").attr('id'),
                    CUV: $("#txtCuv").text(),
                    Cantidad: $.trim($("#txtCantidad").val()),
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
                            messageInfoValidado(data.message);
                            return false;
                        }

                        $("#CDRWebID").val(data.detalle);
                        //me.Funciones.CambioPaso();
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
                            messageInfoValidado(data.message);
                            return false;
                        }

                        $("#spnCantidadUltimasSolicitadas").html(data.detalle.length);
                        $(".num_solicitudes").html(data.detalle.length)
                        SetHandlebars("#template-detalle-banner", data, "#divDetalleUltimasSolicitudes");
                        // ValidarVisualizacionBannerResumen();

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
                            messageInfoValidado(data.message);
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

            SolicitudEnviar: function (validarCorreoVacio, validarCelularVacio) {
                var ok = true;
                var correo = $.trim($("#txtEmail").val());
                var celular = $.trim($("#txtTelefono").val());

                if (IfNull(validarCorreoVacio, true) && correo == "") {
                    me.Funciones.ControlSetError('#txtEmail', '#spnEmailError', '*Correo Electrónico incorrecto');
                    ok = false;
                }
                if (IfNull(validarCelularVacio, true) && celular == "") {
                    me.Funciones.ControlSetError('#txtTelefono', '#spnTelefonoError', '*Celular incorrecto');
                    ok = false;
                }
                if (!ok) {
                    //alert_msg("Debe completar la sección de VALIDA TUS DATOS para finalizar");
                    $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error')
                        .text("Debe completar la sección de VALIDA TUS DATOS para finalizar");
                    $('#popupInformacionSB2Error').show();

                    return false;
                }

                if (correo != "" && !validateEmail(correo)) {
                    me.Funciones.ControlSetError('#txtEmail', '#spnEmailError', '*Correo Electrónico incorrecto');
                    ok = false;
                }
                if (celular != "" && celular.length < 6) {
                    me.Funciones.ControlSetError('#txtTelefono', '#spnTelefonoError', '*Celular incorrecto');
                    ok = false;
                }
                if (!ok) return false;

                if (celular != "" && !me.Funciones.ValidarTelefono(celular)) {
                    me.Funciones.ControlSetError('#txtTelefono', '#spnTelefonoError', '*Este número de celular ya está siendo utilizado. Intenta con otro.');
                    return false;
                }

                var correoActual = $.trim($("#hdEmail").val());
                if (correo != "" && correo != correoActual && !ValidarCorreoDuplicado(correo)) {
                    me.Funciones.ControlSetError('#txtEmail', '#spnEmailError', '*Este correo ya está siendo utilizado. Intenta con otro');
                    return false;
                }

                if ($("#politica-devolucion").prop("checked") == false) {
                    //alert_msg
                    $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error')
                        .text("Debe aceptar la política de Cambios y Devoluciones");
                    $('#popupInformacionSB2Error').show();

                    return false;
                }

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
                            messageInfo(data.message);
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

                        $(me.Variables.RegistroAceptarSolucion).hide();
                        $(me.Variables.SolicitudEnviada).show();

                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        if (checkTimeout(data)) { }
                    }
                });
            },

            ValidarTelefono: function () {
                var resultado = false;
                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/ValidadTelefonoConsultora',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ Telefono: $("#txtTelefono").val() }),
                    async: false,
                    cache: false,
                    success: function (data) {
                        closeWaitingDialog();
                        if (!checkTimeout(data)) resultado = false;
                        else resultado = data.success;
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        checkTimeout(data);
                    }
                });
                return resultado;
            },

            ControlSetError: function (inputId, spanId, message) {
                if (IfNull(message, '') == '') {
                    $(inputId).css('border-color', '#b5b5b5');
                    $(spanId).css('display', 'none');
                }
                else {
                    $(inputId).css('border-color', 'red');
                    $(spanId).css('display', '');
                    $(spanId).html(message);
                }
            },

            DetalleAccion: function (obj) {

                var accion = $.trim($(obj).attr("data-accion"));
                if (accion == "") {
                    return false;
                }

                if (accion == "x") {
                    var pedidodetalleid = $.trim($(obj).attr("data-pedidodetalleid"));

                    var item = {
                        CDRWebDetalleID: pedidodetalleid
                    };

                    var functionEliminar = function () {
                        me.Funciones.DetalleEliminar(item);
                    };
                    messageInfoValidado("Se eliminará el registro seleccionado. <br/>¿Deseas continuar?", functionEliminar);
                }
            },

            DetalleEliminar: function (objItem) {
                var item = {
                    CDRWebDetalleID: objItem.CDRWebDetalleID
                };

                waitingDialog();

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'MisReclamos/DetalleEliminar',
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

                        if (data.success == true) {
                            me.Funciones.DetalleCargar();
                        }
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
