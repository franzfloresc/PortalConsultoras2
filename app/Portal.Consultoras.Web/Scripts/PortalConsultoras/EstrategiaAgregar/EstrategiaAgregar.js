﻿/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />

var belcorp = belcorp || {};
belcorp.estrategia = belcorp.estrategia || {};
registerEvent.call(belcorp.estrategia, "onProductoAgregado");

var EstrategiaAgregarModule = (function () {
    "use strict";

    var _config = {
        CampaniaCodigo: "",
        esFicha: false
    };
    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var dataProperties = {
        dataItem: "[data-item]",
        dataContenedorCantidad: "[data-cantidad-contenedor]",
        dataInputCantidad: "[data-input='cantidad']",
        dataEstrategia: "[data-estrategia]",
        dataOrigenPedidoWeb: "[data-OrigenPedidoWeb]",
        dataBloqueada: "data-bloqueada",
        dataItemTagBody: "[data-item-tag=\"body\"]",
        dataItemTagAgregar: "[data-item-tag=\"agregar\"]",
        dataItemTagFondo: "[data-item-tag=\"fotofondo\"]",
        dataItemTagVerDetalle: "[data-item-tag=\"verdetalle\"]",
        dataItemAccionVerDetalle: "[data-item-accion=\"verdetalle\"]",
        dataItemTagContenido: "[data-item-tag=\"contenido\"]",
        dataTono: "[data-tono]",
        dataTonoSelect: "[data-tono-select]",
        dataItemHtml: "[data-item-html]",
        tooltip: "[data-agregado=\"tooltip\"]",
        tooltipMensaje1: "[data-agregado=\"mensaje1\"]",
        tooltipMensaje2: "[data-agregado=\"mensaje2\"]",
    };

    var constantes = {
        undefined: function () {
            return "undefined";
        }
    };

    var elementosDiv = {
        divMensajeBloqueada: "#divMensajeBloqueada",
        divHVMensajeBloqueada: "#divHVMensajeBloqueada",
        divVistaPrevia: "#divVistaPrevia",
        hdErrorInsertarProducto: "#hdErrorInsertarProducto",
        hdCampaniaCodigo: "#hdCampaniaCodigo",
        EstrategiaHdMarcaID: "#Estrategia_hd_MarcaID",
        EstrategiaHdPrecioCatalogo: "#Estrategia_hd_PrecioCatalogo",
        Estrategia_hd_Digitable: "#Estrategia_hd_Digitable",
        Estrategia_hd_Grupo: "#Estrategia_hd_Grupo",
        OfertaTipoNuevo: "#OfertaTipoNuevo"
    };

    var elementosPopPup = {
        popupClose: "#popup-close"
    };

    var _elementos = {
        btnAgregar: {
            id: "#btnAgregalo",
            classDesactivado: "btn_desactivado_general"

        }
    }

    var _OrigenPedido = {
        MobileContenedorArmaTuPack: "2131502",
        DesktopContenedorArmaTuPack: "1131502"
    }

    var getEstrategia = function ($btnAgregar, origenPedidoWebEstrategia) {

        var estrategiaTxt = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataEstrategia).attr("data-estrategia")
                || $btnAgregar.parents("div.content_btn_agregar").siblings("#contenedor-showroom-subcampanias-mobile")
                        .find(".slick-active").find(dataProperties.dataEstrategia).attr("data-estrategia")
                || "";

        var estrategia = {};
        if (estrategiaTxt != "") {
            estrategia = JSON.parse(estrategiaTxt);
        }

        return estrategia;
    };

    var estrategiaObtenerObjHtmlLanding = function ($btnAgregar) {
        var itemClone = $btnAgregar.parents(dataProperties.dataItem);
        var cuvClone = $.trim(itemClone.attr("data-clone-item"));
        if (cuvClone != "") {
            itemClone = $("body").find("[data-content-item='" + $.trim(itemClone.attr("data-clone-content")) + "']")
                .find("[data-item='" + cuvClone + "']");
        }
        if (itemClone.length === 0 && cuvClone != "") {
            itemClone = $("body").find("[data-item='" + cuvClone + "']");
        }
        if (itemClone.length > 1) {
            itemClone = $(itemClone.get(0));
        }

        return itemClone;
    };

    var estrategiaEstaBloqueada = function ($btnAgregar, campaniaId) {

        if ($btnAgregar.attr(dataProperties.dataBloqueada) === "") return false;

        if (campaniaId === parseInt(_config.CampaniaCodigo)) return false;

        return true;
    };

    var abrirMensajeEstrategia = function (txt, esFicha) {
        var tipoOrigenEstrategiaAux = 0;
        if (typeof tipoOrigenEstrategia != "undefined") {
            tipoOrigenEstrategiaAux = tipoOrigenEstrategia;
        }

        if (tipoOrigenEstrategiaAux == 1) {
            alert_msg_pedido(txt);
        } else if (tipoOrigenEstrategiaAux == 11 || tipoOrigenEstrategiaAux == 17 || tipoOrigenEstrategiaAux == 172) {
            alert_msg(txt);
        } else if (tipoOrigenEstrategiaAux == 2 || tipoOrigenEstrategiaAux == 21 || tipoOrigenEstrategiaAux == 262) {
            messageInfo(txt);
        } else if (txt.indexOf("cantidad limite") > 0) {
            if (esFicha) {
                var $limitePedidoToolTip = $('[data-limitepedido="tooltip"]');
                if ($limitePedidoToolTip.length > 0) {
                    $limitePedidoToolTip.show();
                    setTimeout(function () { $limitePedidoToolTip.hide(); }, 2000);
                }
            } else {
                if (isMobile()) {
                    messageInfo(txt);
                } else {
                    alert_msg(txt);
                }
            }
        } else if (isMobile()) {
            messageInfo(txt);
        } else {
            alert_msg(txt);
        }
    };

    var getOrigenPedidoWeb = function ($btnAgregar, esUrl) {
        var origenPedidoWeb = (esUrl) ? $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidoweb")
            : (
                $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidowebagregar")
                || $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidoweb")
            );
        origenPedidoWeb = origenPedidoWeb || 0;
        return origenPedidoWeb.toString();
    };

    var DivMsgBloqueadoBuilder = function ($btnAgregar, estrategia) {

        var $btnAgregarTmp = $btnAgregar;
        var $divMsgProductoBloqueado = null;
        var dataItemHtml = null;
        var estrategiaTmp = estrategia;
        return {
            getDivMsgProductoBloqueado: function () {
                $divMsgProductoBloqueado = $(elementosDiv.divMensajeBloqueada);

                return this;
            },
            getHtmlProductoBloqueado: function () {
                var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregarTmp);
                dataItemHtml = $divMsgProductoBloqueado.find(dataProperties.dataItemHtml);

                if (!_config.esFicha)
                    dataItemHtml.html(itemClone.html());

                return this;
            },
            formatDivMsgProductoBloqueado: function () {
                dataItemHtml.find(dataProperties.dataItemTagBody).removeAttr("data-estrategia");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("min-height", "auto");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("float", "none");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("margin", "0 auto");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("background-color", "#fff");
                dataItemHtml.find(dataProperties.dataItemTagBody).attr("class", "");
                dataItemHtml.find(dataProperties.dataItemTagAgregar).remove();
                dataItemHtml.find(dataProperties.dataItemTagFondo).remove();
                dataItemHtml.find(dataProperties.dataItemTagVerDetalle).remove();
                dataItemHtml.find(dataProperties.dataItemAccionVerDetalle).remove();
                dataItemHtml.find(dataProperties.dataItemTagContenido).removeAttr("onclick");
                dataItemHtml.find(dataProperties.dataItemTagContenido).css("position", "initial");
                dataItemHtml.find(dataProperties.dataItemTagContenido).attr("class", "");

                return this;
            },
            build: function () {
                return $divMsgProductoBloqueado;
            }
        };
    };

    var getDivMsgBloqueado = function ($btnAgregar, estrategia) {
        var divMsgBloqueadoBuilder = new DivMsgBloqueadoBuilder($btnAgregar, estrategia);
        return divMsgBloqueadoBuilder
            .getDivMsgProductoBloqueado()
            .getHtmlProductoBloqueado()
            .formatDivMsgProductoBloqueado()
            .build();
    };

    var sendAnalyticAgregarProductoDeshabilitado = function (estrategia, isPopup) {
        try {
            isPopup = isPopup || false;
            if (typeof popup != "undefined") {
                isPopup = popup;
            }

            var name = $.trim(estrategia.DescripcionResumen + " " + estrategia.DescripcionCortada);
            rdAnalyticsModule.AgregarProductoDeshabilitado(
                estrategia.OrigenPedidoWebEstrategia,
                estrategia.CampaniaID,
                name,
                isPopup);
        } catch (e) {
            console.log(e);
        }
    };

    var _getClienteIdSelected = function () {
        var clientId = 0;

        var $divFichaReumida = $('#DivPopupFichaResumida');
        if ((typeof $divFichaReumida !== "undefined" || $divFichaReumida !== null) && 
            $divFichaReumida.find("#hfClienteId").length >0) {
            clientId = $($divFichaReumida.find("#hfClienteId")[0]).val();
        }

        return clientId;
    }

    var estrategiaAgregar = function (event, popup, limite, esFicha, esEditable) {
          
        popup = popup || false;
        limite = limite || 0;
        esEditable = esEditable || false;

        _config.esFicha = esFicha || _config.esFicha;
        _config.CampaniaCodigo = $(elementosDiv.hdCampaniaCodigo).val() || _config.CampaniaCodigo;

        var $btnAgregar = $(event.target);
        //console.log($btnAgregar);
        var origenPedidoWebEstrategia = getOrigenPedidoWeb($btnAgregar);

        //*****ANALYTICS ******
        if (AnalyticsPortalModule != 'undefined') {
            if (typeof (fichaModule) != "undefined") {
                if (typeof (fichaModule.GetEstrategia) != "undefined") {
                    var estrategia = fichaModule.GetEstrategia();
                    AnalyticsPortalModule.MarcaFichaResumidaClickModificar(estrategia.OrigenPedidoEditar, isChangeTono, isChangeCantidad, isChangeCliente);
                }
            }
            
        }
        //**FIN ANALYTICS *****

        var estrategia = getEstrategia($btnAgregar, origenPedidoWebEstrategia);

        if (estrategiaEstaBloqueada($btnAgregar, estrategia.CampaniaID)) {
            estrategia.OrigenPedidoWebEstrategia = origenPedidoWebEstrategia;
            getDivMsgBloqueado($btnAgregar, estrategia).show();
            sendAnalyticAgregarProductoDeshabilitado(estrategia, popup);
            return false;
        }

        if (_ValidarSeleccionTono($btnAgregar, _config.esFicha)) {
            return false;
        }

        var cantidad = (limite > 0) ? limite : ($btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val());

        if (!$.isNumeric(cantidad)) {
            abrirMensajeEstrategia("Ingrese un valor numérico.", esFicha);
            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");
            CerrarLoad();
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            abrirMensajeEstrategia("La cantidad debe ser mayor a cero.", esFicha);
            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");
            CerrarLoad();
            return false;
        }
        estrategia.Cantidad = cantidad;

        if (!isMobile()) {
            estrategia.FlagNueva = estrategia.FlagNueva == "1" ? estrategia.FlagNueva : "";
            $(elementosDiv.OfertaTipoNuevo).val(estrategia.FlagNueva);
        }

        AbrirLoad();

        var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregar);
        if (isPagina("ofertas") && !isMobile()) {
            var estratediaId = itemClone.data("item");
            if (estratediaId != "") {
                itemClone = itemClone.parent().find("[data-item=" + estratediaId + "]");
            }
        }
        var divAgregado = $(itemClone).find(".agregado.product-add");

        var cuvs = "";
        var codigoVariante = estrategia.CodigoVariante;
        if ((_codigoVariedad.IndividualVariable == codigoVariante || _codigoVariedad.CompuestaVariable == codigoVariante)) {
            var listaCuvs = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataTono.concat(dataProperties.dataTonoSelect));
            if (listaCuvs.length > 0) {
                $.each(listaCuvs,
                    function (i, item) {
                        var cuv = $(item).attr("data-tono-select");
                        if (cuv != "") {
                            cuvs = cuvs + (cuvs == "" ? "" : "|") + cuv;

                            cuvs = cuvs + ";" + $(item).find(elementosDiv.EstrategiaHdMarcaID).val();
                            cuvs = cuvs + ";" + $(item).find(elementosDiv.EstrategiaHdPrecioCatalogo).val();
                            cuvs = cuvs + ";" + "";
                            cuvs = cuvs + ";" + $(item).find(elementosDiv.Estrategia_hd_Digitable).val();
                            cuvs = cuvs + ";" + $(item).find(elementosDiv.Estrategia_hd_Grupo).val();

                        }
                    });
            }
        }

        var tipoEstrategiaImagen = $btnAgregar.parents(dataProperties.dataItem).attr("data-tipoestrategiaimagenmostrar");

        var params = {
            CuvTonos: $.trim(cuvs),
            CUV: $.trim(estrategia.CUV2),
            Cantidad: $.trim(cantidad),
            TipoEstrategiaID: estrategia.TipoEstrategiaID,
            EstrategiaID: $.trim(estrategia.EstrategiaID),
            OrigenPedidoWeb: $.trim(origenPedidoWebEstrategia),
            TipoEstrategiaImagen: tipoEstrategiaImagen || 0,
            FlagNueva: $.trim(estrategia.FlagNueva),
            EsEditable: estrategia.esEditable,
            SetId: estrategia.setId,
            ClienteID: _getClienteIdSelected()
        };

        EstrategiaAgregarProvider
            .pedidoAgregarProductoPromise(params)
            .done(function (data) {
                if (!checkTimeout(data)) {
                    CerrarLoad();
                    return false;
                }

                if (data.success === false) {
                    if (!IsNullOrEmpty(data.mensajeAviso)) AbrirMensaje(data.mensajeAviso, data.tituloMensaje);
                    else abrirMensajeEstrategia(data.message, esFicha);

                    CerrarLoad();
                    return false;
                }


                var cuv = estrategia.CUV2;
                if (cuv.substring(0, 3) == '999') {
                    sessionStorage.setItem('cuvPack', cuv);
                }

                try {
                    if (!(typeof AnalyticsPortalModule === 'undefined')) {
                        AnalyticsPortalModule.MarcaAnadirCarritoGenerico(event, origenPedidoWebEstrategia, estrategia);
                    }
                    TrackingJetloreAdd(cantidad, $(elementosDiv.hdCampaniaCodigo).val(), cuv);
                } catch (e) {
                    console.log(e);
                }

                $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");

                if (divAgregado != null) {
                    if (typeof divAgregado.length != "undefined" && divAgregado.length > 0) {
                        divAgregado.each(function (index, element) {
                            $(element).show();
                        });
                    }

                    $(divAgregado).show();

                    if ($btnAgregar[0]) {
                        var contenedorAgregado = $($btnAgregar).parent().find('#ContenedorAgregado')[0];

                        if (!contenedorAgregado) {
                            contenedorAgregado = $($btnAgregar).parent().parent().find('.contenedor_agregado');
                        }


                        if (contenedorAgregado) {
                            $(contenedorAgregado).show();
                        }
                    }
                }

                //Tooltip de agregado
                if (esFicha) {
                    try {
                        var $AgregadoTooltip = $(dataProperties.tooltip);
                        if (params.EsEditable) {
                            $AgregadoTooltip.find(dataProperties.tooltipMensaje1).html("¡Listo! ");
                            $AgregadoTooltip.find(dataProperties.tooltipMensaje2).html(" Modificaste tu pedido");
                        }
                        $AgregadoTooltip.show();
                        setTimeout(function () {
                            $AgregadoTooltip.hide();
                            if (origenPedidoWebEstrategia === _OrigenPedido.DesktopContenedorArmaTuPack) {
                                window.location = "/ofertas";
                            } else if (origenPedidoWebEstrategia === _OrigenPedido.MobileContenedorArmaTuPack) {
                                window.location = "/mobile/ofertas";

                            }
                        }, 2500);
                        if (!(origenPedidoWebEstrategia === _OrigenPedido.DesktopContenedorArmaTuPack || origenPedidoWebEstrategia === _OrigenPedido.MobileContenedorArmaTuPack)) {
                            ResumenOpcionesModule.LimpiarOpciones();
                        }
                        else {
                            return;
                        }
                    } catch (e) {
                        console.error(e);
                    }

                }
                var barraJsLoaded = typeof MostrarBarra === 'function';

                if (barraJsLoaded) {
                    var destino = isPagina('pedido') ? '2': '1';
                    var prevTotal = mtoLogroBarra || 0;
                    var issetPopupPremio = $("#popupPremio").length > 0;

                    if ($("#divBarra").length > 0) {
                        MostrarBarra(data, destino);

                        if (issetPopupPremio) {
                            showPopupNivelSuperado(data.DataBarra, prevTotal);
                        } else {
                            addPremioDefaultSuperado(data.DataBarra, prevTotal);
                        }
                    } else {
                        ActualizarGanancia(data.DataBarra);
                        calcMtoLogro(data, destino);
                        addPremioDefaultSuperado(data.DataBarra, prevTotal);
                    }
                }

                if (isMobile()) {
                    CargarCantidadProductosPedidos(true);
                    microefectoPedidoGuardado();

                } else {
                    CargarResumenCampaniaHeader(true);
                }
                
                var tipoOrigenEstrategiaAux = 0;
                if (typeof tipoOrigenEstrategia != "undefined") {
                    tipoOrigenEstrategiaAux = tipoOrigenEstrategia || 0;
                }

                if (tipoOrigenEstrategiaAux == 1) {
                    if (typeof MostrarBarra != constantes.undefined()) {
                        MostrarBarra(data, "1");
                    }

                    if (estrategia.CodigoEstrategia == ConstantesModule.TipoEstrategia.PackNuevas) {
                        if (typeof CargarCarouselEstrategias != constantes.undefined())
                            CargarCarouselEstrategias();
                    }

                    if (typeof tieneMasVendidos != constantes.undefined()) {
                        if (tieneMasVendidos === 1) {
                            if (typeof CargarCarouselMasVendidos != constantes.undefined())
                                CargarCarouselMasVendidos("desktop");
                        }
                    }
                }
                else if (tipoOrigenEstrategiaAux == 11) {

                    $(elementosDiv.hdErrorInsertarProducto).val(data.errorInsertarProducto);

                    cierreCarouselEstrategias();
                    if (estrategia.CodigoEstrategia == ConstantesModule.TipoEstrategia.PackNuevas) {
                        if (typeof CargarCarouselEstrategias != constantes.undefined())
                            CargarCarouselEstrategias();
                    }
                    HideDialog(elementosDiv.divVistaPrevia.substring(1));
                    CargarDetallePedido();
                    var previousTotal = mtoLogroBarra || 0;
                    MostrarBarra(data);
                    showPopupNivelSuperado(data.DataBarra, previousTotal);
                } else if (tipoOrigenEstrategiaAux == 2 ||
                    tipoOrigenEstrategiaAux == 21 ||
                    tipoOrigenEstrategiaAux == 22 ||
                    tipoOrigenEstrategiaAux == 27 ||
                    tipoOrigenEstrategiaAux == 262 ||
                    tipoOrigenEstrategiaAux == 272) {
                    
                    if (isPagina('mobile/pedido/detalle')) CargarPedido(false);

                    if (tipoOrigenEstrategiaAux == 262) {

                        var origenRetornoAux = $.trim(origenRetorno);
                        if (origenRetornoAux != "") {
                            setTimeout(function () {
                                window.location = origenRetornoAux;
                            },
                                3700);

                        }
                    } else if (tipoOrigenEstrategiaAux != 272) {
                        if (estrategia.CodigoEstrategia == ConstantesModule.TipoEstrategia.PackNuevas) {
                            CargarCarouselEstrategias();
                        }

                        if (typeof tieneMasVendidos !== "undefined" && tieneMasVendidos === 1) {
                            CargarCarouselMasVendidos("mobile");
                        }
                    }
                }

                if (data.listCuvEliminar != null) {
                    $.each(data.listCuvEliminar, function (i, cuvElem) {

                        itemClone.parent().find('[data-item-cuv=' + cuvElem + '] .agregado.product-add').hide();

                        ActualizarLocalStoragePalancas(cuvElem, false);
                    })
                }

                var localStorageModule = new LocalStorageModule();
                localStorageModule.ActualizarCheckAgregado($.trim(estrategia.EstrategiaID), estrategia.CampaniaID, estrategia.CodigoPalanca, true);
                
                CerrarLoad();
                if (popup) {
                    CerrarPopup(elementosPopPup.popupDetalleCarouselLanzamiento);
                    $(elementosPopPup.popupDetalleCarouselPackNuevas).hide();
                }
                else {
                    if (_config.esFicha) {
                        if (params.CuvTonos != "") {
                            var listaCuvs = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataTono.concat(dataProperties.dataTonoSelect));
                            if (listaCuvs.length > 0) {
                                $(".texto_sin_tono").find(".tono_seleccionado").hide();
                                var $ContentTonoDetalle = $(".content_tono_detalle");
                                if ($ContentTonoDetalle.length > 0) {
                                    $ContentTonoDetalle.removeClass("borde_seleccion_tono");
                                }
                                $btnAgregar.addClass("btn_desactivado_general");

                                $.each(listaCuvs,
                                    function (i, item) {
                                        if (!(item.hasAttribute('data-tono-digitable')))
                                            var cuv = $(item).attr("data-tono-select", "");
                                    });
                            }

                        }
                    }
                }
                if (!IsNullOrEmpty(data.mensajeAviso)) AbrirMensaje(data.mensajeAviso, data.tituloMensaje);
                if (estrategia.TipoAccionNavegar == ConstantesModule.TipoAccionNavegar.Volver) {
                    FichaPartialModule.ShowDivFichaResumida(false);
                }
                return false;
            })
            .fail(function (data, error) {
                CerrarLoad();
            });
        
        return false;
    };

    var selectorCantidadEstaBloquedo = function ($element) {
        var result = false;
        var dataBloquedaAttrValue = $element.data("bloqueada");
        if (typeof dataBloquedaAttrValue !== "undefined" &&
            $.trim(dataBloquedaAttrValue) !== "") {
            result = true;
        }
        return result;
    };

    var adicionarCantidad = function (e) {

        e.stopPropagation();
        var $this = $(e.target);
        if (selectorCantidadEstaBloquedo($this)) return false;
        var $inputCantidad = $this.parents(dataProperties.dataContenedorCantidad).find(dataProperties.dataInputCantidad);
        var cantidad = parseInt($inputCantidad.val());
        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad < 99 ? (cantidad + 1) : 99;
        $inputCantidad.val(cantidad);
        _verificarActivarBtn();   //habilitar botón solo cuando está en la ficha resumida
        return false;
    };

    var _verificarActivarBtn = function (codigoVariante) {
        if (typeof (fichaModule) != "undefined") {
            if (typeof (fichaModule.GetEstrategia) != "undefined") {
                var estrategia = fichaModule.GetEstrategia();
                if (estrategia.esEditable) { //todos menos la 2003 (tipos&tonos)
                    EstrategiaAgregarModule.HabilitarBoton();
                    isChangeCantidad = true; //para hacer seguimiento al marcar analytics
                }
            }
        }
    };

    var disminuirCantidad = function (e) {

        e.stopPropagation();

        var $this = $(e.target);
        if (selectorCantidadEstaBloquedo($this)) return false;
        var $inputCantidad = $this.parents(dataProperties.dataContenedorCantidad).find(dataProperties.dataInputCantidad);
        var cantidad = parseInt($inputCantidad.val());
        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad > 1 ? (cantidad - 1) : 1;
        $inputCantidad.val(cantidad);
        _verificarActivarBtn(); //habilitar botón solo cuando está en la ficha resumida
        return false;
    };
    var validaCantidad = function (e) {
        _verificarActivarBtn(); //habilitar botón solo cuando está en la ficha resumida

    }
    var deshabilitarBoton = function () {
        $(_elementos.btnAgregar.id).addClass(_elementos.btnAgregar.classDesactivado);
    };

    var habilitarBoton = function () {
        $(_elementos.btnAgregar.id).removeClass(_elementos.btnAgregar.classDesactivado);
    }

    var _ValidarSeleccionTono = function (objInput, esFicha) {
        var attrClass = $.trim($(objInput).attr("class"));
        if ((" " + attrClass + " ").indexOf(" btn_desactivado_general ") >= 0) {

            var $SelectTonos = $(objInput).parents("[data-item]").find("[data-opciones-seleccionadas='0']").find("[data-tono-change='1']");
            var $SeleccionTonoToolTip = $("[data-selecciontono='tooltip']");

            if (isMobile()) {
                if (esFicha) {
                    if ($SelectTonos.length > 0) {
                        var $PrimerElemento = $SelectTonos[0];
                        var Altura = $($PrimerElemento).offset().top - 200;
                        window.scrollTo(0, Altura);
                    }
                }
            }

            if (esFicha) {
                $SeleccionTonoToolTip.show();
                setTimeout(function () { $SeleccionTonoToolTip.hide(); }, 2000);
            }

            $SelectTonos.removeClass("texto_sin_tono").addClass("variedad_sin_seleccionar");
            setTimeout(
                function () {
                    $SelectTonos.removeClass("variedad_sin_seleccionar").addClass("texto_sin_tono");
                }, 1000);
            return true;
        }
        return false;
    }

    return {
        EstrategiaAgregar: estrategiaAgregar,
        EstrategiaObtenerObj: getEstrategia,
        GetOrigenPedidoWeb: getOrigenPedidoWeb,
        AdicionarCantidad: adicionarCantidad,
        DisminuirCantidad: disminuirCantidad,
        ValidaCantidad: validaCantidad,
        ElementosDiv: elementosDiv,
        DeshabilitarBoton: deshabilitarBoton,
        HabilitarBoton: habilitarBoton
    };
})();