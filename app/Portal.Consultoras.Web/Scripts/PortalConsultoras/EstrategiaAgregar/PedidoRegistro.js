
var PedidoRegistroModule = function () {
    'use strict';

    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
    }

    var _url = {
        urlAgregarUnico: "PedidoRegistro/PedidoAgregarProductoTransaction",
        urlAgregarCuvBanner: "PedidoRegistro/InsertarPedidoCuvBanner",
    }

    /* Ini - Region BannerPedido */
    var _insertarPedidoCuvBanner = function (CUVpedido, CantCUVpedido) {
        var item = {
            CUV: CUVpedido,
            CantCUVpedido: CantCUVpedido
        };
        var categoriacad = "";
        var variantcad = "";

        waitingDialog();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarCuvBanner,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (result) {
                if (!checkTimeout(result)) {
                    closeWaitingDialog();
                    return false;
                }

                if (result.success != true) {
                    if (result.message == "") result.message = 'Error al realizar proceso, inténtelo más tarde.';
                    messageInfoError(result.message);
                    closeWaitingDialog();
                    return false;
                }

                MostrarBarra(result, '1');

                ActualizarGanancia(result.DataBarra);

                CargarResumenCampaniaHeader(true);

                if (result.data.DescripcionEstrategia == null || result.data.DescripcionEstrategia == "") {
                    variantcad = "Estándar";
                } else {
                    variantcad = result.data.DescripcionEstrategia;
                }
                if (result.data.Categoria == null || result.data.Categoria == "") {
                    categoriacad = "Sin Categoría";
                } else {
                    categoriacad = result.data.Categoria;
                }

                TrackingJetloreAdd(CantCUVpedido, $("#hdCampaniaCodigo").val(), CUVpedido);

                dataLayer.push({
                    'event': 'addToCart',
                    'ecommerce': {
                        'add': {
                            'actionField': { 'list': 'Banner marquesina' },
                            'products': [
                                {
                                    'name': result.data.DescripcionProd,
                                    'price': $.trim(result.data.PrecioUnidad),
                                    'brand': result.data.DescripcionLarga,
                                    'id': CUVpedido,
                                    'category': categoriacad,
                                    'variant': variantcad,
                                    'quantity': parseInt(CantCUVpedido),
                                    'position': 1
                                }
                            ]
                        }
                    }
                });

                closeWaitingDialog();
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                }
            }
        });
    };

    var AgregarCUVBannerPedido = function () {

        var Id = $("#divConfirmarCUVBanner").data().Id;
        var link = $("#divConfirmarCUVBanner").data().link;
        var CUVpedido = $("#divConfirmarCUVBanner").data().cuvPedido;
        var CantCUVpedido = $("#divConfirmarCUVBanner").data().cantidadCUVPedido;
        var Posicion = $("#divConfirmarCUVBanner").data().posicion;
        var Titulo = $("#divConfirmarCUVBanner").data().titulo;

        var objBannerCarrito = $("#" + $(link).attr("id"));
        agregarProductoAlCarrito(objBannerCarrito);
        _insertarPedidoCuvBanner(CUVpedido, CantCUVpedido);
        SetGoogleAnalyticsPromotionClick(Id, Posicion, Titulo);

        $('#divConfirmarCUVBanner').dialog('close');
    };

    var AgregarCUVBannerPedidoNo = function () {
        $('#divConfirmarCUVBanner').dialog('close');
    };

    /* Fin - Region BannerPedido */


    /* Ini - Region Oferta Liquidacion */

    var AgregarProductoOfertaLiquidacion = function (xthis) {

        var contenedor = $(xthis).parents('#divVistaPrevia');

        var txtCantidad = $(contenedor).find("#txtCantidadPopup");
        var Cantidad = $(contenedor).find("#txtCantidadPopup")[0].value;
        var div = "Agregado";
        var ConfiguracionOfertaID = $(contenedor).find(".ConfiguracionOfertaID")[0].value;
        var MarcaID = $(contenedor).find(".MarcaID")[0].value;
        var CUV = $(contenedor).find(".CUV")[0].value;
        var PrecioUnidad = $(contenedor).find(".PrecioOferta")[0].value;
        var Stock = $(contenedor).find(".Stock")[0].value;
        var lblStock = $(contenedor).find(".spStock");
        var HiddenStock = $(contenedor).find("input.Stock");
        var DescripcionProd = $(contenedor).find(".DescripcionProd")[0].value;
        var DescripcionMarca = $(contenedor).find(".DescripcionMarca")[0].value;
        var DescripcionCategoria = $(contenedor).find(".DescripcionCategoria")[0].value;
        var DescripcionEstrategia = $(contenedor).find(".DescripcionEstrategia")[0].value;

        if (Cantidad == "" || Cantidad == 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.", "LO SENTIMOS");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            return false;
        } else {
            $($(xthis).parent().parent().find(".ValidaNumeralOfertaAnterior")).val(Cantidad);
            var Item = {
                MarcaID: MarcaID,
                Cantidad: Cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID,
                TipoEstrategiaID: ConstantesModule.ConfiguracionOferta.Liquidacion,
                DescripcionProd: DescripcionProd
            };
            waitingDialog({});
            $.ajaxSetup({
                cache: false
            });

            jQuery.ajax({
                type: 'POST',
                url: baseUrl + urlAgregarUnico,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(Item),
                async: true,
                success: function (data) {
                    if (!checkTimeout(data)) {
                        closeWaitingDialog();
                        return false;
                    }

                    if (data.success != true) {
                        messageInfoError(data.message);
                        closeWaitingDialog();
                        return false;
                    }

                    $(xthis).attr('disabled', true);

                    $(xthis).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);
                    $(div).css('display', 'block');

                    $(lblStock).text(parseInt(Stock - Cantidad));
                    $(HiddenStock).val(parseInt(Stock - Cantidad));
                    $(txtCantidad).val(1);
                    InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia, 1);
                    CargarResumenCampaniaHeader(true);
                    TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);
                    $('#divVistaPrevia').dialog('close');

                    closeWaitingDialog();
                },
                error: function (data, error) {
                    closeWaitingDialog();
                }
            });
        }
    };

    var RegistrarProductoOferta = function (e) {
        e.preventDefault();

        var origenPedidoLiquidaciones;
        var Cantidad;
        var ConfiguracionOfertaID;
        var MarcaID;
        var CUV;
        var PrecioUnidad;
        var DescripcionProd;
        var DescripcionEstrategia;

        if (modelLiquidacionOfertas) {
            Cantidad = modelLiquidacionOfertas.Cantidad;
            ConfiguracionOfertaID = modelLiquidacionOfertas.ConfiguracionOfertaID;
            MarcaID = modelLiquidacionOfertas.MarcaID;
            CUV = modelLiquidacionOfertas.CUV;
            PrecioUnidad = modelLiquidacionOfertas.PrecioUnidad;
            DescripcionProd = modelLiquidacionOfertas.DescripcionProd;
            DescripcionEstrategia = modelLiquidacionOfertas.DescripcionEstrategia;
            origenPedidoLiquidaciones = modelLiquidacionOfertas.origenPedidoLiquidaciones;

        } else {
            agregarProductoAlCarrito(this);
            var txtCantidad = $(this).parents('.liquidacion_item').find(".txtCantidad");
            var div = "Agregado";
            var Stock = $(this).parents('.liquidacion_item').find(".Stock")[0].value;
            var lblStock = $(this).parent().find(".spStock");
            var HiddenStock = $(this).parent().find("input.Stock");
            var DescripcionMarca = $(this).parents('.liquidacion_item').find(".DescripcionMarca")[0].value;
            var DescripcionCategoria = $(this).parents('.liquidacion_item').find(".DescripcionCategoria")[0].value;
            var posicion = parseInt($(this).parents('.liquidacion_item').attr('data-idposicion'));
            Cantidad = $(this).parents('.liquidacion_item').find(".txtCantidad")[0].value;
            ConfiguracionOfertaID = $(this).parents('.liquidacion_item').find(".ConfiguracionOfertaID")[0].value;
            MarcaID = $(this).parents('.liquidacion_item').find(".MarcaID")[0].value;
            CUV = $(this).parents('.liquidacion_item').find(".CUV")[0].value;
            PrecioUnidad = $(this).parents('.liquidacion_item').find(".PrecioOferta")[0].value;
            DescripcionProd = $(this).parents('.liquidacion_item').find(".DescripcionProd")[0].value;
            DescripcionEstrategia = $(this).parents('.liquidacion_item').find(".DescripcionEstrategia")[0].value;
            origenPedidoLiquidaciones = DesktopLiquidacion;
        }

        console.log('origenPedidoLiquidaciones', origenPedidoLiquidaciones);

        if (Cantidad == "" || Cantidad == 0) {
            AbrirMensaje("La cantidad ingresada debe ser mayor que 0, verifique.", "LO SENTIMOS");
            $('.liquidacion_rango_cantidad_pedido').val(1);
            return false;
        }
        else {
            $($(this).parent().parent().find(".ValidaNumeralOfertaAnterior")).val(Cantidad);
            var Item = {
                MarcaID: MarcaID,
                Cantidad: Cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID,
                OrigenPedidoWeb: origenPedidoLiquidaciones,
                TipoEstrategiaID: ConstantesModule.ConfiguracionOferta.Liquidacion,
                DescripcionProd: DescripcionProd
            };

            AbrirLoad();
            $.ajaxSetup({
                cache: false
            });

            jQuery.ajax({
                type: 'POST',
                url: baseUrl + urlAgregarUnico,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(Item),
                async: true,
                success: function (data) {
                    if (!checkTimeout(data)) {
                        CerrarLoad();
                        modelLiquidacionOfertas = undefined;
                        return false;
                    }

                    if (data.success != true) {
                        messageInfoError(data.message);
                        CerrarLoad();
                        modelLiquidacionOfertas = undefined;
                        return false;
                    }

                    $(this).attr('disabled', true);
                    $(this).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);
                    $(div).css('display', 'block');
                    $(lblStock).text(parseInt(Stock - Cantidad));
                    $(HiddenStock).val(parseInt(Stock - Cantidad));
                    $(txtCantidad).val(1);
                    InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia, posicion);

                    if (!isMobile()) {
                        CargarResumenCampaniaHeader(true);
                        TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);

                        ActualizarGanancia(data.DataBarra);
                    }

                    if (modelLiquidacionOfertas) {
                        labelAgregadoLiquidacion.html('Agregado');

                        if (isPagina('pedido')) {
                            CargarDetallePedido();
                        }
                    }

                    CerrarLoad();

                    modelLiquidacionOfertas = undefined;
                    labelAgregadoLiquidacion = undefined;
                },
                error: function (data, error) {
                    CerrarLoad();
                }
            });

        }
    };

    var AgregarProductoOfertaLiquidacionMobile = function (article) {
        var cantidad = $(article).find("#txtCantidad").val();
        var CUV = $(article).find(".valorCUV").val();
        var MarcaID = $(article).find(".claseMarcaID").val();
        var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
        var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
        var divProductoAgregado = "Agregado";
        var DescripcionProd = $(article).find(".DescripcionProd").val();
        var DescripcionMarca = $(article).find(".DescripcionMarca").val();
        var DescripcionCategoria = $(article).find(".DescripcionCategoria").val();
        var DescripcionEstrategia = $(article).find(".DescripcionEstrategia").val();
        var posicionEstrategia = $(article).find(".posicionEstrategia").val();
        var Stock = $(article).find(".claseStock")[0].innerText;

        if (cantidad == "" || cantidad == 0) {
            messageInfo("La cantidad ingresada debe ser mayor que 0, verifique.");
        } else {
            ShowLoading();

            $.ajaxSetup({ cache: false });
            var Item = {
                MarcaID: MarcaID,
                Cantidad: cantidad,
                PrecioUnidad: PrecioUnidad,
                CUV: CUV,
                ConfiguracionOfertaID: ConfiguracionOfertaID,
                OrigenPedidoWeb: MobileLiquidacion,
                TipoEstrategiaID: ConstantesModule.ConfiguracionOferta.Liquidacion,
                DescripcionProd: DescripcionProd
            };

            jQuery.ajax({
                type: 'POST',
                url: baseUrl + urlAgregarUnico,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(Item),
                async: true,
                success: function (response) {
                    CloseLoading();
                    if (checkTimeout(response)) {
                        if (response.success == true) {
                            $("#divMensajeProductoAgregado").show();
                            $(divProductoAgregado).css('display', 'block');

                            var stockRestante = parseInt(Stock) - parseInt(cantidad);
                            if (stockRestante < 1) {
                                $(article).find(".resta").attr('disabled', 'disabled');
                                $(article).find(".suma").attr('disabled', 'disabled');
                                $(article).find(".txtCantidad").attr('disabled', 'disabled');
                                $(article).find(".btnAgregarOfertaProducto").attr('disabled', 'disabled');

                                $(article).find(".claseStock").text("0");
                                $(article).find(".txtCantidad").val("0");
                            } else {
                                $(article).find(".claseStock").text(stockRestante);
                                $(article).find(".txtCantidad").val("1");
                            }

                            InfoCommerceGoogle(parseFloat(cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, cantidad, DescripcionMarca, DescripcionEstrategia, posicionEstrategia);

                            CargarCantidadProductosPedidos();

                            TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), CUV);

                            setTimeout(function () {
                                $("#divMensajeProductoAgregado").fadeOut();
                            }, 2000);
                        }
                        else messageInfoError(response.message);
                    }
                },
                error: function (response, error) {
                    if (checkTimeout(response)) {
                        CloseLoading();
                    }
                }
            });

        }
    };

    var AgregarProductoLiquidacionBienvenida = function (contenedor) {
        var inputCantidad = $(contenedor).find("[data-input='cantidad']");
        var inputCantidadValor = inputCantidad.val();
        if (!$.isNumeric(inputCantidadValor)) {
            AbrirMensaje("Ingrese un valor numérico.");
            inputCantidad.val(1);
            return false;
        }
        if (parseInt(inputCantidadValor) <= 0) {
            AbrirMensaje("La cantidad debe ser mayor a cero.");
            inputCantidad.val(1);
            return false;
        }

        waitingDialog({});
        var item = {
            Cantidad: inputCantidadValor,
            MarcaID: $(contenedor).find("#MarcaID").val(),
            PrecioUnidad: $(contenedor).find("#PrecioOferta").val(),
            CUV: $(contenedor).find("#CUV").val(),
            ConfiguracionOfertaID: $(contenedor).find("#ConfiguracionOfertaID").val(),
            descripcionProd: $(contenedor).find("#DescripcionProd").val(),
            descripcionCategoria: $(contenedor).find("#DescripcionCategoria").val(),
            descripcionMarca: $(contenedor).find("#DescripcionMarca").val(),
            descripcionEstrategia: $(contenedor).find("#DescripcionEstrategia").val(),
            imagenProducto: $(contenedor).find("#ImagenProducto").val(),
            Posicion: $(contenedor).find("#Posicion").val(),
            OrigenPedidoWeb: DesktopHomeLiquidacion,
            TipoEstrategiaID: ConstantesModule.ConfiguracionOferta.Liquidacion
        };
        $.ajaxSetup({
            cache: false
        });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (!checkTimeout(data)) {
                    closeWaitingDialog();
                    return false;
                }

                if (data.success != true) {
                    messageInfoError(data.message);
                    closeWaitingDialog();
                    return false;
                }
                MostrarBarra(data, '1');

                ActualizarGanancia(data.DataBarra);
                CargarResumenCampaniaHeader(true);
                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);
                TagManagerClickAgregarProductoLiquidacion(item);

                closeWaitingDialog();
                HidePopupTonosTallas();

                ProcesarActualizacionMostrarContenedorCupon();
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    closeWaitingDialog();
                    HidePopupTonosTallas();
                }
            }
        });

    };
    /* Fin - Region Oferta Liquidacion */


    /* Ini - Region Buscador */

    var _ajaxError = function (data) {
        CerrarLoad();
        if (checkTimeout(data)) AbrirMensaje(data.message);
    };

    var _registrarAnalytics = function (model, textoBusqueda) {
        try {
            AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, "Desplegable", textoBusqueda);
        } catch (e) {

        }
    };

    var _registroLiquidacion = function (model, cantidad, producto, textoBusqueda) {

        model.Cantidad = cantidad;
        var Item = {
            MarcaID: model.MarcaId,
            Cantidad: cantidad,
            PrecioUnidad: model.Precio,
            CUV: model.CUV,
            ConfiguracionOfertaID: 3,
            OrigenPedidoWeb: model.OrigenPedidoWeb,
            TipoEstrategiaID: ConstantesModule.ConfiguracionOferta.Liquidacion,
            LimiteVenta: model.UnidadesPermitidas,
            DescripcionProd: model.DescripcionCompleta
        };

        $.ajaxSetup({
            cache: false
        });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
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

                producto.html('<span class="text-uppercase text-bold d-inline-block">Agregado</span>');

                if (isPagina('pedido')) {
                    if (model != null && model != undefined)
                        PedidoOnSuccessSugerido(model);

                    CargarDetallePedido();
                    MostrarBarra(data);
                }

                microefectoPedidoGuardado();

                CargarResumenCampaniaHeader();

                CerrarLoad();
                _registrarAnalytics(model, textoBusqueda);
            },
            error: function (data, error) {
                CerrarLoad();
            }
        });
    }

    var RegistroProductoBuscador = function (divPadre, textoBusqueda) {

        var model = JSON.parse($(divPadre).find(".hdBuscadorJSON").val());
        var cantidad = $(divPadre).find("[data-input='cantidad']").val();
        var agregado = $(divPadre).find(".etiqueta_buscador_producto");
        model.Cantidad = cantidad;

        if (model.TipoPersonalizacion == "LIQ") {
            _registroLiquidacion(model, cantidad, agregado, textoBusqueda);
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

            var urlInsertar = baseUrl + urlAgregarUnico;

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
                            $("#pCantidadProductosPedido")
                                .html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                            MostrarBarra(data);
                        }
                    }
                    microefectoPedidoGuardado();
                    CargarResumenCampaniaHeader();
                    CerrarLoad();
                    TrackingJetloreAdd(modelFinal.Cantidad, $("#hdCampaniaCodigo").val(), modelFinal.CUV);
                    agregado.html('<span class="text-uppercase text-bold d-inline-block">Agregado</span>');
                    var totalAgregado = parseInt(cantidad) + parseInt(CantidadesAgregadas);
                    $(divPadre).find(".hdBuscadorCantidadesAgregadas").val(totalAgregado);
                    _registrarAnalytics(model, textoBusqueda);
                    return true;
                },
                error: function (data, error) {
                    _ajaxError(data);
                    return false;
                }
            });
        }
    };
    /* Fin - Region Buscador */

    /* Ini - Region Oferta Final */

    var _validarAgregarOfertaFinal = function (objDivPadre, objCantidad, fnFinal) {
        OpenLoadingOF();
        //Se usa SetTimeout, para que se muestre el loading y no haya problemas con los ajax no async.
        setTimeout(function () {
            var model = {
                CUV: objDivPadre.find(".hdOfertaFinalCuv").val(),
                Cantidad: objCantidad.val(),
                PrecioUnidad: objDivPadre.find(".hdOfertaFinalPrecioUnidad").val(),
                TipoEstrategiaID: objDivPadre.find(".hdOfertaFinalTipoEstrategiaID").val(),
                OrigenPedidoWeb: tipoOrigen == "1" ? DesktopPedidoOfertaFinal : MobilePedidoOfertaFinal,
                MarcaID: objDivPadre.find(".hdOfertaFinalMarcaID").val(),
                DescripcionProd: objDivPadre.find(".hdOfertaFinalDescripcionProd").val(),
                TipoOfertaSisID: objDivPadre.find(".hdOfertaFinalTipoOfertaSisID").val(),
                IndicadorMontoMinimo: objDivPadre.find(".hdOfertaFinalIndicadorMontoMinimo").val(),
                ConfiguracionOfertaID: objDivPadre.find(".hdOfertaFinalConfiguracionOfertaID").val()
            }

            var message = !isInt(model.Cantidad) ? 'La cantidad ingresada debe ser un número mayor que cero, verifique' :
                model.Cantidad <= 0 ? 'La cantidad ingresada debe ser mayor que cero, verifique' : '';
            if (message != '') {
                alert_msg(message);
                objCantidad.val(1);
                CloseLoadingOF();
                return false;
            }

            var add = _agregarOfertaFinal(model);
            if (add.success) {
                AgregarOfertaFinalLog(model.CUV, model.Cantidad, tipoOfertaFinal_Log, gap_Log, 1, 'Producto Agregado');
                ActualizarValoresPopupOfertaFinal(add, true);
                objDivPadre.find('.agregado').show();
                if ($.isFunction(fnFinal)) fnFinal();
            }
            CloseLoadingOF();
        }, 1);
    };

    var _agregarOfertaFinal = function (model) {
        if (reservaResponse.data.Reserva && !agregoOfertaFinal) {
            if (!DesvalidarPedido()) return false;
        }

        var add;
        if (tipoOrigen == "1") add = AgregarProductoPorUrl('PedidoAgregarProductoTransaction', model, "", false, false);
        else add = _insertarProductoPorUrl(model, false, 'PedidoAgregarProductoTransaction');
        OpenLoadingOF();

        if (add == null) add.success = false;
        agregoOfertaFinal = true;
        return add;
    };

    var _insertarProductoPorUrl = function (model, asyncX, urlMobile) {
        var retorno = new Object();

        jQuery.ajax({
            type: 'POST',
            url: urlMobile,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(model),
            async: asyncX == undefined || asyncX == null ? true : asyncX,
            cache: false,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CloseLoading();
                    return false;
                }

                if (data.success != true) {
                    messageInfoError(data.message);
                    CloseLoading();
                    return false;
                }

                CloseLoading();

                setTimeout(function () { }, 2000);

                ActualizarGanancia(data.DataBarra);

                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
                dataLayer.push({
                    'event': 'addToCart',
                    'ecommerce': {
                        'add': {
                            'actionField': { 'list': 'Estándar' },
                            'products': [{
                                'name': data.data.DescripcionProd,
                                'price': String(data.data.PrecioUnidad),
                                'brand': data.data.DescripcionLarga,
                                'id': data.data.CUV,
                                'category': 'NO DISPONIBLE',
                                'variant': data.data.DescripcionOferta,
                                'quantity': Number(model.Cantidad),
                                'position': 1
                            }]
                        }
                    }
                });

                CargarPedido();

                retorno = data;
            },
            error: function (data, error) {
                CloseLoading();
            }
        });

        return retorno;
    };

    var AgregarOfertaFinalClick = function (xthis) {
        var divPadre = $(xthis).parents("[data-item='ofertaFinal']").eq(0);
        var objCantidad = $(xthis).parent().find('[data-input="cantidad"]');

        if (tipoOrigen == "1")
            DesktopPedidoOfertaFinal = $(xthis).data("origenpedidoweb") == undefined ? DesktopPedidoOfertaFinal : $(xthis).data("origenpedidoweb");
        else
            MobilePedidoOfertaFinal = $(xthis).data("origenpedidoweb") == undefined ? MobilePedidoOfertaFinal : $(xthis).data("origenpedidoweb");

        _validarAgregarOfertaFinal($(divPadre), objCantidad, null);
    };

    var AgregarOfertaFinalDetalleClick = function (xthis) {
        var prodId = $(xthis).attr("data-popup-verdetalle");
        var divPadre = $("#divCarruselOfertaFinal").find("[data-popup-id=" + prodId + "]").eq(0);
        var objCantidad = $("#contenedor_popup_ofertaFinalVerDetalle").find("[data-input='cantidad']");
        var fnFinal = function () { $("#contenedor_popup_ofertaFinalVerDetalle").hide(); };

        if (tipoOrigen == "1")
            DesktopPedidoOfertaFinal = $(xthis).data("origenpedidoweb") == undefined ? DesktopPedidoOfertaFinal : $(xthis).data("origenpedidoweb");
        else
            MobilePedidoOfertaFinal = $(xthis).data("origenpedidoweb") == undefined ? MobilePedidoOfertaFinal : $(xthis).data("origenpedidoweb");

        _validarAgregarOfertaFinal($(divPadre), objCantidad, fnFinal);
    };

    var AgregarProductoPorUrl = function (url, model, divDialog, cerrarSplash, asyncX) {
        AbrirSplash();
        tieneMicroefecto = true;
        divDialog = $.trim(divDialog);

        var retorno = {};
        jQuery.ajax({
            type: "POST",
            url: baseUrl + "Pedido/" + url,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(model),
            async: asyncX == undefined || asyncX == null ? true : asyncX,
            success: function (data) {
                if (!checkTimeout(data)) {
                    if (cerrarSplash) CerrarSplash();
                    return false;
                }

                if (data.success != true) {
                    if (cerrarSplash) CerrarSplash();
                    messageInfoError(data.message);
                    return false;
                }

                $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

                if (divDialog != "") {
                    $("#" + divDialog).dialog("close");
                }

                if (model != null && model != undefined)
                    PedidoOnSuccessSugerido(model);

                CargarDetallePedido();
                $("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                microefectoPedidoGuardado();
                if (cerrarSplash) CerrarSplash();
                MostrarBarra(data);
                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);

                retorno = data;
                return true;
            },
            error: function (data, error) {
                tieneMicroefecto = false;
                AjaxError(data);
                return false;
            }
        });

        return retorno;
    };
    /* Fin - Region Oferta Final */

    /* Ini - Region Pase Pedido */

    var _insertarProductoPasePedidoMobile = function () {
        var esOfertaNueva = $("#hdfValorFlagNueva").val() === "1";
        var model = {};
        if ($("#hdTipoOfertaSisID").val() === "0") {
            $("#hdTipoOfertaSisID").val($("#hdTipoEstrategiaID").val());
        }

        if (!esOfertaNueva) {
            if ($.trim($("#txtClienteNombre").val()) == "") $("#txtClienteId").val("0");

            model = {
                CUV: $("#hdfCUV").val(),
                Cantidad: $("#txtCantidad").val(),
                PrecioUnidad: $("#hdfPrecioUnidad").val(),
                TipoEstrategiaID: $("#hdTipoEstrategiaID").val(),
                OrigenPedidoWeb: origenPedidoWebMobilePedido,
                MarcaID: $("#hdfMarcaID").val(),
                DescripcionProd: $("#divNombreProducto").html(),
                TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
                IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
                ConfiguracionOfertaID: $("#hdConfiguracionOfertaID").val(),
                ClienteID: $("#txtClienteId").val(),
                ClienteDescripcion: $("#txtClienteNombre").val(),
                EnRangoProgramaNuevas: cuvEsProgNuevas
            };

        } else {
            model = {
                CUV: $("#hdfCUV").val(),
                Cantidad: $("#txtCantidad").val(),
                PrecioUnidad: $("#hdfPrecioUnidad").val(),
                TipoEstrategiaID: $("#hdTipoEstrategiaID").val(),
                OrigenPedidoWeb: origenPedidoWebMobilePedido,
                MarcaID: $("#hdfMarcaID").val(),
                DescripcionProd: $("#divNombreProducto").html(),
                TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
                IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
                TipoEstrategiaImagen: 2,
                EnRangoProgramaNuevas: cuvEsProgNuevas
            };
        }

        var flag = $("#hdfEsBusquedaSR").val();
        if (flag == "true") {
            model.EstrategiaID = $("#hdfEstrategiaId").val();
        }

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(model),
            async: true,
            cache: false,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CloseLoading();
                    return false;
                }
                if (data.success != true) {
                    CloseLoading();
                    $("#btnAgregarProducto").removeAttr("disabled", "disabled");
                    $("#btnAgregarProducto").show();
                    var errorCliente = data.errorCliente || false;

                    if (!errorCliente) AbrirMensaje(data.message, data.tituloMensaje);
                    else {
                        $.each(lstClientes, function (ind, cli) {
                            if (cli.ClienteID == $("#txtClienteId").val()) {
                                messageInfoError(data.message, function () {
                                    showClienteDetalle(cli);
                                });
                                return false;
                            }
                        });
                    }
                    return false;
                }

                CloseLoading();
                ActualizarGanancia(data.DataBarra);
                var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
                if (existeError == "1") {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Ocurrió un error al ejecutar la operación.</div>');
                    $("#btnAgregarProducto").show();
                    $("#btnAgregarProducto").removeAttr("disabled");
                    CloseLoading();
                    return false;
                }
                $('#divMensajeCUV').hide();
                $("#divProductoObservaciones").html("");
                $("#divProductoMantenedor").hide();
                $("#btnAgregarProducto").hide();
                VisibleEstrategias(true);
                $("#divResumenPedido").show();
                $("footer").show();
                $(".footer-page").css({ "margin-bottom": "0px" });

                var cuv = $("#hdfCUV").val();
                CargarCarouselEstrategias();

                PedidoOnSuccess();
                if (data.modificoBackOrder) messageInfo('Recuerda que debes volver a validar tu pedido.');
                else if (!IsNullOrEmpty(data.mensajeAviso)) AbrirMensaje(data.mensajeAviso, data.tituloMensaje);

                $("#hdCuvEnSession").val("");
                ProcesarActualizacionMostrarContenedorCupon();
                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
                dataLayer.push({
                    'event': 'addToCart',
                    'ecommerce': {
                        'add': {
                            'actionField': { 'list': 'Estándar' },
                            'products': [{
                                'name': data.data.DescripcionProd,
                                'price': String(data.data.PrecioUnidad),
                                'brand': data.data.DescripcionLarga,
                                'id': data.data.CUV,
                                'category': 'NO DISPONIBLE',
                                'variant': data.data.DescripcionOferta == "" ? "Estándar" : data.data.DescripcionOferta,
                                'quantity': Number(model.Cantidad),
                                'position': 1
                            }]
                        }
                    }
                });

                if (belcorp.pedido.applyChanges)
                    belcorp.pedido.applyChanges("onProductoAgregado", data);
            },
            error: function (data, error) {
                CloseLoading();
            }
        });

    };

    var AgregarProductoListadoPasePedido = function () {
 
        var CUV = $("#txtCUV").val();
        $("#hdCuvRecomendado").val(CUV);
        $("#btnAgregar").attr("disabled", "disabled");

        if ($("#hdTipoOfertaSisID").val() == constConfiguracionOfertaLiquidacion) return false;

        var cantidadSol = $("#txtCantidad").val();
        var param = {
            CUV: CUV,
            PrecioUnidad: 0,
            Cantidad: cantidadSol,
            TipoOferta: 0,
            enRangoProgNuevas: cuvEsProgNuevas
        };

        jQuery.ajax({
            type: "POST",
            url: baseUrl + "Pedido/ValidarStockEstrategia",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(param),
            async: true,
            success: function (datos) {
                if (checkTimeout(datos)) {
                    if (!datos.result) {
                        CerrarSplash();
                        AbrirMensaje(datos.message);
                        return false;
                    }
                    var flagNueva = $.trim($("#hdFlagNueva").val());
                    if (flagNueva == "0" || flagNueva == "") {
                        $("form#frmInsertPedido").submit();
                    } else {
                        AgregarProductoZonaEstrategia(flagNueva == "1" ? 2 : flagNueva);
                    }

                    $("#btnAgregar").removeAttr("disabled");
                    return false;
                }
            },
            error: function (data, error) {
                CerrarSplash();
                if (checkTimeout(data)) {
                    $("#btnAgregar").removeAttr("disabled");
                }
            }
        });

        return false;
    };

    var AgregarProductoZonaEstrategia = function (tipoEstrategiaImagen) {
        var param2 = {
            CUV: $("#txtCUV").val(),
            Cantidad: $("#txtCantidad").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            TipoEstrategiaID: $("#hdTipoEstrategiaID").val(),
            MarcaID: $("#hdfMarcaID").val(),
            DescripcionProd: $("#txtDescripcionProd").val(),
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoEstrategiaImagen: tipoEstrategiaImagen || 0,
            EsOfertaIndependiente: $("#hdEsOfertaIndependiente").val(),
            EnRangoProgramaNuevas: cuvEsProgNuevas
        };

        jQuery.ajax({
            type: "POST",
            url: baseUrl + urlAgregarUnico,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(param2),
            async: true,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CerrarSplash();
                    return false;
                }

                if (data.success != true) {
                    CerrarSplash();
                    if (!IsNullOrEmpty(data.tituloMensaje)) AbrirMensaje(data.message, data.tituloMensaje);
                    else messageInfoError(data.message);
                    return false;
                }

                $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

                cierreCarouselEstrategias();
                CargarCarouselEstrategias();
                HideDialog("divVistaPrevia");
                PedidoOnSuccess();
                if (data.modificoBackOrder) showDialog("divBackOrderModificado");
                CargarDetallePedido();
                MostrarBarra(data);
                if (!IsNullOrEmpty(data.mensajeAviso)) AbrirMensaje(data.mensajeAviso, data.tituloMensaje);
                TrackingJetloreAdd(param2.Cantidad, $("#hdCampaniaCodigo").val(), param2.CUV);
                dataLayer.push({
                    'event': "addToCart",
                    'label': $("#hdMetodoBusqueda").val(),
                    'ecommerce': {
                        'add': {
                            'actionField': { 'list': "Estándar" },
                            'products': [{
                                'name': data.data.DescripcionProd,
                                'price': String(data.data.PrecioUnidad),
                                'brand': data.data.DescripcionLarga,
                                'id': data.data.CUV,
                                'category': "NO DISPONIBLE",
                                'variant': data.data.DescripcionOferta == "" ? "Estándar" : data.data.DescripcionOferta,
                                'quantity': Number(param2.Cantidad),
                                'position': 1
                            }]
                        }
                    }
                });
                CerrarSplash();
            },
            error: function (data, error) {
                CerrarSplash();
            }
        });
    };

    var InsertarProductoPasePedido = function (form) {

        var flag = $("#hdfEsBusquedaSR").val();

        if (flag == "true") {
            form.url = baseUrl + urlAgregarUnico;
            form.data.EstrategiaID = $("#hdfEstrategiaId").val();
        }

        $.ajax({
            url: form.url,
            type: form.type,
            data: form.data,
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success == true) {
                        $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                        tieneMicroefecto = true;
                        MostrarBarra(response);
                        if (response.modificoBackOrder) showDialog("divBackOrderModificado");
                        CargarDetallePedido();
                        $("#pCantidadProductosPedido").html(response.cantidadTotalProductos > 0 ? response.cantidadTotalProductos : 0);
                        microefectoPedidoGuardado();
                        if (!IsNullOrEmpty(response.mensajeAviso)) AbrirMensaje(response.mensajeAviso, response.tituloMensaje);
                        TrackingJetloreAdd(form.data.Cantidad, $("#hdCampaniaCodigo").val(), form.data.CUV);
                        dataLayer.push({
                            'event': "addToCart",
                            'label': $("#hdMetodoBusqueda").val(),
                            'ecommerce': {
                                'add': {
                                    'actionField': { 'list': "Estándar" },
                                    'products': [{
                                        'name': form.data.DescripcionProd,
                                        'price': form.data.PrecioUnidad,
                                        'brand': response.data.DescripcionLarga,
                                        'id': form.data.CUV,
                                        'category': "NO DISPONIBLE",
                                        'variant': response.data.DescripcionOferta == "" ? "Estándar" : response.data.DescripcionOferta,
                                        'quantity': Number(form.data.Cantidad),
                                        'position': 1
                                    }]
                                }
                            }
                        });
                    }
                    else {
                        var errorCliente = response.errorCliente || false;

                        if (!errorCliente) AbrirMensaje(response.message, response.tituloMensaje);
                        else {
                            messageInfoError(response.message, null, function () {
                                showClienteDetalle(currentClienteCreate, function (cliente) {
                                    currentInputClienteID.val(cliente.ClienteID);
                                    currentInputClienteNombre.val(cliente.Nombre);
                                    currentInputEdit.val(cliente.Nombre);

                                    currentInputEdit.blur();
                                });
                            });
                        }
                    }

                    PedidoOnSuccess();
                    CerrarSplash();
                }
            },
            error: function (response, x, xh, xhr) { }
        });
    };

    var AgregarProductoListadoPasePedidoMobile = function () {
        ShowLoading();

        var CUV = $('#hdfCUV').val();
        $("#hdCuvRecomendado").val(CUV);
        $("#btnAgregarProducto").attr("disabled", "disabled");
        $("#btnAgregarProducto").hide();

        var Cantidad = $("#txtCantidad").val();
        var param = ({
            CUV: CUV,
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            Cantidad: Cantidad,
            TipoOferta: $("#hdTipoEstrategiaID").val(),
            enRangoProgNuevas: cuvEsProgNuevas
        });

        jQuery.ajax({
            type: 'POST',
            url: urlValidarStockEstrategia,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(param),
            async: true,
            success: function (datos) {
                if (checkTimeout(datos)) {
                    if (!datos.result) {
                        MostrarMensaje("mensajeCUVCantidadMaxima", datos.message);
                        CloseLoading();
                    } else {
                        _insertarProductoPasePedidoMobile();
                        return true;
                    }
                }
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data)) {
                    $("#btnAgregarProducto").show();
                    $("#btnAgregarProducto").removeAttr("disabled");
                }
            }
        });
    };
    /* Fin - Region Pase Pedido */

    /* Ini - Region Sugerido */
    var InsertarProductoSugerido = function (model) {
        ShowLoading();

        jQuery.ajax({
            type: 'POST',
            url: _url.urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(model),
            async: true,
            cache: false,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CloseLoading();
                    return false;
                }
                if (data.success != true) {
                    messageInfoError(data.message);
                    CloseLoading();
                    return false;
                }

                ActualizarGanancia(data.DataBarra);
                var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
                if (existeError == "1") {
                    AbrirMensaje("Ocurrió un error al ejecutar la operación.");
                    CloseLoading();
                    return false;
                }

                CloseLoading();

                $("#divProductoObservaciones").html("");
                VisibleEstrategias(true);
                $("#divResumenPedido").show();
                $("footer").show();
                $(".footer-page").css({ "margin-bottom": "0px" });
                $('#PopSugerido').hide();

                CargarCarouselEstrategias();
                $("#txtCodigoProducto").val("");
                $("#hdCuvEnSession").val("");

                if (data.modificoBackOrder) messageInfo('Recuerda que debes volver a validar tu pedido.');
                if (belcorp.pedido.applyChanges) belcorp.pedido.applyChanges("onProductoAgregado", data);
            },
            error: function (data, error) {
                CloseLoading();
            }
        });
    };

    /* Ini - Region Sugerido */


    var testDev = function (funt) {
        setTimeout(funt, 1000);
    };

    return {
        /* Ini - Region BannerPedido */
        AgregarCUVBannerPedido: AgregarCUVBannerPedido,
        AgregarCUVBannerPedidoNo: AgregarCUVBannerPedidoNo,
        /* Fin - Region BannerPedido */

        /* Ini - Region Oferta Liquidacion */
        AgregarProductoOfertaLiquidacion: AgregarProductoOfertaLiquidacion,
        RegistrarProductoOferta: RegistrarProductoOferta,
        AgregarProductoOfertaLiquidacionMobile: AgregarProductoOfertaLiquidacionMobile,
        AgregarProductoLiquidacionBienvenida: AgregarProductoLiquidacionBienvenida,
        /* Fin - Region Oferta Liquidacion */

        /* Ini - Region Buscador */
        RegistroProductoBuscador: RegistroProductoBuscador,
        /* Fin - Region Buscador */

        /* Ini - Region Oferta Final */
        AgregarOfertaFinalClick: AgregarOfertaFinalClick,
        AgregarOfertaFinalDetalleClick: AgregarOfertaFinalDetalleClick,
        AgregarProductoPorUrl: AgregarProductoPorUrl,
        /* Fin - Region Oferta Final */

        /* Ini - Region Pase Pedido */
        AgregarProductoListadoPasePedido: AgregarProductoListadoPasePedido,
        AgregarProductoZonaEstrategia: AgregarProductoZonaEstrategia,
        InsertarProductoPasePedido: InsertarProductoPasePedido,
        AgregarProductoListadoPasePedidoMobile: AgregarProductoListadoPasePedidoMobile,
        /* Fin - Region Pase Pedido */

        /* Ini - Region Sugerido */
        InsertarProductoSugerido: InsertarProductoSugerido,
        /* Fin - Region Sugerido */

        // Para probar metodos en consola
        TestDev: testDev
    }
}();

