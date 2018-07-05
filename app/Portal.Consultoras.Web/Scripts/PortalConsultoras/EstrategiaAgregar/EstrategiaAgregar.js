/// <reference path="../../../Scripts/jquery-1.11.2.js" />
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

var EstrategiaAgregarModule = (function () {
    "use strict";

    var _config = {
        CampaniaCodigo: "",
        esFicha: false
    };

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
        dataItemTagContenido : "[data-item-tag=\"contenido\"]",
        dataTono: "[data-tono]",
        dataTonoSelect: "[data-tono-select]",
        dataItemHtml: "[data-item-html]"
    };

    var constantes = {
        undefined: function(){
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
        OfertaTipoNuevo: "#OfertaTipoNuevo"
    };

    var elementosPopPup = {
        popupClose: "#popup-close",
        popupDetalleCarouselLanzamiento: "#popupDetalleCarousel_lanzamiento",
        popupDetalleCarouselPackNuevas: "#popupDetalleCarousel_packNuevas",
        contenedorPopupDetalleCarousel: "#contenedor_popup_detalleCarousel"
    };

    var getEstrategia = function ($btnAgregar) {
        var estrategia = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataEstrategia).data("estrategia") || {};
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

    var abrirMensajeEstrategia = function (txt) {
        if (tipoOrigenEstrategia == 1) {
            alert_msg_pedido(txt);
        } else if (tipoOrigenEstrategia == 11 || tipoOrigenEstrategia == 17 || tipoOrigenEstrategia == 172) {
            alert_msg(txt);
        } else if (tipoOrigenEstrategia == 2 || tipoOrigenEstrategia == 21 || tipoOrigenEstrategia == 262) {
            messageInfo(txt);
        } else if (isMobile()) {
            messageInfo(txt);
        } else {
            alert_msg(txt);
        }
    };

    var getOrigenPedidoWeb = function ($btnAgregar) {
        var origenPedidoWeb = $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidoweb") || 0;
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
                //if (estrategiaTmp.CodigoEstrategia === ConstantesModule.ConstantesPalanca.HerramientasVenta) {
                //    $divMsgProductoBloqueado = $(elementosDiv.divHVMensajeBloqueada);
                //    $divMsgProductoBloqueado.find(".cerrar_fichaProducto").data(elementosPopPup.popupClose.substring(1), elementosDiv.divHVMensajeBloqueada.substring(1));
                //}

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
                //
                $(elementosPopPup.contenedorPopupDetalleCarousel.replace("#",".")).hide();
                //
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

    var sendAnalyticAgregarProductoDeshabilitado = function (estrategia) {
        try {
            var name = $.trim(estrategia.DescripcionResumen + " " + estrategia.DescripcionCortada);
            rdAnalyticsModule.AgregarProductoDeshabilitado(
                origenPedidoWebEstrategia,
                estrategia.CampaniaID,
                name,
                popup);
        } catch (e) {
            console.log(e);
        }
    };

    var estrategiaAgregar = function (event, popup, limite, esFicha) {
        popup = popup || false;
        limite = limite || 0;

        _config.esFicha = esFicha || _config.esFicha;
        _config.CampaniaCodigo = $(elementosDiv.hdCampaniaCodigo).val() || _config.CampaniaCodigo;

        var $btnAgregar = $(event.target);
        var estrategia = getEstrategia($btnAgregar);
        var origenPedidoWebEstrategia = getOrigenPedidoWeb($btnAgregar);

        if (estrategiaEstaBloqueada($btnAgregar, estrategia.CampaniaID)) {
            if (isMobile()) {
                EstrategiaVerDetalleMobile(estrategia);
                return true;
            }
            getDivMsgBloqueado($btnAgregar, estrategia).show();
            sendAnalyticAgregarProductoDeshabilitado(estrategia);
            return false;
        }

        if (estrategiaComponenteModule.ValidarSeleccionTono($btnAgregar)) {
            return false;
        }

        var cantidad = (limite > 0) ? limite : ($btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val());

        if (!$.isNumeric(cantidad)) {
            abrirMensajeEstrategia("Ingrese un valor numérico.");
            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");
            CerrarLoad();
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            abrirMensajeEstrategia("La cantidad debe ser mayor a cero.");
            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");
            CerrarLoad();
            return false;
        }
        estrategia.Cantidad = cantidad;

        var agregoAlCarro = false;
        if (!isMobile()) {
            estrategia.FlagNueva = estrategia.FlagNueva == "1" ? estrategia.FlagNueva : "";
            $(elementosDiv.OfertaTipoNuevo).val(estrategia.FlagNueva);
        }

        AbrirLoad();

        var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregar);
        divAgregado = $(itemClone).find(".agregado.product-add");

        var cuvs = "";
        var codigoVariante = estrategia.CodigoVariante;
        if ((ConstantesModule.CodigoVariedad.IndividualVariable == codigoVariante || ConstantesModule.CodigoVariedad.CompuestaVariable == codigoVariante) && popup) {
            var listaCuvs = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataTono.concat(dataProperties.dataTonoSelect));
            if (listaCuvs.length > 0) {
                $.each(listaCuvs,
                    function (i, item) {
                        var cuv = $(item).attr("data-tono-select");
                        if (cuv != "") {
                            cuvs = cuvs + (cuvs == "" ? "" : "|") + cuv;
                            if (ConstantesModule.CodigoVariedad.CompuestaVariable == codigoVariante) {
                                cuvs = cuvs + ";" + $(item).find(elementosDiv.EstrategiaHdMarcaID).val();
                                cuvs = cuvs + ";" + $(item).find(elementosDiv.EstrategiaHdPrecioCatalogo).val();
                            }
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
            FlagNueva: $.trim(estrategia.FlagNueva)
            // ClienteID_:
        };

        EstrategiaAgregarProvider.pedidoAgregarProductoPromise(params).done(function (data) {
            if (!checkTimeout(data)) {
                CerrarLoad();
                return false;
            }

            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");

            if (data.success === false) {
                abrirMensajeEstrategia(data.message);
                CerrarLoad();
                return false;
            }

            if (!isMobile() && !agregoAlCarro) {
                agregarProductoAlCarrito($btnAgregar);
                agregoAlCarro = true;
            }

            AbrirLoad();

            if (divAgregado != null) {
                $(divAgregado).show();
                $("#ContenedorAgregado").show();
            }
            if (isMobile()) {
                ActualizarGanancia(data.DataBarra);
                microefectoPedidoGuardado();
                if (estrategia.CodigoEstrategia == ConstantesModule.ConstantesPalanca.ShowRoom)
                CargarCantidadProductosPedidos();
            } else {
                CargarResumenCampaniaHeader(true);
            }

            var cuv = estrategia.CUV2;


            if (tipoOrigenEstrategia == 1) {
                if (typeof MostrarBarra != constantes.undefined())
                    MostrarBarra(data, "1");

                if (typeof ActualizarGanancia != constantes.undefined())
                    ActualizarGanancia(data.DataBarra);

                if (typeof CargarCarouselEstrategias != constantes.undefined())
                    CargarCarouselEstrategias();

                if (typeof tieneMasVendidos != constantes.undefined()) {
                    if (tieneMasVendidos === 1) {
                        if (typeof CargarCarouselMasVendidos != constantes.undefined())
                            CargarCarouselMasVendidos("desktop");
                    }
                }
            } else if (tipoOrigenEstrategia == 11) {

                $(elementosDiv.hdErrorInsertarProducto).val(data.errorInsertarProducto);


                cierreCarouselEstrategias();
                CargarCarouselEstrategias();
                HideDialog(elementosDiv.divVistaPrevia.substring(1));

                tieneMicroefecto = true;

                CargarDetallePedido();
                MostrarBarra(data);
            } else if (tipoOrigenEstrategia == 2 ||
                tipoOrigenEstrategia == 21 ||
                tipoOrigenEstrategia == 27 ||
                tipoOrigenEstrategia == 262 ||
                tipoOrigenEstrategia == 272) {

                if (tipoOrigenEstrategia == 262) {

                    origenRetorno = $.trim(origenRetorno);
                    if (origenRetorno != "") {
                        setTimeout(function () {
                            window.location = origenRetorno;
                        },
                            3700);

                    }
                } else if (tipoOrigenEstrategia != 272) {
                    CargarCarouselEstrategias();

                    if (tieneMasVendidos === 1) {
                        CargarCarouselMasVendidos("mobile");
                    }
                }
            }

            try {
                if (origenPedidoWebEstrategia !== undefined && origenPedidoWebEstrategia.indexOf("7") !== -1) {
                    rdAnalyticsModule.AgregarProducto(origenPedidoWebEstrategia, estrategia, popup);
                } else {
                    if (typeof TagManagerClickAgregarProductoOfertaParaTI !== constantes.undefined()) {
                        TagManagerClickAgregarProductoOfertaParaTI(estrategia);
                    }
                }
                TrackingJetloreAdd(cantidad, $(elementosDiv.hdCampaniaCodigo).val(), cuv);
            } catch (e) {
                console.log(e);
            }

            CerrarLoad();
            if (popup) {
                CerrarPopup(elementosPopPup.popupDetalleCarouselLanzamiento);
                $(elementosPopPup.popupDetalleCarouselPackNuevas).hide();
            }

            ActualizarLocalStorageAgregado(ConstantesModule.TipoEstrategia.rd, params.CuvTonos || params.CUV, true);
            ActualizarLocalStorageAgregado(ConstantesModule.TipoEstrategia.gn, params.CuvTonos || params.CUV, true);
            ActualizarLocalStorageAgregado(ConstantesModule.TipoEstrategia.hv, params.CuvTonos || params.CUV, true);
            ActualizarLocalStorageAgregado(ConstantesModule.TipoEstrategia.lan, params.CuvTonos || params.CUV, true);

            ProcesarActualizacionMostrarContenedorCupon();

            if (belcorp.estrategia.applyChanges)
                belcorp.estrategia.applyChanges("onProductoAgregado", data);

            return false;
        }).fail(function (data, error) {
            CerrarLoad();
        });

        return false;
    };

    var adicionarCantidad = function (e) {
        e.stopPropagation();

        var $this = $(e.target);
        if($this.data("bloqueada"))
        if ($this.data("bloqueada") !== "") return false;
        var $inputCantidad = $this.parents(dataProperties.dataContenedorCantidad).find(dataProperties.dataInputCantidad);
        var cantidad = parseInt($inputCantidad.val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad < 99 ? (cantidad + 1) : 99;

        $inputCantidad.val(cantidad);

        return false;
    };

    var disminuirCantidad = function (e) {
        e.stopPropagation();

        var $this = $(e.target);
        if($this.data("bloqueada"))
        if ($this.data("bloqueada") !== "") return false;
        var $inputCantidad = $this.parents(dataProperties.dataContenedorCantidad).find(dataProperties.dataInputCantidad);
        var cantidad = parseInt($inputCantidad.val());

        cantidad = isNaN(cantidad) ? 0 : cantidad;
        cantidad = cantidad > 1 ? (cantidad - 1) : 1;

        $inputCantidad.val(cantidad);

        return false;
    };

    return {
        EstrategiaAgregar: estrategiaAgregar,
        EstrategiaObtenerObj: getEstrategia,
        GetOrigenPedidoWeb: getOrigenPedidoWeb,
        AdicionarCantidad: adicionarCantidad,
        DisminuirCantidad: disminuirCantidad
    };
})();