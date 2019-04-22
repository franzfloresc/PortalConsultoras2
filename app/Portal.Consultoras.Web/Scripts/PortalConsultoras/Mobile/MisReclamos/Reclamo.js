﻿var cuvKeyUp = false;
var cuv2KeyUp = false;
var cuvPrevVal = '', cuv2PrevVal = '';
var pasoActual = 1;
var paso2Actual = 1;
var misReclamosRegistro;
var listaPedidos = [];
var datosCuv = [];
var tipoDespacho = false;

var dataCdrDevolucion = {};
var flagSetsOrPack = false;
var flagSolicitudEnviada = false;


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
            btnSiguiente0: "#btnSiguiente0",//HD-3412 EINCA
            btnSiguiente1: "#btnSiguiente1",
            btnSiguiente4: "#btnSiguiente4",
            Cambio3: "#Cambio3",
            ComboCampania: "#ddlCampania",
            content_solicitud_cdr: ".content_solicitud_cdr",
            campoBusquedaCuvDescripcionCdr: '#CampoBusquedaCuvDescripcion',
            datosSolicitudOpened: ".datos_solicitud_opened",
            DescripcionCuv: "#DescripcionCuv",
            ddlnumPedido: "#ddlnumPedido",
            DescripcionCuv2: "#DescripcionCuv2",
            deshabilitarControl: "campo_deshabilitado",
            deshabilitarBoton: "btn_deshabilitado",
            divDetalleEnviar: "#divDetalleEnviar",
            divDetallePaso3: "#divDetallePaso3",
            divDetalleUltimasSolicitudes: "#divDetalleUltimasSolicitudes",
            divlistado_soluciones_cdr: "#divlistado_soluciones_cdr",
            divProcesoReclamo: "#divProcesoReclamo",
            divUltimasSolicitudes: "#divUltimasSolicitudes",
            divConfirmEnviarSolicitudCDR: '#divConfirmEnviarSolicitudCDR', //HD-3412 EINCA
            enlace_ir_al_final: ".enlace_ir_al_final",
            enlace_quiero_ver_otra_alternativa: ".enlace_quiero_ver_otra_alternativa",
            Enlace_regresar: ".enlace_regresar",
            EleccionTipoEnvio: "#EleccionTipoEnvio",
            footer_page: ".footer-page",
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
            hdCuvPrecio2: "#hdCuvPrecio2",
            hdCuvCodigo: "#hdCuvCodigo",
            hdDescripcionCuv: "#hdDescripcionCuv",
            hdTieneCDRExpress: "#hdTieneCDRExpress",
            IrSolicitudInicial: "#IrSolicitudInicial",
            IrPaso1: "#IrPaso1",
            infoOpcionesDeCambio: "#infoOpcionesDeCambio",
            linkNuevoCambio: "#linkNuevoCambio",
            listado_soluciones_cdr: ".listado_soluciones_cdr",
            listadoProductosAgregados: ".listado_productos_agregados",
            listaMotivos: "#listaMotivos",
            ListaCoincidenciasBusquedaProductosCdr: "#ListaCoincidenciasBusquedaProductosCdr",
            miSolicitudCDR: ".mi_solicitud_cdr",
            modificarPrecioMas: ".modificarPrecioMas",
            modificarPrecioMenos: ".modificarPrecioMenos",
            numSolicitudes: ".num_solicitudes",
            ocultar_mi_solicitud: ".ocultar_mi_solicitud",
            operaciones: {
                faltante: "F",
                faltanteAbono: "G",
                devolucion: "D",
                trueque: "T",
                canje: "C"
            },
            OpcionEnvioDelProducto: "#OpcionEnvioDelProducto",
            OpcionDevolucionDinero: "#OpcionDevolucionDinero",
            OpcionDevolucion: "#OpcionDevolucion",
            OpcionCambioPorOtroProducto: "#OpcionCambioPorOtroProducto",
            OpcionCambioMismoProducto: "#OpcionCambioMismoProducto",
            progreso: {
                uno_producto: "#Selector1",
                dos_solucion: "#Selector2",
                tres_finalizar: "#Selector3"
            },
            pasos: {
                uno_seleccion_de_producto: "1",
                dos_seleccion_de_solucion: "2",
                tres_finalizar_envio_solicitud: "3"
            },
            paso_active_reclamo: "paso_active_reclamo",
            paso_reclamo_completado: "paso_reclamo_completado",
            pestaniaVerMiSolicitud: ".pestania_ver_mi_solicitud",
            politica_devolucion: "#politica-devolucion",
            popupCuvDescripcion: ".popupCuvDescripcion",
            PopupBusquedaCuvDescripcionProductoCdr: "#PopupBusquedaCuvDescripcionProductoCdr",
            producto_agregado: ".producto_agregado",
            pb120: "pb-120",
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
            spnDescripcionProductoOpcionF: "#spnDescripcionProductoOpcionF",
            spnCantidadF: "#spnCantidadF",
            spnDescripcionProductoOpcionG: "#spnDescripcionProductoOpcionG",
            spnCantidadG: "#spnCantidadG",
            spnDescProdDevolucionC: "#spnDescProdDevolucionC",
            spnCantidadC: "#spnCantidadC",
            spnCantidadDVarios: "#spnCantidadDVarios",
            spnCantidadDIndividual: "#spnCantidadIndividual",
            tabVistaCdr: ".tab_vista_cdr_enlace_contenido",
            tabs_vista_cdr_wrapper: ".tabs_vista_cdr_wrapper",
            textoMensajeCDR: ".texto-mensaje-cdr",
            TituloPreguntaInconvenientes: ".pregunta_inconveniente_producto_titulo",
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
            txtCantidadPedidoConfig: '#txtCantidadPedidoConfig',
            txtNumPedido: "#txtNumPedido",
            UltimasSolicitudes: ".UltimasSolicitudes",
            wrpMobile: "#wrpMobile",
            opcionCdrEnlace: ".opcion_cdr_enlace"
        };

        me.Eventos = {
            bindEvents: function () {
                $(me.Variables.footer_page).hide();
                $(me.Variables.EleccionTipoEnvio).hide();
                $(me.Variables.btnSiguiente1).addClass(me.Variables.deshabilitarBoton);
                $(me.Variables.txtCuvMobile).addClass(me.Variables.deshabilitarControl);
                if (mostrarTab === 0 || mostrarTab === "0")
                    $(me.Variables.tabs_vista_cdr_wrapper).hide();

                var pedidoId = parseInt($(me.Variables.hdPedidoID).val());
                if (pedidoId != 0) {
                    ShowLoading();
                    me.Funciones.DetalleCargar();
                    $(me.Variables.btnSiguiente4).show();
                    $(me.Variables.RegistroAceptarSolucion).show();
                    $(me.Variables.Cambio3).hide();
                    if ($(me.Variables.Registro1).is(":visible")) {
                        $(me.Variables.Registro1).hide();
                    }
                }

                // Alternar vistas de tabs Nuevo Cambio y Registradas

                $(me.Variables.tabVistaCdr).click(function (e) {
                    e.preventDefault();
                    var contenidoTabAMostrar = $(this).attr('href');
                    var $tab = $(this).attr("id");
                    if ($tab === "linkSolicitudesRegistradas") {
                        ShowLoading();
                        $.when($('#divMisReclamos').load(UrlGetMisReclamos)).done(function () {
                            CloseLoading();
                        });
                    }
                    $('.vistas_cdr').fadeOut(100);
                    $('.tab_vista_cdr').removeClass('tab_vista_cdr--activo');
                    $(this).parent().addClass('tab_vista_cdr--activo')
                    $(contenidoTabAMostrar).fadeIn(100);
                });

                // Seleccionar opción haciendo click en el área que conforma la opción cdr elegida, no sólo en el checkbox
                $(me.Variables.divlistado_soluciones_cdr).on('click', me.Variables.opcionCdrEnlace, function (e) {
                    e.preventDefault();
                    // Se dispara el evento change del checkbox que llama a la función EscogerSolucion que se lanza al seleccionar y deseleccionar el checkbox
                    $(this).find('input[type="checkbox"]').change();
                });

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

                    $(me.Variables.txtNumPedido).val("N° " + $(me.Variables.hdNumeroPedido).val());
                    $(me.Variables.txtNumPedido).show();
                    $(me.Variables.txtNumPedido).attr("readonly", "readonly");
                    $(me.Variables.hdCuvCodigo).val("");
                    $(me.Variables.txtDescripcionCuv).html("");
                    $(me.Variables.txtCantidad1).val("1");
                    $(me.Variables.txtCuvMobile2).val("");
                    $(me.Variables.txtPrecioCuv2).html("");
                    $(me.Variables.spnSimboloMonedaCuv2).html("");
                    $(me.Variables.hdImporteTotal2).val(0);
                    $(me.Variables.txtDescripcionCuv2).html("");
                    $(me.Variables.txtCantidad2).val("1");
                    $(me.Variables.txtCuvMobile).val("");
                    me.Funciones.CambiarEstadoBarraProgreso(me.Variables.pasos.uno_seleccion_de_producto);
                    $(me.Variables.divUltimasSolicitudes).show();
                    $("#VistaPaso3").hide();
                    $(me.Variables.Registro1).show();
                    $(me.Variables.btnSiguiente1).show();
                    $("#VistaPaso1y2").show();
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).fadeIn();

                    $(me.Variables.DescripcionCuv2).hide();
                    $(me.Variables.txtCuvMobile2).fadeIn();
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
                    $(me.Variables.txtCantidad1).val("1");
                    $(me.Variables.txtCuvMobile).val("");
                    $(me.Variables.Registro2).hide();
                    if ($(me.Variables.ComboCampania).val() == 0) {
                        $(me.Variables.ddlnumPedido).hide();
                        $(me.Variables.txtCuvMobile).addClass(me.Variables.deshabilitarControl);
                        return false;
                    }
                    $(me.Variables.hdPedidoID).val(0);
                    $(me.Variables.hdNumeroPedido).val(0);
                    $.when(me.Funciones.ObtenerPedidosID()).then(function () {
                        $(me.Variables.txtCuvMobile).removeClass('campo_deshabilitado');
                    });
                });

                $(me.Variables.ddlnumPedido).on('change', function () {
                    $(me.Variables.txtCantidad1).val("1");
                    if ($(me.Variables.ddlnumPedido).val() == 0) {
                        $(me.Variables.DescripcionCuv).hide();
                        $(me.Variables.txtCuvMobile).show();
                        return false;
                    }
                    $(me.Variables.hdPedidoID).val($.trim($(me.Variables.ddlnumPedido).val()));
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).show();
                    me.Funciones.BuscarCUV();
                });

                $(me.Variables.txtCuvMobile).click(function (e) {
                    $(me.Variables.campoBusquedaCuvDescripcionCdr).val("");
                    $("#ListaCoincidenciasBusquedaProductosCdr li").filter(function () {
                        $(this).toggle($(this).attr('data-value').toLowerCase().indexOf("") > -1);
                    });
                    $(me.Variables.PopupBusquedaCuvDescripcionProductoCdr).show();
                });

                $(me.Variables.ListaCoincidenciasBusquedaProductosCdr).on('click', '.coincidencia_busqueda_producto', function (e) {
                    var $el = $(this);

                    var _cuv = $.trim($el.attr("data-codigo"));
                    var _descripcionCuv = $.trim($el.attr("data-descr"));
                    var cantidad = $el.attr("data-cantidad") !== "" ? parseInt($el.attr("data-cantidad")) : 1;
                    me.Funciones.CuvSeleccionado(_cuv, _descripcionCuv, cantidad);
                });

                setInterval(function () {
                    if (cuv2KeyUp) cuv2KeyUp = false;
                    else me.Funciones.EvaluarCUV2();
                }, 1000)

                $(me.Variables.aCambiarProducto).click(function (e) {

                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.DescripcionCuv).hide();
                    $(me.Variables.txtCuvMobile).show();
                    $(me.Variables.campoBusquedaCuvDescripcionCdr).val("");
                    $("#ListaCoincidenciasBusquedaProductosCdr li").filter(function () {
                        $(this).toggle($(this).attr('data-value').toLowerCase().indexOf("") > -1);
                    });
                    $(me.Variables.PopupBusquedaCuvDescripcionProductoCdr).fadeIn();
                });

                $(me.Variables.aCambiarProducto2).click(function (e) {

                    $(me.Variables.DescripcionCuv2).hide();
                    $(me.Variables.txtCuvMobile2).fadeIn();
                    $(me.Variables.txtCuvMobile2).focus();
                });

                $(me.Variables.btnSiguiente1).click(function (e) {
                    if ($(me.Variables.Registro1).is(":visible")) {
                        $(me.Variables.txtDescripcionCuv2).val("");
                        $(me.Variables.txtCuv2).html("");
                        $(me.Variables.txtPrecioCuv2).html("");
                        if (me.Funciones.ValidarPasoUno()) {
                            me.Funciones.ValidarPasoUnoServer(function (d) {
                                if (!d.success) {
                                    $.when(me.Funciones.RegresarRegistro1())
                                        .then(messageInfoValidado(d.message));
                                } else {
                                    paso2Actual = 1;
                                    //Seteamos la data de la respuesta del servicio de cdr
                                    var ProductoSeleccionado = {
                                        CUV: $(me.Variables.hdCuvCodigo).val(),
                                        Descripcion: $(me.Variables.hdDescripcionCuv).val()
                                    };
                                    dataCdrDevolucion.ProductoSeleccionado = ProductoSeleccionado;
                                    if (d !== null) {
                                        dataCdrDevolucion.DataRespuestaServicio = d.data[0].LProductosComplementos;
                                        flagSetsOrPack = d.flagSetsOrPack;
                                    }
                                    $.when(me.Funciones.CargarOperacion()).then(function () {
                                        $(me.Variables.Registro1).hide();
                                        $(me.Variables.Registro2).hide();
                                        $(me.Variables.Registro3).show();
                                        $(me.Variables.btnSiguiente1).addClass(me.Variables.deshabilitarBoton);
                                        me.Funciones.CambiarEstadoBarraProgreso(me.Variables.pasos.dos_seleccion_de_solucion);
                                    });
                                }
                            });
                        }
                    }

                    if ($(me.Variables.Registro3).is(":visible")) {
                        var fnPreValidacion = me.Funciones.PreValidacionIrFinalizar();
                        if (fnPreValidacion.result) {
                            me.Funciones.DetalleGuardar(fnPreValidacion.id, function (data) {
                                if (data.success) {
                                    $.when(me.Funciones.DetalleCargar()).done(function () {
                                        $(me.Variables.hdCDRID).val(data.detalle);
                                        $(me.Variables.wrpMobile).removeClass(me.Variables.pb120);
                                        var arrOcultarElementos = [me.Variables.TituloPreguntaInconvenientes, me.Variables.Registro4
                                            , me.Variables.Registro3, me.Variables.infoOpcionesDeCambio, me.Variables.Enlace_regresar, "#VistaPaso1y2"];
                                        $(me.Variables.btnSiguiente1).addClass(me.Variables.deshabilitarBoton);
                                        me.Funciones.HideTags(arrOcultarElementos);
                                        $(me.Variables.infoOpcionesDeCambio).children().hide();
                                        $(me.Variables.btnSiguiente4).show();
                                        $("#VistaPaso3").show();
                                        $(me.Variables.RegistroAceptarSolucion).show();
                                        $(me.Variables.EleccionTipoEnvio).show();
                                        me.Funciones.CambiarEstadoBarraProgreso(me.Variables.pasos.tres_finalizar_envio_solicitud);
                                    });
                                } else {
                                    messageInfoValidado(data.message);
                                    return false;
                                }
                            });
                        }
                    }
                });

                $(me.Variables.Enlace_regresar).click(function (e) {

                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro3).hide();
                    $(me.Variables.Registro4).hide();
                    $(me.Variables.Cambio3).hide();
                    //$(me.Variables.pasodosactivo).hide();
                    //$(me.Variables.pasotresactivo).hide();

                    $(me.Variables.Enlace_regresar).hide();
                    $(me.Variables.btnAceptarSolucion).hide();
                    $(me.Variables.btnCambioProducto).hide();
                    //$(me.Variables.pasodos).show();
                    //$(me.Variables.pasotres).show();

                    $(me.Variables.hdCuvCodigo).val("");
                    $(me.Variables.txtCantidad1).val("1");
                    $(me.Variables.txtCuvMobile2).val("");
                    $(me.Variables.txtPrecioCuv2).html("");
                    $(me.Variables.txtCantidad2).val("1");
                    $(me.Variables.ComboCampania).val(0);
                    $(me.Variables.txtNumPedido).val("");
                    $(me.Variables.txtNumPedido).hide();
                    $(me.Variables.ddlnumPedido).val(0);
                    $(me.Variables.ddlnumPedido).hide();

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
                    //HD-3412 EINCA
                    if (me.Funciones.ValidarSolicitudCDREnvio(false, true)) {
                        $(me.Variables.txtCantidadPedidoConfig).text(CantidadReclamosPorPedidoConfig);
                        $(me.Variables.divConfirmEnviarSolicitudCDR).show();
                    }

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
                }).keydown(function (e) {
                    if ($(this).val().length >= 11) {
                        $(this).val($(this).val().substr(0, 11));
                    }
                }).keyup(function (e) {
                    if ($(this).val().length >= 11) {
                        $(this).val($(this).val().substr(0, 11));
                    }
                }).blur(function () {
                    me.Funciones.ControlSetError(me.Variables.txtTelefono, me.Variables.spnTelefonoError, '');
                });

                $(me.Variables.txtEmail).blur(function () {
                    me.Funciones.ControlSetError(me.Variables.txtEmail, me.Variables.spnEmailError, '');
                });

                $(me.Variables.txtCuvMobile2).on('keyup', function (evt) {
                    cuv2KeyUp = true;
                    me.Funciones.EvaluarCUV2();
                });

                $(me.Variables.modificarPrecioMas).click(function (evt) {
                    var precio = $(me.Variables.hdCuvPrecio2).val();
                    var cantidad = parseInt($(me.Variables.txtCantidad2).val());

                    cantidad = cantidad == 99 ? 99 : cantidad + 1;

                    var importeTotal = precio * cantidad;

                    $(me.Variables.hdImporteTotal2).val(importeTotal);
                    $(me.Variables.txtPrecioCuv2).html(DecimalToStringFormat(importeTotal));
                    $(me.Variables.txtCantidad2).val(cantidad);
                });

                $(me.Variables.modificarPrecioMenos).click(function (evt) {
                    var precio = $(me.Variables.hdCuvPrecio2).val();
                    var cantidad = parseInt($(me.Variables.txtCantidad2).val());

                    cantidad = cantidad == 1 ? 1 : cantidad - 1;

                    var importeTotal = precio * cantidad;

                    $(me.Variables.hdImporteTotal2).val(importeTotal);
                    $(me.Variables.txtPrecioCuv2).html(DecimalToStringFormat(importeTotal));
                    $(me.Variables.txtCantidad2).val(cantidad);
                });

                $(me.Variables.enlace_quiero_ver_otra_alternativa).click(function (evt) {
                    $(me.Variables.Registro4).hide();
                    $(me.Variables.btnAceptarSolucion).hide();
                    $(me.Variables.Registro3).show();
                });

                $(me.Variables.campoBusquedaCuvDescripcionCdr).keyup(function () {
                    var valorInputBusquedaCuvDescripcion = $(this).val().toLowerCase();
                    $("#ListaCoincidenciasBusquedaProductosCdr li").filter(function () {
                        $(this).toggle($(this).attr('data-value').toLowerCase().indexOf(valorInputBusquedaCuvDescripcion) > -1);
                    });
                });

                $(".tipo_envio_checkbox label").click(function () {
                    $(".tipo_envio_checkbox label").prev().removeAttr('checked');
                    $(this).prev().attr("checked", "checke");
                    var oID = $(this).prev().attr("id");
                    if (oID == "TipoEnvioExpress") tipoDespacho = true;
                    else tipoDespacho = false;
                });
                //HD-3412 EINCA
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
                $(me.Variables.IrPaso1).on("click", function () {
                    $(me.Variables.Registro2).hide();
                    $(me.Variables.Registro3).hide();
                    $(me.Variables.txtCantidad1).val("1");
                    $(me.Variables.txtCuvMobile).val("");
                    $(me.Variables.txtCuvMobile).addClass(me.Variables.deshabilitarControl);
                    $(me.Variables.ComboCampania).val("0");
                    $(me.Variables.hdPedidoID).val(0);
                    $(me.Variables.hdNumeroPedido).val(0);
                    $("#VistaPaso3").hide();
                    me.Funciones.CambiarEstadoBarraProgreso(me.Variables.pasos.uno_seleccion_de_producto);
                    $("#VistaPaso1y2").show();
                    $(me.Variables.ListaCoincidenciasBusquedaProductosCdr).empty();
                    $(me.Variables.linkNuevoCambio).click();
                    $(me.Variables.Registro1).fadeIn(100);

                });
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

            SeccionTabsFijoSegunAltoHeader: function () {   
                $('.fijarTituloMobile').css('top', $('#new-header').outerHeight());
                $(me.Variables.tabs_vista_cdr_wrapper).css('top', $('#new-header').outerHeight() + 50);
            },

            ObtenerPedidosID: function () {
                $(me.Variables.hdPedidoID).val("");
                $(me.Variables.hdNumeroPedido).val("");
                $(me.Variables.ddlnumPedido).html("");

                var CampaniaId = $.trim($(me.Variables.ComboCampania).val());
                var item = {
                    CampaniaID: CampaniaId,
                };

                ShowLoading();
                jQuery.ajax({
                    type: 'POST',
                    url: UrlObtenerListarNumPedido,
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

                        if (data.datos.length == 1) {
                            $(me.Variables.ddlnumPedido).hide();
                            $(me.Variables.hdPedidoID).val(data.datos[0].PedidoID);
                            $(me.Variables.hdNumeroPedido).val(data.datos[0].NumeroPedido);
                            $(me.Variables.txtNumPedido).val("N° " + data.datos[0].NumeroPedido);
                            me.Funciones.BuscarCUV();
                        }
                        else if (data.datos.length > 1) {
                            $(me.Variables.txtNumPedido).hide();
                            $(me.Variables.ddlnumPedido).append($('<option></option>').val(0).html("Elige un pedido"));
                            $(data.datos).each(function (index, item) {
                                $(me.Variables.ddlnumPedido).append($('<option></option>').val(item.PedidoID).html(item.strNumeroPedido));
                            });
                            $(me.Variables.ddlnumPedido).show();
                        }
                        else {
                            messageInfoValidado(data.message)
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                        checkTimeout(data);
                    }
                });
            },
            //HD-3412 EINCA
            ValidarPasoDosTrueque: function () {
                var $val = $(me.Variables.txtCantidad2).val();
                var cantidad = $.trim($val) !== "" && !isNaN($val) ? parseInt($val) : 0;
                if ($.trim($(me.Variables.txtCuvMobile2).val()) === "") {
                    messageInfoValidado("Por favor, ingrese el CUV con el que desea cambiar.");
                    $(me.Variables.txtCuvMobile2).focus();
                    return false;
                } else if (cantidad <= 0) {
                    messageInfoValidado("La cantidad ingresada es incorrecto.");
                    $(me.Variables.txtCantidad2).focus();
                    return false;
                }
                var montoMinimoReclamo = $(me.Variables.hdMontoMinimoReclamo).val();
                var montoPedidoTrueque = $(me.Variables.hdImporteTotal2).val() == "" ? 0 : $(me.Variables.hdImporteTotal2).val();
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
                return true;
            },
            //HD-3412 EINCA
            ValidarPasoDosTruequeServer: function (callbackWhenFinish) {

                var item = {
                    PedidoID: $(me.Variables.hdPedidoID).val(),
                    CUV: $.trim($(me.Variables.txtCuvMobile2).val()),
                    Cantidad: $.trim($(me.Variables.txtCantidad2).val()),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    CampaniaID: $(me.Variables.ComboCampania).val()
                };


                $.ajaxSetup({
                    global: false,
                    type: "POST",
                    dataType: 'json',
                    async: true,
                    cache: false,
                    contentType: 'application/json; charset=utf-8',
                    url: UrlValidarNoPack,
                    beforeSend: function () { ShowLoading(); },
                    complete: function () { CloseLoading(); }
                });

                $.ajax({
                    data: JSON.stringify(item),
                    success: function (data) {
                        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                            callbackWhenFinish(data.success, data.message);
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },
            BuscarCUV: function (CUV) {

                var CampaniaId = $.trim($(me.Variables.ComboCampania).val()) || 0;
                var PedidoId = $.trim($(me.Variables.hdPedidoID).val()) || 0;

                var item = {
                    CampaniaID: CampaniaId,
                    PedidoID: PedidoId,
                    CDRWebID: $(me.Variables.hdCDRID).val()
                };

                ShowLoading();
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

                        if (data.detalle == null) return false;

                        if (data.detalle.length > 1) {
                            $(me.Variables.campoBusquedaCuvDescripcionCdr).val("");
                            $("#ListaCoincidenciasBusquedaProductosCdr li").filter(function () {
                                $(this).toggle($(this).attr('data-value').toLowerCase().indexOf("") > -1);
                            });
                            $(me.Variables.ListaCoincidenciasBusquedaProductosCdr).html("");
                            $(data.detalle).each(function (index, item) {
                                $(me.Variables.ListaCoincidenciasBusquedaProductosCdr).append("<li class='coincidencia_busqueda_producto d-block text-uppercase' data-cantidad='" + item.Cantidad + "' data-descr='" + item.DescripcionProd + "' data-codigo=" + item.CUV + " data-value='" + item.CUV + " - " + item.DescripcionProd + "'><div class='resultado_busqueda_por_cuv_datos_imagen'><img src='/Content/Images/oferta-sin-imagen.svg' alt='" + item.DescripcionProd + "'/></div><div class='resultado_busqueda_por_cuv_datos_prod'><div class='resultado_busqueda_por_cuv_codigo_prod'>" + item.CUV + "</div> <div class='resultado_busqueda_por_cuv_descrip_prod' id='CuvPopup" + index + "'>" + item.DescripcionProd + "</div></div></li >");
                            });
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                        checkTimeout(data);
                    }
                });
            },
            CuvSeleccionado: function (cuv, desc, cantidad) {
                me.Funciones.ObtenerDatosCuv();
                me.Funciones.BuscarMotivo();
                $(me.Variables.txtCuv).html(cuv);
                $(me.Variables.txtCantidad1).val(cantidad);
                $(me.Variables.txtDescripcionCuv).html(desc);
                $(me.Variables.hdCuvCodigo).val(cuv);
                $(me.Variables.hdDescripcionCuv).val(desc);
                $(me.Variables.PopupBusquedaCuvDescripcionProductoCdr).hide();
                $(me.Variables.txtCuvMobile).val(cuv + " - " + desc).focus();
                $(me.Variables.Registro2).show();
            },

            ObtenerDatosCuv: function () {
                ShowLoading();

                var item = {
                    CampaniaID: $.trim($(me.Variables.ComboCampania).val()),
                    PedidoID: $.trim($(me.Variables.hdPedidoID).val())
                };

                jQuery.ajax({
                    type: 'POST',
                    url: UrlObtenerDatosCuv,
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

                        var arrCuv = data.datos[0].olstBEPedidoWebDetalle || [];
                        datosCuv = [];
                        if (arrCuv.length > 0) {
                            $.each(arrCuv, function (index, value) {
                                var obj = {
                                    cuv: value.CUV,
                                    descripcion: value.DescripcionProd,
                                    pedidoId: value.PedidoID,
                                    CampaniaId: value.CampaniaID,
                                    precioUnidad: value.PrecioUnidad,
                                    cantidad: value.Cantidad
                                };
                                datosCuv.push(obj);
                            });
                        }

                        me.Funciones.AsignarCUV(data.datos[0]);
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            AsignarCUV: function (pedido) {
                var EstadosConteo = 0;
                var CDRWebID = 0;
                pedido = pedido || new Object();
                $.each(pedido.BECDRWeb, function (i, item) {
                    if (item.Estado === 3 || item.Estado === 2) {
                        EstadosConteo++;
                    }
                    //obtener el cdr en estado pendiente
                    if (item.Estado === 1) { CDRWebID = item.CDRWebID; }
                });
                var cantidad = CantidadReclamosPorPedidoConfig != null && CantidadReclamosPorPedidoConfig != '' ? parseInt(CantidadReclamosPorPedidoConfig) : 0;
                if (cantidad === EstadosConteo && EstadosConteo > 0) {
                    messageInfoError("Lo sentimos, usted a excedido el límite de reclamos por pedido");
                } else {
                    pedido.olstBEPedidoWebDetalle = pedido.olstBEPedidoWebDetalle || new Array();
                    var detalle = pedido.olstBEPedidoWebDetalle.Find("CUV", $(me.Variables.hdCuvCodigo).val() || "");
                    var data = detalle.length > 0 ? detalle[0] : new Object();

                    $(me.Variables.txtCantidad1).removeAttr("disabled");
                    $(me.Variables.txtCantidad1).attr("data-maxvalue", data.Cantidad);
                    $(me.Variables.hdPedidoID).val(data.PedidoID);
                    $(me.Variables.hdNumeroPedido).val(pedido.NumeroPedido);

                    $(me.Variables.txtPrecioUnidad).val(data.PrecioUnidad);
                    $(me.Variables.hdImporteTotalPedido).val(pedido.ImporteTotal);
                    $(me.Variables.hdCDRID).val(CDRWebID);
                }
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

                var PedidoId = $.trim($(me.Variables.hdPedidoID).val()) || 0;

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
                            messageInfoValidado(data[0].CUV, function () {
                                $(me.Variables.txtCuvMobile2).val("");
                                $(me.Variables.txtCuvMobile2).focus();
                            });

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
                        me.Funciones.AgregarEventoMostrarBotonSiguiente();
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            ValidarCUVCampania: function () {

                if ($(me.Variables.hdPedidoID).val() == "") {
                    messageInfoValidado("por favor, seleccionar un pedido.");
                    return false;
                }
                if ($(me.Variables.ComboCampania).val() == "" || $(me.Variables.ComboCampania).val() == "0") {
                    messageInfoValidado("por favor, seleccionar una campaña.");
                    $(this).focus();
                    return false;
                }
                if ($.trim($(me.Variables.hdCuvCodigo).val()) == "") {
                    messageInfoValidado("por favor, seleccionar un CUV.");
                    $(this).focus();
                    return false;
                }

                if (!(parseInt($(me.Variables.txtCantidad1).val()) > 0 && parseInt($(me.Variables.txtCantidad1).val()) <= parseInt($(me.Variables.txtCantidad1).attr("data-maxvalue")))) {
                    messageInfoValidado("Lamentablemente la cantidad ingresada supera a la cantidad facturada en tu pedido (" +
                        $.trim($(me.Variables.txtCantidad1).attr("data-maxvalue")) + ")");
                    return false;
                }

                return true;
            },

            RegresarRegistro1: function () {
                $(me.Variables.Registro2).hide();
                //$(me.Variables.pasodosactivo).hide();
                //$(me.Variables.pasodos).show();
                $(me.Variables.Registro1).show();
            },

            ValidarPasoUno: function () {
                if ($(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").size() == 0) {
                    messageInfoValidado("por favor, seleccione el motivo del cambio.");
                    return false;
                }
                return true;
            },
            //HD-3412 EINCA
            ValidarPasoUnoServer: function (callbackWhenFinish) {
                var item = {
                    PedidoID: $(me.Variables.hdPedidoID).val(),
                    CUV: $(me.Variables.hdCuvCodigo).val(),
                    Cantidad: $.trim($(me.Variables.txtCantidad1).val()),
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    CampaniaID: $(me.Variables.ComboCampania).val()
                };

                $.ajaxSetup({
                    global: false,
                    type: "POST",
                    async: true,
                    cache: false,
                    url: UrlValidarPaso1,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    beforeSend: function () { ShowLoading(); },
                    complete: function () { CloseLoading(); }
                });


                $.ajax({
                    data: JSON.stringify(item),
                    success: function (data) {
                        if (checkTimeout(data)) {
                            if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                                callbackWhenFinish(data);
                            }
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
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
                    //$(me.Variables.wrpMobile).addClass(me.Variables.pb120);

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

            //CambioPaso: function (paso) {
            //    paso = paso || 1;
            //    pasoActual = pasoActual + paso || 1;
            //    pasoActual = pasoActual < 1 ? 1 : pasoActual > 3 ? 3 : pasoActual;

            //    $(".paso_reclamo[data-paso]").removeClass(me.Variables.paso_active_reclamo);
            //    $(".paso_reclamo[data-paso] span").html("");

            //    $(".paso_reclamo[data-paso]").each(function (ind, tag) {
            //        var pasoTag = $(tag).attr("data-paso");
            //        if (pasoTag < pasoActual) {
            //            $(tag).addClass(me.Variables.paso_active_reclamo);
            //            $(tag).find("span").html("<img src='" + imgCheck + "' />");
            //        }
            //        else if (pasoTag == pasoActual) {
            //            $(tag).addClass(me.Variables.paso_active_reclamo);
            //            $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoActual + "_activo") + "' />");
            //        }
            //        else $(tag).find("span").html("<img src='" + imgPasos.replace("{0}", "cdr_paso" + pasoTag) + "' />");
            //    });

            //    $('div[id^=Cambio]').hide();
            //    $('div[id^=Paso]').hide();
            //    $('[id=Paso' + pasoActual + ']').show();
            //    $('[id=Paso' + pasoActual + '] #Cambio' + paso2Actual).show();

            //    me.Funciones.ValidarVisualizacionBannerResumen();
            //},

            //CambioPaso2: function (paso) {

            //    paso2Actual = paso2Actual + (paso || 1);
            //    paso2Actual = paso2Actual < 1 ? 1 : paso2Actual > 3 ? 3 : paso2Actual;
            //    $('div[id^=Cambio]').hide();
            //    $('[id=Cambio' + paso2Actual + ']').show();
            //},

            ValidarPasoDosFaltante: function (codigoSsic) {
                var esCantidadPermitidaValida = me.Funciones.ValidarCantidadMaximaPermitida(codigoSsic);

                if (esCantidadPermitidaValida) {
                    var montoTotalPedido = $(me.Variables.hdImporteTotalPedido).val();
                    var montoProductosFaltanteActual = me.Funciones.ObtenerMontoProductosDevolver(codigoSsic);
                    var montoCuvActual = (parseFloat($(me.Variables.txtPrecioUnidad).val()) || 0) * (parseInt($(me.Variables.txtCantidad1).val()) || 0);
                    var montoDevolver = montoProductosFaltanteActual + montoCuvActual;
                    //me.Funciones.ObtenerValorParametria(codigoSsic);
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

            ValidarPasoDosFaltanteAbono: function (codigoSsic) {
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

            ValidarPasoDosDevolucion: function (codigoSsic) {
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
                            messageInfoError(data.message);
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
                            messageInfoError(data.message);
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
                            messageInfoError(data.message);
                            return false;
                        }
                        SetHandlebars("#template-operacion", data.detalle, me.Variables.divlistado_soluciones_cdr);
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
            },

            DetalleGuardar: function (operacion, callbackWhenFinish) {
                $.ajaxSetup({
                    global: false,
                    type: "POST",
                    url: UrlDetalleGuardar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function () {
                        ShowLoading();
                    },
                    complete: function () {
                        CloseLoading();
                    }
                });


                var Complemento = [];
                var cantidad = 0;
                if (dataCdrDevolucion !== null) {
                    if (dataCdrDevolucion.DataRespuestaServicio.length > 0) {
                        $.each(dataCdrDevolucion.DataRespuestaServicio, function (index, value) {
                            var arr = $.grep(datosCuv, function (item) {
                                return item.cuv === value.cuv;
                            });
                            cantidad = arr.length > 0 ? arr[0].cantidad : 1;
                            var obj = {
                                cuv: value.cuv,
                                descripcion: value.descripcion,
                                cantidad: cantidad
                            }
                            Complemento.push(obj);
                        });

                    }
                }

                var item = {
                    CDRWebID: $(me.Variables.hdCDRID).val() || 0,
                    PedidoID: $(me.Variables.hdPedidoID).val() || 0,
                    NumeroPedido: $(me.Variables.hdNumeroPedido).val() || 0,
                    CampaniaID: $(me.Variables.ComboCampania).val() || 0,
                    Motivo: $(".lista_opciones_motivo_cdr input[name='motivo-cdr']:checked").attr("id"),
                    Operacion: operacion,
                    CUV: $(me.Variables.txtCuv).html(),
                    Cantidad: $.trim($(me.Variables.txtCantidad1).val()),
                    CUV2: $(me.Variables.txtCuv2).html(),
                    Cantidad2: $(me.Variables.txtCantidad2).val(),
                    EsMovilOrigen: OrigenCDR,
                    Complemento: Complemento
                };



                $.ajax({
                    data: JSON.stringify(item),
                    async: true,
                    success: function (data) {
                        if (!checkTimeout(data)) {
                            return false;
                        }
                        if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                            callbackWhenFinish(data);
                        }
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
            ValidarCorreoDuplicadoServer: function (correo, callbackWhenFinish) {
                $.ajaxSetup({
                    global: false,
                    type: "POST",
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    async: true,
                    cache: false,
                    url: UrlValidarCorreoDuplicado,
                    beforeSend: function () {
                        ShowLoading();
                    },
                    complete: function () {
                        CloseLoading();
                    }
                });

                $.ajax({
                    data: JSON.stringify({ correo: correo }),
                    success: function (data) {
                        if (checkTimeout(data)) {
                            if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                                callbackWhenFinish(data);
                            }
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });


            },
            ValidarSolicitudCDREnvio: function (validarCorreoVacio, validarCelularVacio) {
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
                if ($(me.Variables.politica_devolucion).prop("checked") == false) {
                    messageInfoError(me.Constantes.DebeAceptarPoliticaCambios);
                    return false;
                }

                return true;
            },
            //HD-3412 EINCA
            SolicitudCDREnviar: function (callbackWhenFinish) {
                setTimeout(function () {
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

                    if ($(me.Variables.hdTieneCDRExpress).val() == '1') {
                        item.TipoDespacho = tipoDespacho;
                        item.FleteDespacho = !tipoDespacho ? 0 : $("#hdFleteDespacho").val();
                        item.MensajeDespacho = ($(!tipoDespacho ? '#divDespachoNormal' : '#divDespachoExpress').CleanWhitespace().html()).trim();
                    }

                    $.ajaxSetup({
                        global: false,
                        type: "POST",
                        async: true,
                        cache: false,
                        url: UrlSolicitudEnviar,
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        beforeSend: function () {
                            ShowLoading();
                        },
                        complete: function () {
                            CloseLoading();
                            $(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');
                        }
                    });

                    $.ajax({
                        data: JSON.stringify(item),
                        success: function (data) {
                            if (data.success) {
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
                                $(me.Variables.RegistroAceptarSolucion).hide();
                                $(me.Variables.textoMensajeCDR).hide();
                                $(me.Variables.SolicitudEnviada).show();
                                $(me.Variables.tabs_vista_cdr_wrapper).show();
                                flagSolicitudEnviada = true;
                                mostrarTab = 1;
                                if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                                    callbackWhenFinish(data);
                                }
                            }
                        },
                        error: function (data, error) {
                            CloseLoading();
                        }
                    });
                }, 0);
            },
            ValidarTelefonoServer: function (celular, callbackWhenFinish) {
                $.ajaxSetup({
                    global: false,
                    type: "POST",
                    async: true,
                    cache: false,
                    url: UrlValidaTelefono,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    beforeSend: function () { ShowLoading(); $(me.Variables.btnSiguiente4).addClass('btn_deshabilitado'); },
                    complete: function () { CloseLoading(); }
                });

                $.ajax({
                    data: JSON.stringify({ Telefono: celular }),
                    success: function (data) {
                        if (checkTimeout(data)) {
                            if (callbackWhenFinish && typeof callbackWhenFinish === "function") {
                                callbackWhenFinish(data);
                            }
                        }
                    },
                    error: function (data, error) {
                        CloseLoading();
                    }
                });
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

            PreEliminarDetalle: function (el) {
                var pedidodetalleid = $.trim($(el).attr("data-pedidodetalleid"));
                var grupoid = $.trim($(el).attr("data-detalle-grupoid"));

                var item = {
                    CDRWebDetalleID: pedidodetalleid,
                    GrupoID: grupoid
                };

                var functionEliminar = function () {
                    me.Funciones.DetalleEliminar(item);
                };

                var msg = "";
                if (grupoid.length > 0) {
                    msg = "Se eliminaran todos los registros relacionados al producto(Sets o Packs). ¿Deseas continuar?";
                } else {
                    msg = "Se eliminará el registro seleccionado. ¿Deseas continuar ?";
                }
                messageConfirmacion(msg, functionEliminar);
            },

            DetalleEliminar: function (objItem) {
                ShowLoading();
                jQuery.ajax({
                    type: 'POST',
                    url: UrlDetalleEliminar,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(objItem),
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

                pedidos = pedidos || new Array();
                SetHandlebars("#template-pedido", pedidos, "#divPedido");
                if (pedidos.length > 0) {
                    listaPedidos = pedidos;
                }
            },

            PopupPedidoSeleccionar: function (obj) {

                var objPedido = $(obj);
                var id = objPedido.attr("data-pedido-id");
                var pedidos = listaPedidos.Find("PedidoID", id);
                var pedido = pedidos.length > 0 ? pedidos[0] : new Object();
                $/*("#divPopupPedido").hide();*/
                me.Funciones.AsignarCUV(pedido);
            },

            CancelarConfirmEnvioSolicitudCDR: function () {
                $(me.Variables.divConfirmEnviarSolicitudCDR).hide();
            },

            ContinuarConfirmEnvioSolicitudCDR: function () {
                $.when(me.Funciones.CancelarConfirmEnvioSolicitudCDR()).then(function () {
                    me.Funciones.ValidarTelefonoServer($.trim($(me.Variables.txtTelefono).val()), function (data) {
                        if (!data.success) {
                            me.Funciones.ControlSetError(me.Variables.txtTelefono, me.Variables.spnTelefonoError, '*Este número de celular ya está siendo utilizado. Intenta con otro.');
                            //$(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');
                            return false;
                        } else if ($.trim($(me.Variables.txtEmail).val()) != $.trim($(me.Variables.hdEmail).val())) {
                            me.Funciones.ValidarCorreoDuplicadoServer($.trim($(me.Variables.txtEmail).val()), function (data) {
                                if (!data.success) {
                                    me.Funciones.ControlSetError(me.Variables.txtEmail, me.Variables.spnEmailError, '*Este correo ya está siendo utilizado. Intenta con otro');
                                    //$(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');
                                    return false;
                                } else {
                                    me.Funciones.SolicitudCDREnviar(function (data) {
                                        if (!data.success) {
                                            var mensajeInfo = "";
                                            if ((data.message.indexOf(mensajeChatEnLinea) > -1) && (flagAppMobile == 1)) {
                                                mensajeInfo = data.message.replace(mensajeChatEnLinea, "").trim();
                                            } else mensajeInfo = data.message;
                                            messageInfo(mensajeInfo);
                                            //$(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');
                                            return false;
                                        } else {
                                            if (data.Cantidad == 1) {
                                                //$(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');
                                                $(me.Variables.tabs_vista_cdr_wrapper).show();
                                                messageInfoValidado(data.message, "MENSAJE");
                                            } else {
                                                //Redireccionar a la vista index de reclamo
                                                window.location.href = UrlVistaSolicitudesRegistradas;
                                            }
                                        }
                                    });
                                }
                            });
                        } else {
                            me.Funciones.SolicitudCDREnviar(function (data) {
                                if (!data.success) {
                                    var mensajeInfo = "";
                                    if ((data.message.indexOf(mensajeChatEnLinea) > -1) && (flagAppMobile == 1)) {
                                        mensajeInfo = data.message.replace(mensajeChatEnLinea, "").trim();
                                    } else mensajeInfo = data.message;
                                    messageInfo(mensajeInfo);
                                    //$(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');
                                    return false;
                                } else {
                                    if (data.Cantidad == 1) {
                                        //$(me.Variables.btnSiguiente4).removeClass('btn_deshabilitado');                                        
                                        messageInfoValidado(data.message, "MENSAJE");
                                    } else {
                                        //Redireccionar a la vista index de reclamo
                                        window.location.href = UrlVistaSolicitudesRegistradas;
                                    }
                                }
                            });
                        }
                    });
                });
            },

            EscogerSolucion: function (opcion) {
                var tagCheck = $(me.Variables.divlistado_soluciones_cdr + " " + "input[type=checkbox]");
                var tagDivInfo = $(me.Variables.infoOpcionesDeCambio);
                tagCheck.not(opcion).prop('checked', false);
                if ($(opcion).is(':checked')) {
                    $(opcion).prop('checked', false);
                } else {
                    $(opcion).prop('checked', true);
                }
                var id = opcion.id;
                var isChecked = tagCheck.is(':checked');
                if (id == "" || !isChecked) {
                    var id = opcion.id;
                    //ocultamos la capa padre y los hijos
                    tagDivInfo.fadeOut(100).children().fadeOut(100);
                    $(me.Variables.btnSiguiente1).addClass(me.Variables.deshabilitarBoton);
                    return false;
                }
                //Mostramos la capa padre
                tagDivInfo.show();

                //ocultamos la capa hijo visible
                tagDivInfo.children().each(function (index, element) {
                    if ($(element).is(':visible')) {
                        $(element).fadeOut(200);
                        return false;
                    }
                });

                var producto = $(me.Variables.hdCuvCodigo).val() + " - " + $(me.Variables.hdDescripcionCuv).val();
                var cantidad = $(me.Variables.txtCantidad1).val() == "" ? 1 : parseInt($(me.Variables.txtCantidad1).val());
                var textoUnidades = " X " + cantidad + " Unidad(es)";

                if (id === me.Variables.operaciones.faltante) {
                    $.when(me.Funciones.ObtenerValorParametria(id)).then(function () {
                        $(me.Variables.spnDescripcionProductoOpcionF).text(producto);
                        $(me.Variables.spnCantidadF).html(textoUnidades);
                        $(me.Variables.OpcionEnvioDelProducto).fadeIn(200);
                    });
                }
                if (id === me.Variables.operaciones.faltanteAbono) {
                    $(me.Variables.spnDescripcionProductoOpcionG).text(producto);
                    $(me.Variables.spnCantidadG).html(textoUnidades);
                    $(me.Variables.OpcionDevolucionDinero).fadeIn(200);
                }
                if (id === me.Variables.operaciones.devolucion) {
                    $.when(me.Funciones.ObtenerValorParametria(id)).then(function () {
                        SetHandlebars("#template-opcion-devolucion", dataCdrDevolucion, "#divDevolucionSetsOrPack");
                        (flagSetsOrPack) ? $('#spnCantidadDVarios').text(textoUnidades) : $('#spnCantidadDIndividual').text(textoUnidades);
                        $(me.Variables.OpcionDevolucion).fadeIn(200);
                    });
                }
                if (id === me.Variables.operaciones.trueque) {
                    $.when(me.Funciones.ObtenerValorParametria(id)).then(function () {
                        me.Funciones.SetMontoCampaniaTotal();
                        $(me.Variables.OpcionCambioPorOtroProducto).fadeIn(200);
                    });
                }
                if (id === me.Variables.operaciones.canje) {
                    $(me.Variables.spnDescProdDevolucionC).html(producto);
                    $(me.Variables.spnCantidadC).html(textoUnidades);
                    $(me.Variables.OpcionCambioMismoProducto).fadeIn(200);
                }
                $(me.Variables.btnSiguiente1).removeClass(me.Variables.deshabilitarBoton);
            },

            AgregarEventoMostrarBotonSiguiente: function () {
                $("#listaMotivos input[name=motivo-cdr]").on('click', function () {
                    if ($(me.Variables.btnSiguiente1).hasClass(me.Variables.deshabilitarBoton)) {
                        $(me.Variables.btnSiguiente1).removeClass(me.Variables.deshabilitarBoton);
                    }
                });
            },

            SetMontoCampaniaTotal: function () {
                //$(me.Variables.wrpMobile).addClass(me.Variables.pb120);
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
                $(me.Variables.spnNumeroCampaniaReclamo).html(numeroCampania);
            },

            HideTags: function (arr) {
                if ($.isArray(arr)) {
                    $(arr).each(function (i, el) {
                        $(el).hide();
                    });
                }
            },

            PreValidacionIrFinalizar: function () {
                var id = "";
                var tag = $(me.Variables.divlistado_soluciones_cdr + " " + "input[type=checkbox]");
                var isChecked = tag.is(':checked');

                if (!isChecked) {
                    messageInfoValidado("Por favor, escoge una solución.");
                    return false;
                }

                tag.each(function () {
                    if ($(this).is(':checked')) {
                        id = $(this).attr("id");
                        return true;
                    }
                });

                //Validaciones

                //Trueque
                if (id === me.Variables.operaciones.trueque) {
                    if (!me.Funciones.ValidarPasoDosTrueque()) {
                        return { result: false, id: id };
                    }
                }

                //Devolución
                if (id === me.Variables.operaciones.devolucion) {
                    if (!me.Funciones.ValidarPasoDosDevolucion(id)) {
                        return { result: false, id: id };
                    }
                }

                //Faltante
                if (id === me.Variables.operaciones.faltante) {
                    if (!me.Funciones.ValidarPasoDosFaltante(id)) {
                        return { result: false, id: id };
                    }
                }

                //Faltante de abono
                if (id === me.Variables.operaciones.faltanteAbono) {
                    if (!me.ValidarPasoDosFaltanteAbono(id)) {
                        return { result: false, id: id };
                    }
                }

                return { result: true, id: id };
            },

            CambiarEstadoBarraProgreso: function (paso) {
                var tagContenedorBarraPasos = $('#barra_progreso .paso_reclamo');
                var lineaProgresoPasos = $('.progreso_pasos');

                //seteamos la barra
                tagContenedorBarraPasos.each(function (index, element) {
                    var elBarra = $(element);
                    if (elBarra.hasClass(me.Variables.paso_active_reclamo))
                        elBarra.removeClass(me.Variables.paso_active_reclamo);
                    if (elBarra.hasClass(me.Variables.paso_reclamo_completado))
                        elBarra.removeClass(me.Variables.paso_reclamo_completado);
                });

                //agregamos las clases según paso a cambiar
                if (paso === me.Variables.pasos.uno_seleccion_de_producto) {
                    $(me.Variables.progreso.uno_producto).addClass(me.Variables.paso_active_reclamo);
                    $(lineaProgresoPasos).css("width", "0");
                }
                if (paso === me.Variables.pasos.dos_seleccion_de_solucion) {
                    $(me.Variables.progreso.uno_producto).addClass(me.Variables.paso_reclamo_completado);
                    $(me.Variables.progreso.dos_solucion).addClass(me.Variables.paso_active_reclamo);
                    $(lineaProgresoPasos).css("width", "50%");
                }
                if (paso === me.Variables.pasos.tres_finalizar_envio_solicitud) {
                    $(me.Variables.progreso.uno_producto).addClass(me.Variables.paso_reclamo_completado);
                    $(me.Variables.progreso.dos_solucion).addClass(me.Variables.paso_reclamo_completado);
                    $(me.Variables.progreso.tres_finalizar).addClass(me.Variables.paso_active_reclamo);
                    $(lineaProgresoPasos).css("width", "100%");
                }
            },

        };

        me.Inicializar = function () {
            me.Eventos.bindEvents();
            me.Funciones.SeccionTabsFijoSegunAltoHeader();
        };
    };

    misReclamosRegistro = new PortalConsultorasReclamoRegistro();
    misReclamosRegistro.Inicializar();
});


