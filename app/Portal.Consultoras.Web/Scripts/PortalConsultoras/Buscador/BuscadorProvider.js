var BuscadorProvider = function () {
    'use strict';

    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
    }

    var AjaxError = function (data) {
        CerrarLoad();
        if (checkTimeout(data)) AbrirMensaje(data.message);
    }

    var RegistroLiquidacion = function (model, cantidad, producto) {
        if (ReservadoOEnHorarioRestringido())
            return false;

        var Item = {
            MarcaID: model.MarcaId,
            Cantidad: cantidad,
            PrecioUnidad: model.Precio,
            CUV: model.CUV,
            ConfiguracionOfertaID: 3,
            OrigenPedidoWeb: model.OrigenPedidoWeb
        };

        $.ajaxSetup({
            cache: false
        });

        $.getJSON(baseUrl + "OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto", { CUV: model.CUV, Cantidad: cantidad, PrecioUnidad: model.Precio }, function (data) {
            if (data.message != "") {
                CerrarLoad();
                AbrirMensaje(data.message);
                return false;
            }

            if (parseInt(data.Saldo) < parseInt(cantidad)) {
                var Saldo = data.Saldo;
                var UnidadesPermitidas = data.UnidadesPermitidas;
                $.getJSON(baseUrl + "OfertaLiquidacion/ObtenerStockActualProducto", { CUV: model.CUV }, function (data) {
                    if (Saldo == UnidadesPermitidas)
                        AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.", "LO SENTIMOS");
                    else {
                        if (Saldo == "0")
                            AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.", "LO SENTIMOS");
                        else
                            AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.", "LO SENTIMOS");
                    }
                    CerrarLoad();
                    return false;
                });
            } else {
                $.ajaxSetup({
                    cache: false
                });
                $.getJSON(baseUrl + "OfertaLiquidacion/ObtenerStockActualProducto", { CUV: model.CUV }, function (data) {
                    if (parseInt(data.Stock) < parseInt(cantidad)) {
                        AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.", "LO SENTIMOS");
                        CerrarLoad();
                        return false;
                    }
                    else {

                        jQuery.ajax({
                            type: "POST",
                            url: baseUrl + "OfertaLiquidacion/InsertOfertaWebPortal",
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(Item),
                            async: true,
                            success: function (data) {
                                if (!checkTimeout(data)) {
                                    CerrarLoad();
                                    return false;
                                }

                                if (data.success != true) {
                                    messageInfoError(data.message);
                                    CerrarLoad();
                                    return false;
                                }

                                producto.html("Agregado");

                                if (isPagina("pedido")) {
                                    if (model != null && model != undefined)
                                        PedidoOnSuccessSugerido(model);

                                    CargarDetallePedido();
                                    MostrarBarra(data);
                                }

                                microefectoPedidoGuardado();
                                CargarResumenCampaniaHeader();
                                CerrarLoad();
                            },
                            error: function (data, error) {
                                CerrarLoad();
                            }
                        });

                    }
                });
            }
        });
    }

    var RegistroProductoBuscador = function (divPadre) {
        
        var model = JSON.parse($(divPadre).find(".hdBuscadorJSON").val());
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var agregado = $(divPadre).find(".etiqueta_buscador_producto");

        if (model.TipoPersonalizacion == "LIQ") {
            RegistroLiquidacion(model, cantidad, agregado);
        } else {
            var cuv = model.CUV;
            var tipoOfertaSisID = model.TipoPersonalizacion == "CAT" ? 0 : model.TipoEstrategiaId;
            var configuracionOfertaID = tipoOfertaSisID;
            var indicadorMontoMinimo = 1;
            var marcaID = model.MarcaId;
            var precioUnidad = model.Precio;
            var descripcionProd = model.DescripcionCompleta;
            var descripcionEstrategia = model.DescripcionEstrategia;
            var OrigenPedidoWeb = model.OrigenPedidoWeb;
            var posicion = model.posicion;
            var tipoEstrategiaId = tipoOfertaSisID;
            var LimiteVenta = model.LimiteVenta;
            var CantidadesAgregadas = model.CantidadesAgregadas;
            var EstrategiaID = model.EstrategiaID;

            if (!isInt(cantidad)) {
                AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
                $(".rango_cantidad_pedido").val(1);
                CerrarLoad();
                return false;
            }

            if (cantidad <= 0) {
                AbrirMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
                $(".rango_cantidad_pedido").val(1);
                CerrarLoad();
                return false;
            }

            var urlInsertar;
            if (model.TipoPersonalizacion == "CAT") {
                urlInsertar = baseUrl + "Pedido/PedidoInsertarBuscador";
            } else {
                urlInsertar = baseUrl + "Pedido/PedidoAgregarProducto";
            }

            var modelFinal = {
                CUV: cuv,
                Cantidad: cantidad,
                PrecioUnidad: precioUnidad,
                TipoEstrategiaID: parseInt(tipoEstrategiaId),
                OrigenPedidoWeb: OrigenPedidoWeb,
                MarcaID: marcaID,
                DescripcionProd: descripcionProd,
                TipoOfertaSisID: tipoOfertaSisID,
                IndicadorMontoMinimo: indicadorMontoMinimo,
                ConfiguracionOfertaID: configuracionOfertaID,
                EsSugerido: false,
                DescripcionMarca: "",
                DescripcionEstrategia: descripcionEstrategia,
                Posicion: posicion,
                EstrategiaID: EstrategiaID,
                LimiteVenta: LimiteVenta
            };

            jQuery.ajax({
                type: "POST",
                url: urlInsertar,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(modelFinal),
                async: true,
                success: function (data) {
                    if (!checkTimeout(data)) {
                        CerrarLoad();
                        return false;
                    }
                    if (data.success != true) {
                        CerrarLoad();
                        messageInfoError(data.message);
                        return false;
                    }
                    $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);
                    if (!_config.isMobile) {
                        if (isPagina("pedido")) {
                            if (modelFinal != null && modelFinal != undefined)
                                PedidoOnSuccessSugerido(modelFinal);

                            CargarDetallePedido();
                            $("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                            MostrarBarra(data);
                        }
                        microefectoPedidoGuardado();
                        CargarResumenCampaniaHeader();
                    }
                    CerrarLoad();
                    TrackingJetloreAdd(modelFinal.Cantidad, $("#hdCampaniaCodigo").val(), modelFinal.CUV);
                    agregado.html('<span class="text-uppercase text-bold d-inline-block">Agregado</span>');
                    var totalAgregado = parseInt(cantidad) + parseInt(CantidadesAgregadas);
                    $(divPadre).find(".hdBuscadorCantidadesAgregadas").val(totalAgregado);
                    return true;
                },
                error: function (data, error) {
                    _funciones.AjaxError(data);
                    return false;
                }
            });
        }
    }

    return {
        RegistroProductoBuscador: RegistroProductoBuscador
    }
}();