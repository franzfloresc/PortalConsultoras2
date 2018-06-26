var EstrategiaAgregarModule = function () {
    "use strict";

    var getEstrategia = function($btnAgregar) {
        var estrategia = $btnAgregar.parents("[data-item]").find("[data-estrategia]").data("estrategia") || {};
        return estrategia;
    };

    var estrategiaObtenerObjHtmlLanding = function(objInput) {
        var itemClone = $(objInput).parents("[data-item]");
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

    var estrategiaValidarBloqueada = function($btnAgregar, estrategia) {
        var $divMsgProductoBloqueado = $("#divMensajeBloqueada");

        if ($btnAgregar.attr("data-bloqueada") === "") {
            return false;
        }

        if (estrategia.CampaniaID == campaniaCodigo) {
            return false;
        }

        if (isMobile()) {
            EstrategiaVerDetalleMobile(estrategia);
            return true;
        }

        if (estrategia.CodigoEstrategia == '011' &&
            (isPagina('ofertas') || isPagina('herramientasventa')) &&
            !isMobile()) {
            $divMsgProductoBloqueado = $("#divHVMensajeBloqueada");
            $divMsgProductoBloqueado.find('.cerrar_fichaProducto').attr('data-popup-close', 'divHVMensajeBloqueada');
        }

        if ($divMsgProductoBloqueado.length > 0) {
            var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregar);
            if (itemClone.length > 0) {
                var dataItemHtml = $divMsgProductoBloqueado.find("[data-item-html]");

                if (estrategia.CodigoEstrategia != '005') {
                    dataItemHtml.html(itemClone.html());
                }

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

            }

            $(".contenedor_popup_detalleCarousel").hide();
            $divMsgProductoBloqueado.show();
        }
        return true;
    };

    var abrirMensajeEstrategia = function(txt) {
        if (tipoOrigenEstrategia == 1) {
            alert_msg_pedido(txt)
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
        return $btnAgregar.parents("[data-item]").find("input.OrigenPedidoWeb").val() ||
            $btnAgregar.parents("[data-item]").attr("OrigenPedidoWeb") ||
            $btnAgregar.parents("[data-item]").attr("data-OrigenPedidoWeb") ||
            $btnAgregar.parents("[data-OrigenPedidoWeb]").attr("data-OrigenPedidoWeb")
    }

    var estrategiaAgregar = function(event, popup, limite) {
        popup = popup || false;
        limite = limite || 0;

        var $btnAgregar = $(event.target);
        var estrategia = getEstrategia($btnAgregar);
        var origenPedidoWebEstrategia = getOrigenPedidoWeb($btnAgregar);

        if (estrategiaValidarBloqueada($btnAgregar, estrategia)) {
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
            return false;
        }

        if (estrategiaComponenteModule.ValidarSeleccionTono($btnAgregar)) {
            return false;
        }

        var cantidad = (limite > 0)
            ? limite
            : (
                $(".btn_agregar_ficha_producto ").parents("[data-item]").find("input.liquidacion_rango_cantidad_pedido").val() ||
                    $btnAgregar.parents("[data-item]").find("input.rango_cantidad_pedido").val() ||
                    $btnAgregar.parents("[data-item]").find("[data-input='cantidad']").val()
            );

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
        var CodigoVariante = estrategia.CodigoVariante;
        if ((CodigoVariante == "2001" || CodigoVariante == "2003") && popup) {
            var listaCuvs = $btnAgregar.parents("[data-item]").find("[data-tono][data-tono-select]");
            if (listaCuvs.length > 0) {
                $.each(listaCuvs,
                    function(i, item) {
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

        var tipoEstrategiaImagen = $btnAgregar.parents("[data-item]").attr("data-tipoestrategiaimagenmostrar");

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

        EstrategiaAgregarProvider.pedidoAgregarProductoPromise(params).done(function(data) {
            if (!checkTimeout(data)) {
                CerrarLoad();
                return false;
            }

            if (data.success === false) {
                abrirMensajeEstrategia(data.message);
                $btnAgregar.parents("[data-item]").find("[data-input='cantidad']").val("1");
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
                $btnAgregar.parents("[data-item]").find("[data-input='cantidad']").val("1");
            } else {
                $(".btn_agregar_ficha_producto ").parents("[data-item]").find("input.liquidacion_rango_cantidad_pedido")
                    .val("1");
                $btnAgregar.parents("[data-item]").find("input.rango_cantidad_pedido").val("1");
                $btnAgregar.parents("[data-item]").find("[data-input='cantidad']").val("1");

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
                        setTimeout(function() {
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
        }).fail(function(data, error) {
            CerrarLoad();
        });

        return false;
    };

    return {
        EstrategiaAgregar: estrategiaAgregar,
        EstrategiaObtenerObj: getEstrategia,
    }
}();