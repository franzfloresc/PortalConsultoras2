var FichaProducto;
$(document).ready(function () {
    'use strict';
    if (!window.hasOwnProperty("VirtualCoachCuv")) {
        Object.defineProperty(window, 'VirtualCoachCuv', { value: '' });
    }
    if (!window.hasOwnProperty("VirtualCoachCampana")) {
        Object.defineProperty(window, 'VirtualCoachCampana', { value: 0 });
    }

    var mainFP;

    mainFP = function () {
        var me = this;
        me.settings = {
            popupId: '#popupDetalleCarousel_lanzamiento',
            templateDetalleId: '#fichaproducto-template',
            cuv: VirtualCoachCuv || '',
            campana: VirtualCoachCampana || 0
        };
        me.globals = {
            Producto: null
        };
        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('click', '#btnAceptarNoHayProducto', me.Funciones.IrASeccionBienvenida);
            },
            Ready: function () {

                if (!window.hasOwnProperty('detalleFichaProducto'))
                    FichaProducto.Funciones.ObtenerProducto();

                if (isMobile()) {

                    var cabecera = document.getElementsByTagName("head")[0];
                    var nuevoScript = document.createElement('script');
                    nuevoScript.type = 'text/javascript';
                    nuevoScript.src = "https://ok383.infusionsoft.com/app/webTracking/getTrackingCode";
                    nuevoScript.id = "infusionsoft";
                    cabecera.appendChild(nuevoScript);

                    me.Funciones.Marcador();
                    // ----ppc
                    var id_tono_sel = '#fav_tono_' + me.settings.cuv;
                    $(id_tono_sel).trigger('click');     
                //----ppc
                }
            },
            AlertaMensajeProductoNotFound: function () {
                alert_msg("El producto que estás buscando no se encuentra en esta campaña!", "¡UPSS!", function () {
                    me.Funciones.IrASeccionBienvenida();
                });
            },
            AlertaMensaje: function (mensaje) {
                alert_msg(mensaje);
            },
            IrASeccionBienvenida: function () {
                if (!window.hasOwnProperty("seccionMisOfertas")) {
                    Object.defineProperty(window, 'seccionMisOfertas', { value: 'MisOfertas' });
                }
                var url = "/Bienvenida?verSeccion=" + seccionMisOfertas;
                window.location = url;
            },
            VerDetalleFichaProducto: function (ficha) {
                ficha.Posicion = 1;
                ficha.CodigoVariante = $.trim(ficha.CodigoVariante);

                ficha.Detalle = new Array();
                var btnDesabled = 0;
                if (ficha.CodigoVariante != "") {
                    ficha.Detalle = me.globals.Producto.Hermanos;
                    me.globals.Producto.Detalle = me.globals.Producto.Hermanos;
                    me.Funciones.ShowLoading();
                    ficha.Linea = "0px";
                    if (ficha.Detalle.length > 0) {
                        $.each(ficha.Detalle, function (i, item) {
                            item.Hermanos = item.Hermanos || new Array();
                            item.CUVSelect = "";
                            item.ImagenBulkSelect = i == 0 ? item.ImagenBulk : "";
                            item.NombreBulkSelect = i == 0 ? item.NombreBulk : "";

                            if (ficha.CodigoVariante == "1")
                                btnDesabled = 1;

                            if (item.Hermanos.length > 0) {
                                $.each(item.Hermanos, function (i, itemH) {
                                    itemH.CUVSelect = "";
                                });
                                item.ImagenBulkSelect = item.Hermanos[0].ImagenBulk;
                                item.NombreBulkSelect = item.Hermanos[0].NombreBulk;

                                item.Hermanos[0].CUVSelect = item.Hermanos[0].CUV;
                                item.Hermanos[0].ImagenBulkSelect = item.Hermanos[0].ImagenBulk;
                                item.Hermanos[0].NombreBulkSelect = item.Hermanos[0].NombreBulk;

                                item.NombreComercial = item.Hermanos[0].NombreComercial;

                                ficha.Linea = "1px solid #ccc";
                                btnDesabled = 1;
                            }
                        });
                        ficha.ImagenBulkSelect = ficha.Detalle[0].ImagenBulkSelect;
                        ficha.NombreBulkSelect = ficha.Detalle[0].NombreBulkSelect;
                    }
                    else {
                        ficha.CodigoVariante = "";
                    }
                }

                SetHandlebars(me.settings.templateDetalleId, ficha, me.settings.popupId);

                if (btnDesabled == 0) {
                    btnDesabled = $(me.settings.popupId).find("#tbnAgregarProducto").attr("data-bloqueada") || "";
                    if (btnDesabled == "") {
                        $(me.settings.popupId).find("#tbnAgregarProducto").removeClass("btn_desactivado_general");
                    }
                }
                else {
                    $(me.settings.popupId).find("#tbnAgregarProducto").addClass("btn_desactivado_general");
                }

                AbrirPopup(me.settings.popupId);
                $(".indicador_tono").click();
                $(".indicador_tono").click();

                me.Funciones.FichaProductoMasTonos();
                TrackingJetloreView(ficha.CUV2, $("#hdCampaniaCodigo").val());
                me.Funciones.CloseLoading();
                //----ppc
                
                var cuvp = ficha.CUV2;
                var id_tono_sel = '#fav_tono_' + cuvp;
                
                $(me.settings.popupId).find(id_tono_sel).trigger('click');
                
                //----ppc
            },
            ObtenerProducto: function () {

                if (me.settings.cuv !== "") {
                    var fichaPromise = me.Funciones.ObtenerProductoPromise(me.settings.cuv, me.settings.campana);

                    $.when(fichaPromise).then(function (response) {
                        if (checkTimeout(response)) {
                            if (response !== null) {

                                var cabecera = document.getElementsByTagName("head")[0];
                                var nuevoScript = document.createElement('script');
                                nuevoScript.type = 'text/javascript';
                                nuevoScript.src = "https://ok383.infusionsoft.com/app/webTracking/getTrackingCode";
                                nuevoScript.id = "infusionsoft";
                                cabecera.appendChild(nuevoScript);
                                me.globals.Producto = response;
                                me.Funciones.Marcador();
                                me.Funciones.VerDetalleFichaProducto(response);
                            } else {
                                me.Funciones.AlertaMensajeProductoNotFound();
                            }
                        }
                    });
                }
            },
            ObtenerProductoPromise: function (cuv, campaniaId) {
                var d = $.Deferred();

                var promise = $.ajax({
                    type: 'GET',
                    url: baseUrl + 'FichaProducto/ObtenerFichaProducto?cuv=' + cuv + '&campanaId=' + campaniaId,
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    async: true
                });

                promise.done(function (response) {
                    d.resolve(response);
                })
                promise.fail(d.reject);

                return d.promise();
            },
            FichaProductoMasTonos: function (menos) {
                if (!isMobile()) {
                    return false;
                }

                var tonos = $("#popupDetalleCarousel_lanzamiento [data-tono-div] [data-tono-change]");
                var h = $(tonos[0]).height();
                var w = $(tonos[0]).width();
                var total = tonos.length;
                var t = $("#popupDetalleCarousel_lanzamiento [data-tono-div]").width();
                if (w * total > t) {
                    $(".indicador_tono").show();
                }
                else {
                    $(".indicador_tono").hide();

                }
                $("#popupDetalleCarousel_lanzamiento [data-tono-div]").css("height", Math.max(h, w) + 5);


            },
            ProductoAgregar: function (event, popup, limite) {
                var obj = {};
                var htmlObj = $("[data-item=" + VirtualCoachCuv + "]").find("[data-ficha]").attr("data-ficha");
                if (isMobile() && htmlObj)
                    obj = JSON.parse(htmlObj);

                var ficha = me.globals.Producto || obj;

                var objInput = $(event.target);

                if (me.Funciones.ValidarSeleccionTono(objInput)) {
                    return false;
                }

                popup = popup || false;
                limite = limite || 0;
                var cantidad = (limite > 0) ? limite
                    : (
                        $(".btn_agregar_ficha_producto ").parents("[data-item]").find("input.liquidacion_rango_cantidad_pedido").val()
                        || $(objInput).parents("[data-item]").find("input.rango_cantidad_pedido").val()
                        || $(objInput).parents("[data-item]").find("[data-input='cantidad']").val()
                    );

                if (!$.isNumeric(cantidad)) {
                    me.Funciones.AlertaMensaje("Ingrese un valor numérico.");
                    $('.liquidacion_rango_cantidad_pedido').val(1);
                    me.Funciones.CloseLoading();
                    return false;
                }
                if (parseInt(cantidad) <= 0) {
                    me.Funciones.AlertaMensaje("La cantidad debe ser mayor a cero.");
                    $('.liquidacion_rango_cantidad_pedido').val(1);
                    me.Funciones.CloseLoading();
                    return false;
                }

                var agregoAlCarro = false;
                if (!isMobile()) {
                    ficha.FlagNueva = ficha.FlagNueva == "1" ? ficha.FlagNueva : "";
                    $('#OfertaTipoNuevo').val(ficha.FlagNueva);
                }

                me.Funciones.ShowLoading();

                var cuvs = "";
                var CodigoVariante = ficha.CodigoVariante;
                if ((CodigoVariante == "2001" || CodigoVariante == "2003") && popup) {
                    var listaCuvs = $(objInput).parents("[data-item]").find("[data-tono][data-tono-select]");
                    if (listaCuvs.length > 0) {
                        $.each(listaCuvs, function (i, item) {
                            var cuv = $(item).attr("data-tono-select");
                            if (cuv != "") {
                                cuvs = cuvs + (cuvs == "" ? "" : "|") + cuv;
                                if (CodigoVariante == "2003") {
                                    cuvs = cuvs + ";" + $(item).find("#Estrategia_hd_MarcaID").val();
                                    cuvs = cuvs + ";" + $(item).find("#Estrategia_hd_PrecioCatalogo").val();
                                }
                            }
                        });
                    }
                }

                if (!origenPedidoWebFichaProducto) {
                    origenPedidoWebFichaProducto =
                        $(objInput).parents("[data-item]").find("input.OrigenPedidoWeb").val()
                        || $(objInput).parents("[data-item]").attr("OrigenPedidoWeb")
                        || $(objInput).parents("[data-item]").attr("data-OrigenPedidoWeb")
                        || $(objInput).parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb")
                        || origenPedidoWebFichaProducto;
                }

                var tipoEstrategiaImagen = $(objInput).parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

                var params = {
                    CuvTonos: $.trim(cuvs),
                    Cantidad: $.trim(cantidad),
                    TipoEstrategiaID: ficha.TipoEstrategiaID,
                    EstrategiaID: $.trim(ficha.EstrategiaID),
                    OrigenPedidoWeb: $.trim(origenPedidoWebFichaProducto),
                    TipoEstrategiaImagen: tipoEstrategiaImagen || 0,
                    FlagNueva: $.trim(ficha.FlagNueva)
                };

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'Pedido/PedidoAgregarProducto',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {

                        if (!checkTimeout(data)) {
                            me.Funciones.CloseLoading();
                            return false;
                        }

                        dataLayer.push({
                            'event': 'addToCart',
                            'ecommerce': {
                                'currencyCode': 'PEN',
                                'add': {
                                    'actionField': { 'list': 'Coach Virtual – Pop Up' },
                                    'products': [{
                                        'name': $.trim(ficha.DescripcionCompleta),
                                        'price': $.trim(ficha.PrecioVenta),
                                        'brand': $.trim(ficha.DescripcionMarca),
                                        'id': $.trim(ficha.CUV2),
                                        'quantity': $.trim(cantidad)
                                    }]
                                }
                            }
                        })


                        if (data.success === false) {
                            me.Funciones.AlertaMensaje(data.message);
                            me.Funciones.CloseLoading();
                            return false;
                        }

                        if (!isMobile() && !agregoAlCarro) {
                            agregarProductoAlCarrito(objInput);
                            agregoAlCarro = true;
                        }

                        me.Funciones.ShowLoading();

                        if (isMobile()) {
                            if (tipoOrigenFichaProducto == 2) {
                                origenRetorno = $.trim(origenRetorno);
                                if (origenRetorno != "") {
                                    window.location = origenRetorno;
                                }
                            }
                        } else {
                            MostrarBarra(data, '1');
                            ActualizarGanancia(data.DataBarra);
                            CargarResumenCampaniaHeader();
                            HideDialog("divVistaPrevia");
                            CargarDetallePedido();
                        }

                        me.Funciones.CloseLoading();
                        if (popup) {
                            CerrarPopup('#popupDetalleCarousel_lanzamiento');
                            //$('#popupDetalleCarousel_packNuevas').hide(); //DEUDA TECNICA
                        }

                    },
                    error: function (data, error) {
                        me.Funciones.CloseLoading();
                    }
                });

            },
            ValidarSeleccionTono: function (objInput) {
                var attrClass = $.trim($(objInput).attr("class"));
                if ((" " + attrClass + " ").indexOf(" btn_desactivado_general ") >= 0) {
                    $(objInput).parents("[data-item]").find("[data-tono-select='']").find("[data-tono-change='1']").parent().addClass("tono_no_seleccionado");
                    setTimeout(function () {
                        $(objInput).parents("[data-item]").find("[data-tono-change='1']").parent().removeClass("tono_no_seleccionado");
                    }, 500);
                    return true;
                }
                return false;
            },
            ShowLoading: function () {
                if (isMobile()) {
                    ShowLoading();
                } else {
                    waitingDialog();
                }
            },
            CloseLoading: function () {
                if (isMobile()) {
                    CloseLoading();
                } else {
                    closeWaitingDialog();
                }
            },
            Marcador: function () {

                dataLayer.push({
                    'event': 'promotionView',
                    'ecommerce': {
                        'promoView': {
                            'promotions': [
                                {
                                    'id': 'contenedor_popup_detalleCarousel',
                                    'name': 'Coach Virtual – Ficha de producto',
                                    'position': 'Home pop-up',
                                    'creative': 'Banner'
                                }]
                        }
                    }
                });
            }
        };
        me.Eventos = {
        };
        me.Inicializar = function () {
            me.Funciones.InicializarEventos();
            me.Funciones.Ready();
        };
    }
    FichaProducto = new mainFP();

    FichaProducto.Inicializar();
});
