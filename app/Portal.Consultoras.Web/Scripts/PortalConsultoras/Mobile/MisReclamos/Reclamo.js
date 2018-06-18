var cuvKeyUp = false;
var cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';
var pasoActual = 1;
var paso2Actual = 1;
var misReclamosRegistro;
var listaPedidos = new Array();

$(document).ready(function () {
    'use strict';

    var PortalConsultorasReclamoRegistro;

    PortalConsultorasReclamoRegistro = function () {
        var me = this;

        me.Variables = {
            aCambiarProducto: "#aCambiarProducto",
            aCambiarProducto2: "#aCambiarProducto2",
            alturaListaMiSolicitud: $(document).height(),
            btn_ver_solicitudes: "#btn_ver_solicitudes",
            btnAceptarSolucion: "[data-cambiopaso]",
            btnCambioProducto: "#btnCambioProducto",
            btnSiguiente1: "#btnSiguiente1",
            btnSiguiente4: "#btnSiguiente4",
            Cambio3: "#Cambio3",
            ComboCampania: "#ddlCampania",
            content_solicitud_cdr: ".content_solicitud_cdr",
            datosSolicitudOpened: ".datos_solicitud_opened",
            DescripcionCuv: "#DescripcionCuv",
            DescripcionCuv2: "#DescripcionCuv2",
            divDetalleEnviar: "#divDetalleEnviar",
            divDetallePaso3: "#divDetallePaso3",
            divDetalleUltimasSolicitudes: "#divDetalleUltimasSolicitudes",
            divlistado_soluciones_cdr: "#divlistado_soluciones_cdr",
            divProcesoReclamo: "#divProcesoReclamo",
            divUltimasSolicitudes: "#divUltimasSolicitudes",
            enlace_ir_al_final: ".enlace_ir_al_final",
            Enlace_regresar: ".enlace_regresar",
            hdCDRID: "#CDRWebID",
            hdCdrWebDatos_Ssic: "#hdCdrWebDatos_Ssic",
            hdEmail: "#hdEmail",
            hdImporteTotal2: "#hdImporteTotal2",
            hdImporteTotalPedido: "#hdImporteTotalPedido",
            hdMontoMinimoPedido: "#hdMontoMinimoPedido",
            hdMontoMinimoReclamo: "#hdMontoMinimoReclamo",
            hdNumeroPedido: "#hdNumeroPedido",
            hdParametriaAbsCdr: "#hdParametriaAbsCdr",
            hdParametriaCdr: "#hdParametriaCdr",
            hdPedidoID: "#hdPedidoID",
            IrSolicitudInicial: "#IrSolicitudInicial",
            listado_soluciones_cdr: ".listado_soluciones_cdr",
            listadoProductosAgregados: ".listado_productos_agregados",
            listaMotivos: "#listaMotivos",
            miSolicitudCDR: ".mi_solicitud_cdr",
            numSolicitudes: ".num_solicitudes",
            ocultar_mi_solicitud: ".ocultar_mi_solicitud",
            paso_active_reclamo: "paso_active_reclamo",
            pasodos: "#pasodos",
            pasodosactivo: "#pasodosactivo",
            pasotres: "#pasotres",
            pasotresactivo: "#pasotresactivo",
            pestaniaVerMiSolicitud: ".pestania_ver_mi_solicitud",
            politica_devolucion: "#politica-devolucion",
            producto_agregado: ".producto_agregado",
            Registro1: ".Registro1",
            Registro2: ".Registro2",
            Registro3: ".Registro3",
            Registro4: ".Registro4",
            RegistroAceptarSolucion: ".AceptarSolucion",
            SolicitudEnviada: "#SolicitudEnviada",
            solucion_cdr: ".solucion_cdr",
            spnCantidadCuv1: "#spnCantidadCuv1",
            spnCantidadCuv2: "#spnCantidadCuv2",
            spnCantidadUltimasSolicitadas: "#spnCantidadUltimasSolicitadas",
            spnCuv1: "#spnCuv1",
            spnCuv2: "#spnCuv2",
            spnDescripcionCuv1: "#spnDescripcionCuv1",
            spnDescripcionCuv2: "#spnDescripcionCuv2",
            spnEmailError: "#spnEmailError",
            spnMensajeTenerEnCuentaCambio: "#spnMensajeTenerEnCuentaCambio",
            spnMontoMinimoReclamoFormato: "#spnMontoMinimoReclamoFormato",
            spnNumeroCampaniaReclamo: "#spnNumeroCampaniaReclamo",
            spnSimboloMonedaCuv2: "#spnSimboloMonedaCuv2",
            spnSimboloMonedaReclamo: "#spnSimboloMonedaReclamo",
            spnSolicitudCampania: "#spnSolicitudCampania",
            spnSolicitudFechaCulminado: "#spnSolicitudFechaCulminado",
            spnSolicitudNumeroSolicitud: "#spnSolicitudNumeroSolicitud",
            spnTelefonoError: "#spnTelefonoError",
            textoMensajeCDR: ".texto-mensaje-cdr",
            TituloReclamo: "#TituloReclamo",
            txtCantidad1: "#txtCantidad1",
            txtCantidad2: "#txtCantidad2",
            txtCuv: "#txtCuv",
            txtCuv2: "#txtCuv2",
            txtCuvMobile: "#cuvmobile",
            txtCuvMobile2: "#cuvmobile2",
            txtDescripcionCuv: "#txtDescripcionCuv",
            txtDescripcionCuv2: "#txtDescripcionCuv2",
            txtEmail: "#txtEmail",
            txtPrecioCuv2: "#txtPrecioCuv2",
            txtPrecioUnidad: "#txtPrecioUnidad",
            txtTelefono: "#txtTelefono",
            UltimasSolicitudes: ".UltimasSolicitudes",
            modificarPrecioMas: ".modificarPrecioMas",
            modificarPrecioMenos: ".modificarPrecioMenos",
            hdCuvPrecio2: "#hdCuvPrecio2",
            enlace_quiero_ver_otra_alternativa: ".enlace_quiero_ver_otra_alternativa",
            footer_page: ".footer-page",
            wrpMobile: "#wrpMobile",
            pb120: "pb-120"
        };

        me.Eventos = {
            bindEvents: function () {
                $(me.Variables.footer_page).hide();

                var pedidoId = parseInt($(me.Variables.hdPedidoID).val());
                if (pedidoId != 0) {
                    ShowLoading();
                    me.Funciones.DetalleCargar();
                    $(me.Variables.btnSiguiente4).show();
                    $(me.Variables.RegistroAceptarSolucion).show();
                    $(me.Variables.Cambio3).hide();
                    $(me.Variables.pasodos).hide();
                    $(me.Variables.pasotres).hide();
                    $(me.Variables.pasodosactivo).show();
                    $(me.Variables.pasotresactivo).show();

                    if ($(me.Variables.Registro1).is(":visible")) {
                        $(me.Variables.Registro1).hide();
                    }
                }

                // Agregar otro producto.
                $(me.Variables.IrSolicitudInicial).click(function () {

                    if (mensajeGestionCdrInhabilitada != '') {
                        messageInfoValidado(mensajeGestionCdrInhabilitada);
                        return false;
                    }

                    //El if se hizo con !() para considerar posibles valores null o undefined de $('#ddlCampania').val()
                    if (!($(me.Variables.ComboCampania).val() > 0)) {
                        messageInfoValidado(mensajeCdrFueraDeFechaCompleto);
                        return false;
                    }

                    $(me.Variables.txtCuvMobile).val("");
                    $(me.Variables.txtDescripcionCuv).html("");
                    $(me.Variables.txtCantidad1).val("1");
                    $(me.Variables.txtCuvMobile2).val("");
                    $(me.Variables.txtPrecioCuv2).html("");
                    $(me.Variables.spnSimboloMonedaCuv2).html("");
                    $(me.Variables.hdImporteTotal2).val(0);
                    $(me.Variables.txtDescripcionCuv2).html("");
                    $(me.Variables.txtCantidad2).val("1");
                    me.Funciones.CambioPaso(-100);
                    me.Funciones.BuscarMotivo();

                    $(me.Variables.divUltimasSolicitudes).show();
                    $(me.Variables.Registro1).show();
                    $(me.Variables.btnSiguiente1).show();

                    $(me.Variables.RegistroAceptarSolucion).hide();
                    $(me.Variables.btnSiguiente4).hide();

                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();

                    $(me.Variables.DescripcionCuv2).hide();
                    $(me.Variables.txtCuvMobile2).fadeIn();

                    $(me.Variables.pasodosactivo).hide();
                    $(me.Variables.pasotresactivo).hide();
                    $(me.Variables.pasodos).show();
                    $(me.Variables.pasotres).show();

                    $(me.Variables.ComboCampania).attr("disabled", "disabled");
                });

                $(me.Variables.miSolicitudCDR).click(function (e) {
                    e.stopPropagation();

                    var detalles = $(me.Variables.divDetalleUltimasSolicitudes + " " + me.Variables.producto_agregado).length || 0;
                    (detalles == 0) ? $(me.Variables.enlace_ir_al_final).hide() : $(me.Variables.enlace_ir_al_final).show();

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

                $(me.Variables.ocultar_mi_solicitud).click(function (e) {

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

                $(me.Variables.enlace_ir_al_final + " a").click(function (e) {

                    e.preventDefault();
                    $(me.Variables.listadoProductosAgregados).animate({
                        scrollTop: me.Variables.alturaListaMiSolicitud + "px"
                    }, 500);

                    $(me.Variables.Registro1).hide();
                    $(me.Variables.btnSiguiente1).hide();
                    $(me.Variables.RegistroAceptarSolucion).show();
                    $(me.Variables.btnSiguiente4).show();
                });

                $(me.Variables.listado_soluciones_cdr).on('click', me.Variables.solucion_cdr, function () {

                    $(me.Variables.solucion_cdr).attr("data-check", "0");

                    var id = $.trim($(this).attr("id"));
                    if (id == "") return false;

                    $(this).attr("data-check", "1");
                    me.Funciones.AnalizarOperacion(id);
                });

                $(me.Variables.UltimasSolicitudes).on('click', 'a[data-accion]', function (e) {

                    e.preventDefault(); // prevents the <a> from navigating                  
                    me.Funciones.DetalleAccion(this);
                });

                $(me.Variables.ComboCampania).on("change", function () {
                    $(me.Variables.hdPedidoID).val(0);
                    $(me.Variables.hdNumeroPedido).val(0);
                });

                $(me.Variables.txtCuvMobile).on('keyup', function (evt) {
                    cuvKeyUp = true;
                    me.Funciones.EvaluarCUV();
                });

                setInterval(function () {
                    if (cuvKeyUp) cuvKeyUp = false;
                    else me.Funciones.EvaluarCUV();

                    if (cuv2KeyUp) cuv2KeyUp = false;
                    else me.Funciones.EvaluarCUV2();
                }, 1000)

                $(me.Variables.aCambiarProducto).click(function (e) {

                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();
                    $(me.Variables.txtCuvMobile).focus();
                });

                $(me.Variables.aCambiarProducto2).click(function (e) {
                    $(me.Variables.DescripcionCuv2).hide();
                    $(me.Variables.txtCuvMobile2).fadeIn();
                    $(me.Variables.txtCuvMobile2).focus();
                });

                $(me.Variables.btnSiguiente1).click(function (e) {

                    if ($(me.Variables.Registro1).is(":visible")) {
                        if (me.Funciones.ValidarCUVCampania()) {
                            $(me.Variables.Enlace_regresar).show();
                            me.Funciones.BuscarMotivo();

                            $(me.Variables.pasodos).hide();
                            $(me.Variables.Registro1).hide();
                            $(me.Variables.pasodosactivo).show();
                            $(me.Variables.Registro2).show();
                            return false;
                        }
                    }

                    if ($(me.Variables.Registro2).is(":visible")) {
                        $(me.Variables.txtDescripcionCuv2).val('')
                        $(me.Variables.txtCuv2).html('');
                        $(me.Variables.txtPrecioCuv2).html('');

                        if (me.Funciones.ValidarPaso1()) {
                            paso2Actual = 1;
                            me.Funciones.CargarOperacion();

                            $(me.Variables.Registro2).hide();
                            $(me.Variables.Registro3).show();
                            $(me.Variables.btnSiguiente1).hide();
                        }
                    }
                });

                $(me.Variables.btnAceptarSolucion).click(function () {
                    me.Funciones.DetalleGuardar();

                    $(me.Variables.wrpMobile).removeClass(me.Variables.pb120);
                    $(me.Variables.Cambio3).hide();
                    $(me.Variables.Registro4).hide();
                    $(me.Variables.btnAceptarSolucion).hide();
                    $(me.Variables.pasotres).hide();
                    $(me.Variables.Enlace_regresar).hide();

                    $(me.Variables.pasotresactivo).show();
                    $(me.Variables.btnSiguiente4).show();
                    $(me.Variables.RegistroAceptarSolucion).show();
                });

                $(me.Variables.Enlace_regresar).click(function (e) {
                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro3).hide();
                    $(me.Variables.Registro4).hide();
                    $(me.Variables.Cambio3).hide();
                    $(me.Variables.pasodosactivo).hide();
                    $(me.Variables.pasotresactivo).hide();

                    $(me.Variables.Enlace_regresar).hide();
                    $(me.Variables.btnAceptarSolucion).hide();
                    $(me.Variables.btnCambioProducto).hide();
                    $(me.Variables.pasodos).show();
                    $(me.Variables.pasotres).show();

                    $(me.Variables.txtCuvMobile).val("");
                    $(me.Variables.txtCantidad1).val("1");
                    $(me.Variables.txtCuvMobile2).val("");
                    $(me.Variables.txtPrecioCuv2).html("");
                    $(me.Variables.txtCantidad2).val("1");

                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();

                    $(me.Variables.DescripcionCuv2).hide();
                    $(me.Variables.txtCuvMobile2).fadeIn();

                    paso2Actual = 1

                    $(me.Variables.btnSiguiente1).show();
                    $(me.Variables.Registro1).show();
                });

                $(me.Variables.btnSiguiente4).click(function () {
				 
                    if (mensajeGestionCdrInhabilitada != '') {
                        messageInfoValidado(mensajeGestionCdrInhabilitada);
                        return false;
                    }

                    var cantidadDetalle = $(me.Variables.divDetallePaso3 + " " + me.Variables.content_solicitud_cdr).length || 0;

                    if (cantidadDetalle == 0) {
                        messageInfoValidado(me.Constantes.NoCuentaConRegistros,
                            function () {
                                window.location = urlRegresar;
                            });

                        return false;
                    }

                    $(me.Variables.ComboCampania).removeAttr("disabled");
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
                    if (me.Funciones.ValidarPaso2Trueque()) {
                        me.Funciones.CambioPaso2(1);
                        $(me.Variables.btnCambioProducto).hide();
                        $(me.Variables.btnAceptarSolucion).show();

                        $(me.Variables.spnCuv1).html($(me.Variables.txtCuvMobile).val());
                        $(me.Variables.spnDescripcionCuv1).html($(me.Variables.txtDescripcionCuv).html());
                        $(me.Variables.spnCantidadCuv1).html($(me.Variables.txtCantidad1).val());

                        $(me.Variables.spnCuv2).html($(me.Variables.txtCuvMobile2).val());
                        $(me.Variables.spnDescripcionCuv2).html($(me.Variables.txtDescripcionCuv2).html());
                        $(me.Variables.spnCantidadCuv2).html($(me.Variables.txtCantidad2).val());
                    }
                });

                $(me.Variables.modificarPrecioMas).click(function (evt) {
                    var precio = $(me.Variables.hdCuvPrecio2).val();
                    var cantidad = parseInt($(me.Variables.txtCantidad2).val());

                    cantidad = cantidad == 99 ? 99 : cantidad + 1;

                    var importeTotal = precio * cantidad;

                    $(me.Variables.hdImporteTotal2).val(importeTotal);
                    $(me.Variables.txtPrecioCuv2).html(DecimalToStringFormat(importeTotal));
                });

                $(me.Variables.modificarPrecioMenos).click(function (evt) {
                    var precio = $(me.Variables.hdCuvPrecio2).val();
                    var cantidad = parseInt($(me.Variables.txtCantidad2).val());

                    cantidad = cantidad == 1 ? 1 : cantidad - 1;

                    var importeTotal = precio * cantidad;

                    $(me.Variables.hdImporteTotal2).val(importeTotal);
                    $(me.Variables.txtPrecioCuv2).html(DecimalToStringFormat(importeTotal));
                });

                $(me.Variables.enlace_quiero_ver_otra_alternativa).click(function (evt) {
                    $(me.Variables.Registro4).hide();
                    $(me.Variables.btnAceptarSolucion).hide();
                    $(me.Variables.Registro3).show();
                })
            }
        };

        me.Constantes = {
            DebeAceptarSeccionValidaTusDatos: "Debe completar la sección de VALIDA TUS DATOS para finalizar",
            DebeAceptarPoliticaCambios: "Debe aceptar la política de Cambios y Devoluciones",
            NoCuentaConRegistros: "No se puede finalizar la solicitud porque no cuenta con registros",
            SeleccionaOtraSoluccionPorcentajeFaltante: "Por favor, selecciona otra solución, ya que superas el porcentaje de faltante permitido en tu pedido facturado",
            SeleccionaOtraSoluccionMontoMinimo: "Por favor, selecciona otra solución, ya que tu pedido está quedando por debajo del monto mínimo permitido",
            SeleccionaOtraSoluccionSuperasPorcentaje: "Por favor, selecciona otra solución, ya que superas el porcentaje de devolución permitido en tu pedido facturado"
        };

        me.Funciones = {

            ValidarPaso2Trueque: function () {
                var ok = true;
                ok = $.trim($(me.Variables.txtCuvMobile2).val()).length == "5" ? ok : false;
                ok = $.trim($(me.Variables.txtDescripcionCuv2).html()) != "" ? ok : false;
                ok = $.trim($(me.Variables.txtPrecioCuv2).html()) != "" ? ok : false;

                var montoMinimoReclamo = $(me.Variables.hdMontoMinimoReclamo).val();
                var montoPedidoTrueque = $(me.Variables.hdImporteTotal2).val();

                ShowLoading();

                var item = {
                    PedidoID: $(me.Variables.hdPedidoID).val(),
                    CUV: $.trim($(me.Variables.txtCuvMobile2).val()),
                    Cantidad: $.trim($(me.Variables.txtCantidad2).val()),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    CampaniaID: $(me.Variables.ComboCampania).val()
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlValidarNoPack,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        CloseLoading();

                        ok = data.success;

                        if (!data.success && data.message != "") {
                            messageInfoValidado(data.message);
                            return false;
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
                var valorParametria = $(me.Variables.hdParametriaCdr).val();
                var valorParametriaAbs = $(me.Variables.hdParametriaAbsCdr).val();
                
                if (valorParametriaAbs == "1") {
                    var diferencia = parseFloat(montoMinimoReclamo) - parseFloat(montoPedidoTrueque);
                    if (diferencia > parseInt(valorParametria)) {
                        messageInfoValidado("Diferencia en trueques excede lo permitido");
                        return false;
                    }
                } else {
                    if (valorParametriaAbs == "2") {
                        if (montoPedidoTrueque < montoMinimoReclamo) {
                            messageInfoValidado("Está devolviendo menos de lo permitido");
                            return false;
                        }
                    } else {
                        var diferencia2 = parseFloat(montoMinimoReclamo) - parseFloat(montoPedidoTrueque);
                        diferencia2 = Math.abs(diferencia2);

                        if (diferencia2 > parseInt(valorParametria)) {
                            messageInfoValidado("Diferencia en trueques excede lo permitido");
                            return false;
                        }
                    }
                }
                return ok;
            },

            EvaluarCUV: function () {

                if (!me.Funciones.CUVCambio()) return false;

                $(me.Variables.txtCantidad1).attr("disabled", "disabled");
                $(me.Variables.txtCantidad1).attr("data-maxvalue", "0");
                $(me.Variables.txtDescripcionCuv).html("");

                if (cuvPrevVal.length == 5) {
                    me.Funciones.BuscarCUV(cuvPrevVal);
                }
            },

            BuscarCUV: function (CUV) {
                ShowLoading();
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
                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            messageInfoValidado(data.message);
                            return false;
                        }

                        data.detalle = data.detalle || new Array();
						if (data.detalle.length <= 0) {
							if (flagAppMobile == 0) {
								messageInfoError("Producto no disponible para atención por este medio, comunícate con el <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
							} else {
								messageInfoError("Producto no disponible para atención por este medio.");
							}
                        } else {
                            if (data.detalle.length > 1) {
                                me.Funciones.PopupPedido(data.detalle);
                            }
                            else {
                                me.Funciones.AsignarCUV(data.detalle[0]);
                            }
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                        checkTimeout(data);
                    }
                });
            },

            AsignarCUV: function (pedido) {
                pedido = pedido || new Object();

				if (pedido.CDRWebID > 0 && pedido.CDRWebEstado != 1 && pedido.CDRWebEstado != 4) {
					if (flagAppMobile == 0) {
						messageInfoError("Lo sentimos, ya cuentas con una solicitud web para este pedido. Por favor, contáctate con nuestro <span class='enlace_chat belcorpChat'><a>Chat en Línea</a></span>.");
					} else {
						messageInfoError("Lo sentimos, ya cuentas con una solicitud web para este pedido.");
					}
                    return false;

                } else {
                    pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
                    var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $(me.Variables.txtCuvMobile).val() || "");
                    var data = detalle.length > 0 ? detalle[0] : new Object();

                    $(me.Variables.txtCantidad1).removeAttr("disabled");
                    $(me.Variables.txtCantidad1).attr("data-maxvalue", data.Cantidad);
                    $(me.Variables.hdPedidoID).val(data.PedidoID);
                    $(me.Variables.hdNumeroPedido).val(pedido.NumeroPedido);

                    $(me.Variables.txtPrecioUnidad).val(data.PrecioUnidad);
                    $(me.Variables.hdImporteTotalPedido).val(pedido.ImporteTotal);
                    $(me.Variables.hdCDRID).val(pedido.CDRWebID);

                    /*Seteando cuv y descripcion*/
                    $(me.Variables.txtCuv).html(data.CUV);
                    $(me.Variables.txtDescripcionCuv).html(data.DescripcionProd);

                    $(me.Variables.txtCuvMobile).hide();
                    $(me.Variables.DescripcionCuv).fadeIn();
                }
            },

            CUVCambio: function () {
                var cuvVal = $(me.Variables.txtCuvMobile).val();
                if (cuvVal == null) cuvVal = '';
                if (cuvVal.length > 5) {
                    cuvVal = cuvVal.substr(0, 5);
                    $(me.Variables.txtCuvMobile).val(cuvVal);
                }

                var cambio = (cuvVal != cuvPrevVal);
                cuvPrevVal = cuvVal;
                return cambio;
            },

            EvaluarCUV2: function () {

                if (!me.Funciones.CUV2Cambio()) return false;

                if (cuv2PrevVal.length == 5) me.Funciones.BuscarCUVCambiar(cuv2PrevVal);
                else {
                    $(me.Variables.txtDescripcionCuv2).html("");
                    $(me.Variables.txtPrecioCuv2).html("");
                    $(me.Variables.hdImporteTotal2).val(0);
                    $(me.Variables.btnCambioProducto).addClass("disabledClick");
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
                var CampaniaId = $.trim($(me.Variables.ComboCampania).val()) || 0;
                if (CampaniaId <= 0 || cuv.length < 5)
                    return false;

                var PedidoId = $.trim($(me.Variables.hdPedidoID)) || 0;

                var item = {
                    CampaniaID: CampaniaId,
                    PedidoID: PedidoId,
                    CDRWebID: $(me.Variables.hdCDRID).val(),
                    CUV: cuv
                };

                ShowLoading();

                jQuery.ajax({
                    type: 'POST',
                    url: UrlBuscarCuvCambiar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data[0].MarcaID != 0) {
                            /*Seteando cuv y descripcion*/

                            var descripcion = data[0].Descripcion;
                            var precio = data[0].PrecioCatalogo;
                            var cuv2 = data[0].CUV;

                            $(me.Variables.txtCuv2).html(cuv2);
                            $(me.Variables.txtDescripcionCuv2).html(descripcion);
                            $(me.Variables.spnSimboloMonedaCuv2).html(variablesPortal.SimboloMoneda);
                            $(me.Variables.txtPrecioCuv2).html(DecimalToStringFormat(precio));
                            $(me.Variables.hdCuvPrecio2).val(precio);

                            $(me.Variables.txtCuvMobile2).hide();
                            $(me.Variables.DescripcionCuv2).fadeIn();

                            var cantidad = $(me.Variables.txtCantidad2).val();
                            $(me.Variables.hdImporteTotal2).val(precio * cantidad);
                        } else {
                            $(me.Variables.txtDescripcionCuv2).html("");
                            $(me.Variables.txtPrecioCuv2).val("");
                            $(me.Variables.hdImporteTotal2).val(0);
                            messageInfoValidado(data[0].CUV);
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            BuscarMotivo: function () {

                var PedidoId = $.trim($(me.Variables.hdPedidoID).val()) || 0;
                var CampaniaId = $.trim($(me.Variables.ComboCampania).val()) || 0;
                if (PedidoId <= 0 || CampaniaId <= 0)
                    return false;
                ShowLoading();
                var item = {
                    CampaniaID: $.trim($(me.Variables.ComboCampania).val()),
                    PedidoID: PedidoId
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlBuscarMotivo,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            messageInfoValidado(data.message);
                            return false;
                        }

                        SetHandlebars("#template-motivo", data.detalle, me.Variables.listaMotivos);
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            ValidarCUVCampania: function () {
                var ok = true;
                ok = $.trim($(me.Variables.hdPedidoID).val()) > 0 ? ok : false;
                ok = $(me.Variables.ComboCampania).val() > 0 ? ok : false;
                ok = $.trim($(me.Variables.txtCuvMobile).val()) != "" ? ok : false;

                if (!ok) {
                    messageInfoValidado("Datos incorrectos");
                    return false;
                }
                return ok;
            },

            RegresarRegistro1: function () {
                $(me.Variables.Registro2).hide();
                $(me.Variables.pasodosactivo).hide();
                $(me.Variables.pasodos).show();
                $(me.Variables.Registro1).show();
            },

            ValidarPaso1: function () {
                var ok = true;
                ok = $.trim($(me.Variables.hdPedidoID).val()) > 0 ? ok : false;
                ok = $(me.Variables.ComboCampania).val() > 0 ? ok : false;
                ok = $.trim($(me.Variables.txtCuvMobile).val()) != "" ? ok : false;

                ok = $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").size() == 0 ? false : ok;

                if (!ok) {
                    messageInfoValidado("Datos incorrectos");
                    me.Funciones.RegresarRegistro1();
                    return false;
                }

                if (!($.trim($(me.Variables.txtCantidad1).val()) > 0 && $.trim($(me.Variables.txtCantidad1).val()) <= $.trim($(me.Variables.txtCantidad1).attr("data-maxvalue")))) {
                    messageInfoValidado("Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
                        $.trim($(me.Variables.txtCantidad1).attr("data-maxvalue")) + ")");
                    me.Funciones.RegresarRegistro1();
                    return false;
                }

                var item = {
                    PedidoID: $(me.Variables.hdPedidoID).val(),
                    CUV: $(me.Variables.txtCuvMobile).val(),
                    Cantidad: $.trim($(me.Variables.txtCantidad1).val()),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    CampaniaID: $(me.Variables.ComboCampania).val()
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlValidarPaso1,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (checkTimeout(data)) {
                            ok = data.success;

                            if (!data.success && data.message != "") {
                                me.Funciones.RegresarRegistro1();
                                messageInfoValidado(data.message);
                            }
                        }
                    },
                    error: function (data, error) {
                        CloseLoading()
                    }
                });

                return ok;

            },

            AnalizarOperacion: function (id) {

                if (id == "C") {
                    $("[data-tipo-confirma='cambio']").hide();
                    $("[data-tipo-confirma=canje]").show();

                    me.Funciones.CargarPropuesta(id);
                    $(me.Variables.Registro3).hide();
                    $(me.Variables.btnAceptarSolucion).show();
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
                        $("[data-tipo-confirma='cambio']").hide();
                        $("[data-tipo-confirma=canje]").show();

                        me.Funciones.CargarPropuesta(id);
                        $(me.Variables.Registro3).hide();
                        $(me.Variables.btnAceptarSolucion).show()
                    }
                }

                if (id == "G") {
                    if (me.Funciones.ValidarPaso2FaltanteAbono(id)) {
                        $("[data-tipo-confirma='cambio']").hide();
                        $("[data-tipo-confirma=canje]").show();

                        $(me.Variables.Registro3).hide();
                        me.Funciones.CargarPropuesta(id);
                        $(me.Variables.btnAceptarSolucion).show();
                    }
                }

                if (id == "T") {
                    me.Funciones.CambioPaso2();
                    $("[data-tipo-confirma='canje']").hide();
                    $("[data-tipo-confirma=cambio]").show();
                    $(me.Variables.wrpMobile).addClass(me.Variables.pb120);

                    $(me.Variables.spnSimboloMonedaReclamo).html(variablesPortal.SimboloMoneda);

                    var precioUnidad = $(me.Variables.txtPrecioUnidad).val();
                    var cantidad = $(me.Variables.txtCantidad1).val();
                    var totalTrueque = parseFloat(precioUnidad) * parseFloat(cantidad);

                    $(me.Variables.hdMontoMinimoReclamo).val(totalTrueque);
                    $(me.Variables.spnMontoMinimoReclamoFormato).html(DecimalToStringFormat(totalTrueque));

                    var campania = $(me.Variables.ComboCampania).val() || 0;
                    var numeroCampania = '00';
                    if (campania > 0) {
                        numeroCampania = campania.substring(4);
                    }
                    $(me.Variables.Registro3).hide();

                    $(me.Variables.spnNumeroCampaniaReclamo).html(numeroCampania);
                    $(me.Variables.btnCambioProducto).show();

                    me.Funciones.ObtenerValorParametria(id);
                    me.Funciones.CargarPropuesta(id);
                }
            },

            CambioPaso: function (paso) {
                paso = paso || 1;
                pasoActual = pasoActual + paso || 1;
                pasoActual = pasoActual < 1 ? 1 : pasoActual > 3 ? 3 : pasoActual;

                $(".paso_reclamo[data-paso]").removeClass(me.Variables.paso_active_reclamo);
                $(".paso_reclamo[data-paso] span").html("");

                $(".paso_reclamo[data-paso]").each(function (ind, tag) {
                    var pasoTag = $(tag).attr("data-paso");
                    if (pasoTag < pasoActual) {
                        $(tag).addClass(me.Variables.paso_active_reclamo);
                        $(tag).find("span").html("<img src='" + imgCheck + "' />");
                    }
                    else if (pasoTag == pasoActual) {
                        $(tag).addClass(me.Variables.paso_active_reclamo);
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
                    var montoTotalPedido = $(me.Variables.hdImporteTotalPedido).val();
                    var montoProductosFaltanteActual = me.Funciones.ObtenerMontoProductosDevolver(codigoSsic);
                    var montoCuvActual = (parseFloat($(me.Variables.txtPrecioUnidad).val()) || 0) * (parseInt($(me.Variables.txtCantidad1).val()) || 0);
                    var montoDevolver = montoProductosFaltanteActual + montoCuvActual;

                    me.Funciones.ObtenerValorParametria(codigoSsic);
                    var valorParametria = $(me.Variables.hdParametriaCdr).val() || 0;

                    valorParametria = parseFloat(valorParametria);

                    var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

                    if (montoMaximoDevolver < montoDevolver) {
                        messageInfoError(me.Constantes.SeleccionaOtraSoluccionPorcentajeFaltante);

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
                var cantidadCuvActual = parseInt($(me.Variables.txtCantidad1).val()) || 0;

                var cantidadFaltante = cantidadProductosFaltanteActual + cantidadCuvActual;

                var valorCdrWebDatos = $(me.Variables.hdCdrWebDatos_Ssic).val() || 0;
                valorCdrWebDatos = parseInt(valorCdrWebDatos);

                if (cantidadFaltante > valorCdrWebDatos) {
                    messageInfoError("Superas la cantidad máxima permitida de (" + valorCdrWebDatos + ") unidades a reclamar para este servicio postventa, por favor modifica tu solicitud");
                    return false;
                }

                return true;
            },

            ValidarPaso2Devolucion: function (codigoSsic) {

                var montoMinimoPedido = $(me.Variables.hdMontoMinimoPedido).val();
                var montoTotalPedido = $(me.Variables.hdImporteTotalPedido).val();
                var montoProductosDevolverActual = me.Funciones.ObtenerMontoProductosDevolver(codigoSsic);

                var diferenciaMonto = montoTotalPedido - montoMinimoPedido;
                var montoCuvActual = (parseFloat($(me.Variables.txtPrecioUnidad).val()) || 0) * (parseInt($(me.Variables.txtCantidad1).val()) || 0);
                var montoDevolver = montoProductosDevolverActual + montoCuvActual;

                if (diferenciaMonto < montoDevolver) {
                    messageInfoError(me.Constantes.SeleccionaOtraSoluccionMontoMinimo);

                    return false;
                }

                me.Funciones.ObtenerValorParametria(codigoSsic);
                var valorParametria = $(me.Variables.hdParametriaCdr).val() || 0;

                valorParametria = parseFloat(valorParametria);
                var montoMaximoDevolver = montoTotalPedido * valorParametria / 100;

                if (montoMaximoDevolver < montoDevolver) {
                    messageInfoError(me.Constantes.SeleccionaOtraSoluccionSuperasPorcentaje);
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
                    url: UrlBuscarCdrWebDatos,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        if (!checkTimeout(data))
                            return false;

                        var cdrWebDatos = data.cdrWebdatos;

                        $(me.Variables.hdCdrWebDatos_Ssic).val(cdrWebDatos.Valor);
                    },
                    error: function (data, error) { }
                });
            },

            ObtenerCantidadProductosByCodigoSsic: function (codigoSsic) {

                var resultado = 0;

                var item = {
                    CDRWebID: $(me.Variables.hdCDRID).val() || 0,
                    PedidoID: $(me.Variables.hdPedidoID).val() || 0,
                    EstadoSsic: codigoSsic
                };
                ShowLoading();

                jQuery.ajax({
                    type: 'POST',
                    url: UrlObtenerCantidadProductosByCodigoSsic,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success != true) {
                            messageInfoValidado(data.message);
                            return false;
                        }

                        resultado = data.cantidadProductos;
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });

                return resultado;
            },

            CargarPropuesta: function (codigoSsic) {

                var tipo = (codigoSsic == "C" || codigoSsic == "D" || codigoSsic == "F" || codigoSsic == "G") ? "canje" : "cambio";

                var item = {
                    CUV: $.trim($(me.Variables.txtCuv).text()),
                    DescripcionProd: $.trim($(me.Variables.txtDescripcionCuv).text()),
                    Cantidad: $.trim($(me.Variables.txtCantidad1).val()),
                    EstadoSsic: $.trim(codigoSsic)
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlBuscarPropuesta,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {

                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            messageInfoValidado(data.message);
                            return false;
                        }


                        if (tipo == "canje") {
                            SetHandlebars("#template-confirmacion", data.detalle, "[data-tipo-confirma='" + tipo + "'] [data-detalle-confirma]");
                        }

                        $(me.Variables.spnMensajeTenerEnCuentaCambio).html(data.descripcionTenerEnCuenta);
                    },
                    error: function (data, error) { }
                });
            },

            CargarOperacion: function () {
                var item = {
                    CampaniaID: $.trim($(me.Variables.ComboCampania).val()),
                    PedidoID: $(me.Variables.hdPedidoID).val(),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id")
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlBuscarOperacion,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success == false) {
                            messageInfoValidado(data.message);
                            return false;
                        }
                        SetHandlebars("#template-operacion", data.detalle, me.Variables.divlistado_soluciones_cdr);
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            DetalleGuardar: function () {

                var item = {
                    CDRWebID: $(me.Variables.hdCDRID).val() || 0,
                    PedidoID: $(me.Variables.hdPedidoID).val() || 0,
                    NumeroPedido: $(me.Variables.hdNumeroPedido).val() || 0,
                    CampaniaID: $(me.Variables.ComboCampania).val() || 0,
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    Operacion: $(".solucion_cdr[data-check='1']").attr('id'),
                    CUV: $(me.Variables.txtCuv).html(),
                    Cantidad: $.trim($(me.Variables.txtCantidad1).val()),
                    CUV2: $(me.Variables.txtCuv2).html(),
                    Cantidad2: $(me.Variables.txtCantidad2).val(),
                    EsMovilOrigen: OrigenCDR
                };

                ShowLoading();

                jQuery.ajax({
                    type: 'POST',
                    url: UrlDetalleGuardar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {

                        CloseLoading();
                        if (!checkTimeout(data)) {
                            return false;
                        }

                        if (data.success == false) {
                            messageInfoValidado(data.message);
                            return false;
                        }

                        $(me.Variables.hdCDRID).val(data.detalle);
                        me.Funciones.DetalleCargar();
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            DetalleCargar: function () {
                var item = {
                    CDRWebID: $(me.Variables.hdCDRID).val() || 0,
                    PedidoID: $(me.Variables.hdPedidoID).val() || 0
                };

                ShowLoading();
                jQuery.ajax({
                    type: 'POST',
                    url: UrlDetalleCargar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success != true) {
                            messageInfoValidado(data.message);
                            return false;
                        }

                        $(me.Variables.spnCantidadUltimasSolicitadas).html(data.detalle.length);
                        $(me.Variables.numSolicitudes).html(data.detalle.length)

                        SetHandlebars("#template-detalle-banner", data, me.Variables.divDetalleUltimasSolicitudes);
                        me.Funciones.ValidarVisualizacionBannerResumen();

                        SetHandlebars("#template-detalle-paso3", data, me.Variables.divDetallePaso3);
                        SetHandlebars("#template-detalle-paso3-enviada", data, me.Variables.divDetalleEnviar);
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            ValidarVisualizacionBannerResumen: function () {
                var cantidadDetalles = $(me.Variables.spnCantidadUltimasSolicitadas).html();

                if ($('#Paso2:visible').length > 0 || cantidadDetalles == 0) $(me.Variables.btn_ver_solicitudes).hide();
                else $(me.Variables.btn_ver_solicitudes).show();
                if ($('#Paso3:visible').length > 0) $(me.Variables.divUltimasSolicitudes).hide();
                else $(me.Variables.divUltimasSolicitudes).show();
            },

            ObtenerValorParametria: function (codigoSsic) {
                var item = {
                    EstadoSsic: codigoSsic
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlBuscarParametria,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {
                        if (!checkTimeout(data))
                            return false;

                        var parametria = data.detalle;
                        var parametriaAbs = data.detalleAbs;

                        $(me.Variables.hdParametriaCdr).val(parametria.ValorParametria);
                        $(me.Variables.hdParametriaAbsCdr).val(parametriaAbs.ValorParametria);
                    },
                    error: function (data, error) { }
                });
            },

            ObtenerMontoProductosDevolver: function (codigoOperacion) {
                var resultado = 0;

                var item = {
                    CDRWebID: $(me.Variables.hdCDRID).val() || 0,
                    PedidoID: $(me.Variables.hdPedidoID).val() || 0,
                    EstadoSsic: codigoOperacion
                };
                ShowLoading();

                jQuery.ajax({
                    type: 'POST',
                    url: UrlObtenerMontosProdcutos,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: false,
                    cache: false,
                    success: function (data) {

                        CloseLoading();
                        if (!checkTimeout(data))
                            return false;

                        if (data.success != true) {
                            messageInfoValidado(data.message);
                            return false;
                        }

                        resultado = data.montoProductos;
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });

                return resultado;

            },

            ValidarCorreoDuplicado: function (correo) {
                var resultado = false;
                jQuery.ajax({
                    type: 'POST',
                    url: UrlValidarCorreoDuplicado,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ correo: correo }),
                    async: false,
                    cache: false,
                    success: function (data) {
                        if (!checkTimeout(data))
                            resultado = false;
                        else
                            resultado = data.success;
                    },
                    error: function (data, error) { }
                });
                return resultado;
            },

			SolicitudEnviar: function (validarCorreoVacio, validarCelularVacio) {
                var ok = true;
                var correo = $.trim($(me.Variables.txtEmail).val());
                var celular = $.trim($(me.Variables.txtTelefono).val());

                if (IfNull(validarCorreoVacio, true) && correo == "") {
                    me.Funciones.ControlSetError(me.Variables.txtEmail, me.Variables.spnEmailError, '*Correo Electrónico incorrecto');
                    ok = false;
                }
                if (IfNull(validarCelularVacio, true) && celular == "") {
                    me.Funciones.ControlSetError(me.Variables.txtTelefono, me.Variables.spnTelefonoError, '*Celular incorrecto');
                    ok = false;
                }
                if (!ok) {
                    messageInfoError(me.Constantes.DebeAceptarSeccionValidaTusDatos);
                    return false;
                }
                if (correo != "" && !validateEmail(correo)) {
                    me.Funciones.ControlSetError(me.Variables.txtEmail, me.Variables.spnEmailError, '*Correo Electrónico incorrecto');
                    ok = false;
                }
                if (celular != "" && celular.length < 6) {
                    me.Funciones.ControlSetError(me.Variables.txtTelefono, me.Variables.spnTelefonoError, '*Celular incorrecto');
                    ok = false;
                }
                if (!ok) return false;

                if (celular != "" && !me.Funciones.ValidarTelefono(celular)) {
                    me.Funciones.ControlSetError(me.Variables.txtTelefono, me.Variables.spnTelefonoError, '*Este número de celular ya está siendo utilizado. Intenta con otro.');
                    return false;
                }

                var correoActual = $.trim($(me.Variables.Email).val());
                if (correo != "" && correo != correoActual && !me.Funciones.ValidarCorreoDuplicado(correo)) {
                    me.Funciones.ControlSetError(me.Variables.txtEmail, me.Variables.spnEmailError, '*Este correo ya está siendo utilizado. Intenta con otro');
                    return false;
                }

                if ($(me.Variables.politica_devolucion).prop("checked") == false) {
                    messageInfoError(me.Constantes.DebeAceptarPoliticaCambios);
                    return false;
                }

                var item = {
                    CDRWebID: $(me.Variables.hdCDRID).val() || 0,
                    PedidoID: $(me.Variables.hdPedidoID).val() || 0,
                    Email: $(me.Variables.txtEmail).val(),
                    Telefono: $(me.Variables.txtTelefono).val(),
                    TipoDespacho: false,
                    FleteDespacho: 0,
                    MensajeDespacho: '',
                    EsMovilFin: OrigenCDR
                };

                ShowLoading();
                jQuery.ajax({
                    type: 'POST',
                    url: UrlSolicitudEnviar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    cache: false,
					success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data)) return false;

						if (data.success != true) {
							var mensajeInfo = "";
							if ((data.message.indexOf(mensajeChatEnLinea) > -1) && (flagAppMobile == 1)) {
								mensajeInfo = data.message.replace(mensajeChatEnLinea, "").trim();
							} else mensajeInfo = data.message;
							  
							messageInfo(mensajeInfo);
							 
                            return false;
                        }

                        var formatoFechaCulminado = "";
                        var numeroSolicitud = 0;
                        var formatoCampania = "";
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

                        $(me.Variables.spnSolicitudFechaCulminado).html(formatoFechaCulminado);
                        $(me.Variables.spnSolicitudNumeroSolicitud).html(numeroSolicitud);
                        $(me.Variables.spnSolicitudCampania).html(formatoCampania);
                        $(me.Variables.divProcesoReclamo).hide();
                        $(me.Variables.divUltimasSolicitudes).hide();
                        $(me.Variables.btnSiguiente4).hide();
                        $(me.Variables.btnSiguiente1).hide();
                        $(me.Variables.TituloReclamo).hide();

                        if (data.Cantidad == 1) messageInfoValidado(data.message, "MENSAJE");

                        $(me.Variables.RegistroAceptarSolucion).hide();
                        $(me.Variables.textoMensajeCDR).hide();

                        $(me.Variables.SolicitudEnviada).show();

                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            ValidarTelefono: function () {
                ShowLoading();
                var resultado = false;
                jQuery.ajax({
                    type: 'POST',
                    url: UrlValidaTelefono,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ Telefono: $("#txtTelefono").val() }),
                    async: false,
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data)) resultado = false;
                        else resultado = data.success;
                    },
                    error: function (data, error) {
                        CloseLoading();
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

                    messageConfirmacion("Se eliminará el registro seleccionado. <br/>¿Deseas continuar?", function () {
                        me.Funciones.DetalleEliminar(item);
                    });
                }
            },

            DetalleEliminar: function (objItem) {
                var item = {
                    CDRWebDetalleID: objItem.CDRWebDetalleID
                };

                ShowLoading();

                jQuery.ajax({
                    type: 'POST',
                    url: UrlDetalleEliminar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(item),
                    async: true,
                    cache: false,
                    success: function (data) {
                        CloseLoading();
                        if (!checkTimeout(data)) {
                            return false;
                        }

                        if (data.success == true) {
                            me.Funciones.DetalleCargar();
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            PopupPedido: function (pedidos) {

                $("#divPopupPedido").hide();
                pedidos = pedidos || new Array();
                SetHandlebars("#template-pedido", pedidos, "#divPedido");
                if (pedidos.length > 0) {
                    listaPedidos = pedidos;
                    $("#divPopupPedido").show();
                }
            },

            PopupPedidoSeleccionar: function (obj) {

                var objPedido = $(obj);
                var id = objPedido.attr("data-pedido-id");
                var pedidos = listaPedidos.Find("PedidoID", id);
                var pedido = pedidos.length > 0 ? pedidos[0] : new Object();
                $("#divPopupPedido").hide();
                me.Funciones.AsignarCUV(pedido);
            }
        };

        me.Inicializar = function () {
            me.Eventos.bindEvents();
        };
    };

    misReclamosRegistro = new PortalConsultorasReclamoRegistro();
    misReclamosRegistro.Inicializar();
});
