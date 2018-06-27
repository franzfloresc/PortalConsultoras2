/// <reference path="~/Scripts/jquery-1.11.2.js" />
/// <reference path="~/Scripts/General.js" />
/// <reference path="~/Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="~/Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="~/Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="~/Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="~/Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="~/Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="~/Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="~/Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="~/Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="~/Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />

var EstrategiaAgregarModule = function () {
    "use strict";
    var codigoEstrategia = {
        herraMientasVenta: function () {
            return "011";
        },
        lanzamiento: function () {
            return "005";
        }
    };

    var dataProperties = {
        dataItem: function() {
            return "[data-item]";
        },
        dataContenedorCantidad: function() {
            return "[data-cantidad-contenedor]";
        },
        dataInputCantidad: function(){
            return "[data-input='cantidad']";
        },
        dataEstrategia: function(){
            return "[data-estrategia]";
        },
        dataOrigenPedidoWeb: function() {
            return "[data-OrigenPedidoWeb]"
        }
    }

    var getEstrategia = function ($btnAgregar) {
        var estrategia = $btnAgregar.parents(dataProperties.dataItem()).find(dataProperties.dataEstrategia()).data("estrategia") || {};
        return estrategia;
    };

    var estrategiaObtenerObjHtmlLanding = function ($btnAgregar) {
        var itemClone = $btnAgregar.parents(dataProperties.dataItem());
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

        if ($btnAgregar.attr("data-bloqueada") === "") return false;

        if (campaniaId === parseInt(campaniaCodigo)) return false;

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
        var origenPedidoWeb = $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb()).data("origenpedidoweb") || 0;
        return origenPedidoWeb.toString();
    };

    var DivMsgBloqueadoBuilder = function ($btnAgregar, estrategia) {

        var $btnAgregarTmp = $btnAgregar;
        var $divMsgProductoBloqueado = null;
        var dataItemHtml = null;
        var estrategiaTmp = estrategia;
        return {
            getDivMsgProductoBloqueado: function () {
                $divMsgProductoBloqueado = $("#divMensajeBloqueada");
                if (estrategiaTmp.CodigoEstrategia === codigoEstrategia.herraMientasVenta()) {
                    $divMsgProductoBloqueado = $("#divHVMensajeBloqueada");
                    $divMsgProductoBloqueado.find('.cerrar_fichaProducto').data("popup-close", "divHVMensajeBloqueada");
                }

                return this;
            },
            getHtmlProductoBloqueado: function () {
                var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregarTmp);
                dataItemHtml = $divMsgProductoBloqueado.find("[data-item-html]");

                if (estrategiaTmp.CodigoEstrategia !== codigoEstrategia.lanzamiento())
                    dataItemHtml.html(itemClone.html());

                return this;
            },
            formatDivMsgProductoBloqueado: function () {
                dataItemHtml.find('[data-item-tag="body"]').removeAttr("data-estrategia");
                dataItemHtml.find('[data-item-tag="body"]').css("min-height", "auto");
                dataItemHtml.find('[data-item-tag="body"]').css("float", "none");
                dataItemHtml.find('[data-item-tag="body"]').css("margin", "0 auto");
                dataItemHtml.find('[data-item-tag="body"]').css("background-color", "#fff");
                dataItemHtml.find('[data-item-tag="body"]').attr("class", "");
                dataItemHtml.find('[data-item-tag="agregar"]').remove();
                dataItemHtml.find('[data-item-tag="fotofondo"]').remove();
                dataItemHtml.find('[data-item-tag="verdetalle"]').remove();
                dataItemHtml.find('[data-item-accion="verdetalle"]').remove();
                dataItemHtml.find('[data-item-tag="contenido"]').removeAttr("onclick");
                dataItemHtml.find('[data-item-tag="contenido"]').css("position", "initial");
                dataItemHtml.find('[data-item-tag="contenido"]').attr("class", "");
                //
                $(".contenedor_popup_detalleCarousel").hide();
                //
                return this;
            },
            build: function () {
                return $divMsgProductoBloqueado;
            }
        }
    }

    var getDivMsgBloqueado = function ($btnAgregar, estrategia) {
        var divMsgBloqueadoBuilder = new DivMsgBloqueadoBuilder($btnAgregar, estrategia);
        return divMsgBloqueadoBuilder
            .getDivMsgProductoBloqueado()
            .getHtmlProductoBloqueado()
            .formatDivMsgProductoBloqueado()
            .build();
    }

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
    }

    var estrategiaAgregar = function (event, popup, limite) {
        popup = popup || false;
        limite = limite || 0;

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

        var cantidad = (limite > 0) ? limite: ($btnAgregar.parents(dataProperties.dataItem()).find(dataProperties.inputCantidad()).val());

        if (!$.isNumeric(cantidad)) {
            abrirMensajeEstrategia("Ingrese un valor numérico.");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarLoad();
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            abrirMensajeEstrategia("La cantidad debe ser mayor a cero.");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            CerrarLoad();
            return false;
        }
        estrategia.Cantidad = cantidad;

        var agregoAlCarro = false;
        if (!isMobile()) {
            estrategia.FlagNueva = estrategia.FlagNueva == "1" ? estrategia.FlagNueva : "";
            $('#OfertaTipoNuevo').val(estrategia.FlagNueva);
        }

        AbrirLoad();

        var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregar);
        divAgregado = $(itemClone).find(".agregado.product-add");

        var cuvs = "";
        var codigoVariante = estrategia.CodigoVariante;
        if ((codigoVariante == "2001" || codigoVariante == "2003") && popup) {
            var listaCuvs = $btnAgregar.parents(dataProperties.dataItem()).find("[data-tono][data-tono-select]");
            if (listaCuvs.length > 0) {
                $.each(listaCuvs,
                    function (i, item) {
                        var cuv = $(item).attr("data-tono-select");
                        if (cuv != "") {
                            cuvs = cuvs + (cuvs == "" ? "" : "|") + cuv;
                            if (codigoVariante == "2003") {
                                cuvs = cuvs + ";" + $(item).find("#Estrategia_hd_MarcaID").val();
                                cuvs = cuvs + ";" + $(item).find("#Estrategia_hd_PrecioCatalogo").val();
                            }
                        }
                    });
            }
        }

        var tipoEstrategiaImagen = $btnAgregar.parents(dataProperties.dataItem()).attr("data-tipoestrategiaimagenmostrar");

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

            if (data.success === false) {
                abrirMensajeEstrategia(data.message);
                $btnAgregar.parents(dataProperties.dataItem()).find(dataProperties.dataInputCantidad()).val("1");
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
            }
            if (isMobile()) {

                ActualizarGanancia(data.DataBarra);

                microefectoPedidoGuardado();
                $btnAgregar.parents(dataProperties.dataItem()).find(dataProperties.dataInputCantidad()).val("1");
            } else {
                $(".btn_agregar_ficha_producto ").parents(dataProperties.dataItem()).find("input.liquidacion_rango_cantidad_pedido")
                    .val("1");
                $btnAgregar.parents(dataProperties.dataItem()).find("input.rango_cantidad_pedido").val("1");
                $btnAgregar.parents(dataProperties.dataItem()).find(dataProperties.dataInputCantidad()).val("1");

                CargarResumenCampaniaHeader(true);
            }

            var cuv = estrategia.CUV2;


            if (tipoOrigenEstrategia == 1) {
                if (typeof MostrarBarra != "undefined")
                    MostrarBarra(data, '1');

                if (typeof ActualizarGanancia != "undefined")
                    ActualizarGanancia(data.DataBarra);

                if (typeof CargarCarouselEstrategias != "undefined")
                    CargarCarouselEstrategias();

                if (typeof tieneMasVendidos != "undefined") {
                    if (tieneMasVendidos === 1) {
                        if (typeof CargarCarouselMasVendidos != "undefined")
                            CargarCarouselMasVendidos('desktop');
                    }
                }
            } else if (tipoOrigenEstrategia == 11) {

                $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);


                cierreCarouselEstrategias();
                CargarCarouselEstrategias();
                HideDialog("divVistaPrevia");

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
                        CargarCarouselMasVendidos('mobile');
                    }
                }
            }

            try {
                if (origenPedidoWebEstrategia !== undefined && origenPedidoWebEstrategia.indexOf("7") !== -1) {
                    rdAnalyticsModule.AgregarProducto(origenPedidoWebEstrategia, estrategia, popup);
                } else {
                    if (typeof TagManagerClickAgregarProductoOfertaParaTI !== "undefined") {
                        TagManagerClickAgregarProductoOfertaParaTI(estrategia);
                    }
                }
                TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
            } catch (e) {
                console.log(e);
            }

            CerrarLoad();
            if (popup) {
                CerrarPopup('#popupDetalleCarousel_lanzamiento');
                $('#popupDetalleCarousel_packNuevas').hide();
            }

            ActualizarLocalStorageAgregado("rd", params.CuvTonos || params.CUV, true);
            ActualizarLocalStorageAgregado("gn", params.CuvTonos || params.CUV, true);
            ActualizarLocalStorageAgregado("hv", params.CuvTonos || params.CUV, true);
            ActualizarLocalStorageAgregado("lan", params.CuvTonos || params.CUV, true);

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
        var $inputCantidad = $this.parents(dataProperties.dataContenedorCantidad()).find(dataProperties.dataInputCantidad());
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
        var $inputCantidad = $this.parents(dataProperties.dataContenedorCantidad()).find(dataProperties.dataInputCantidad());
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
    }
}();