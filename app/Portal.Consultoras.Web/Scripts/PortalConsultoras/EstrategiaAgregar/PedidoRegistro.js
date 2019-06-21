var modelLiquidacionOfertas;
var labelAgregadoLiquidacion;
var agregoOfertaFinal = agregoOfertaFinal || false;
var DesktopPedidoOfertaFinal = DesktopPedidoOfertaFinal || 0;
var MobilePedidoOfertaFinal = MobilePedidoOfertaFinal || 0;

var PedidoRegistroModule = function () {
    'use strict';

    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
    }

    var _url = {
        urlAgregarUnico: "PedidoRegistro/PedidoAgregarProductoTransaction",
        urlAgregarCuvBanner: "PedidoRegistro/InsertarPedidoCuvBanner",
    }

    var _mensajeAgregarPedido = ConstantesModule.MensajeAgregarPedido;
 

    var _mensajeCantidad = function (cantidad, inputCantidad) {
        cantidad = cantidad || "";

        var esMobile = isMobile();
        var txtMensaje = "";
        //"La cantidad ingresada debe ser mayor que 0, verifique."
        //"La cantidad ingresada debe ser un n�mero mayor que cero, verifique"
        //"La cantidad ingresada debe ser mayor que cero, verifique"

        if (!isInt(cantidad)) {
            txtMensaje = "Ingrese un valor num�rico.";
        }
        else if (parseInt(cantidad, 10) <= 0) {
            txtMensaje = "La cantidad debe ser mayor a cero.";
        }

        if (txtMensaje == "") {
            return false;
        }

        //alert_msg(txtMensaje)
        if (esMobile) {
            messageInfo(txtMensaje);
        }
        else {
            AbrirMensaje(txtMensaje, "LO SENTIMOS");
            CerrarLoad();
        }

        if (typeof inputCantidad != "undefined") {
            inputCantidad.val(1);
        }

        return true;
    };

    var _mensajeRespuestaError = function (data) {
        if (data.success == true) return false;
        if (!IsNullOrEmpty(data.mensajeAviso)) {

            AbrirMensaje(data.mensajeAviso, data.tituloMensaje);
            return false;
        }
        //INI HD-3693
        var msjBloq = validarpopupBloqueada(data.message);
        if (msjBloq != "") {
            CerrarLoad();
            alert_msg_bloqueadas(msjBloq);
            return true;
        }
        //FIN HD-3693
        data.message = data.message || 'Error al realizar proceso, int�ntelo m�s tarde.';
        messageInfoError(data.message);
        CerrarLoad();

        return true;
    };

    /* Ini - Region BannerPedido */
    var _insertarPedidoCuvBanner = function (CUVpedido, CantCUVpedido) {

        var item = {
            CUV: CUVpedido,
            CantCUVpedido: CantCUVpedido
        };

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
                    CerrarLoad();
                    return false;
                }

                if (_mensajeRespuestaError(result)) {
                    return false;
                }

                MostrarBarra(result, '1');

                CargarResumenCampaniaHeader(true);

                TrackingJetloreAdd(CantCUVpedido, $("#hdCampaniaCodigo").val(), CUVpedido);

                _CuvBannerMarcacion(result, CUVpedido, CantCUVpedido);

                CerrarLoad();
            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    CerrarLoad();
                }
            }
        });
    };

    var _CuvBannerMarcacion = function (result, CUVpedido, CantCUVpedido) {

        var categoriacad = "";
        var variantcad = "";

        if (result.data.DescripcionEstrategia == null || result.data.DescripcionEstrategia == "") {
            variantcad = "Est�ndar";
        } else {
            variantcad = result.data.DescripcionEstrategia;
        }
        if (result.data.Categoria == null || result.data.Categoria == "") {
            categoriacad = "Sin Categor�a";
        } else {
            categoriacad = result.data.Categoria;
        }


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
    }

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

        HideDialog("divConfirmarCUVBanner");
    };

    var AgregarCUVBannerPedidoNo = function () {
        HideDialog("divConfirmarCUVBanner");
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

        if (_mensajeCantidad(Cantidad, $('.liquidacion_rango_cantidad_pedido'))) {
            return false;
        }

        $($(xthis).parent().parent().find(".ValidaNumeralOfertaAnterior")).val(Cantidad);
        var Item = {
            MarcaID: MarcaID,
            Cantidad: Cantidad,
            PrecioUnidad: PrecioUnidad,
            CUV: CUV,
            ConfiguracionOfertaID: ConfiguracionOfertaID,
            TipoOfertaSisID: ConstantesModule.ConfiguracionOferta.Liquidacion,
            DescripcionProd: DescripcionProd
        };
        waitingDialog();
        $.ajaxSetup({
            cache: false
        });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(Item),
            async: true,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CerrarLoad();
                    return false;
                }

                if (_mensajeRespuestaError(data)) {
                    return false;
                }

                $(xthis).attr('disabled', true);

                $(xthis).parent().parent().parent().parent().find(".ValidaNumeralOferta").attr('disabled', true);

                $(lblStock).text(parseInt(Stock - Cantidad));
                $(HiddenStock).val(parseInt(Stock - Cantidad));
                $(txtCantidad).val(1);
                InfoCommerceGoogle(parseFloat(Cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, Cantidad, DescripcionMarca, DescripcionEstrategia, 1);

                $(div).css('display', 'block'); // check de agregado
                CargarResumenCampaniaHeader(true);
                TrackingJetloreAdd(Cantidad, $("#hdCampaniaCodigo").val(), CUV);

                HideDialog("divVistaPrevia");

                CerrarLoad();
            },
            error: function (data, error) {
                CerrarLoad();
            }
        });

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

        var imagenProducto = $(this).parent().parent().find('.imagen_producto')[0].src;
        console.log('origenPedidoLiquidaciones', origenPedidoLiquidaciones);

        if (_mensajeCantidad(Cantidad, $('.liquidacion_rango_cantidad_pedido'))) {
            return false;
        }

        $($(this).parent().parent().find(".ValidaNumeralOfertaAnterior")).val(Cantidad);
        var Item = {
            MarcaID: MarcaID,
            Cantidad: Cantidad,
            PrecioUnidad: PrecioUnidad,
            CUV: CUV,
            ConfiguracionOfertaID: ConfiguracionOfertaID,
            OrigenPedidoWeb: origenPedidoLiquidaciones,
            TipoOfertaSisID: ConstantesModule.ConfiguracionOferta.Liquidacion,
            DescripcionProd: DescripcionProd
        };

        AbrirLoad();
        $.ajaxSetup({
            cache: false
        });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
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

                if (_mensajeRespuestaError(data)) {
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

                var mensaje = '';
                if (data.EsReservado === true) {
                    mensaje = _mensajeAgregarPedido.reservado;
                } else {
                    mensaje = _mensajeAgregarPedido.normal;
                }

                AbrirMensaje25seg(mensaje, imagenProducto);

                modelLiquidacionOfertas = undefined;
                labelAgregadoLiquidacion = undefined;
            },
            error: function (data, error) {
                CerrarLoad();
            }
        });

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

        if (_mensajeCantidad(cantidad)) {
            return false;
        }

        ShowLoading();

        $.ajaxSetup({ cache: false });
        var Item = {
            MarcaID: MarcaID,
            Cantidad: cantidad,
            PrecioUnidad: PrecioUnidad,
            CUV: CUV,
            ConfiguracionOfertaID: ConfiguracionOfertaID,
            OrigenPedidoWeb: MobileLiquidacion,
            TipoOfertaSisID: ConstantesModule.ConfiguracionOferta.Liquidacion,
            DescripcionProd: DescripcionProd
        };

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(Item),
            async: true,
            success: function (response) {
                if (!checkTimeout(response)) {
                    CerrarLoad();
                    return false;
                }

                if (_mensajeRespuestaError(response)) {
                    return false;
                }

                CloseLoading();
                $("#divMensajeProductoAgregado").show();
                $(divProductoAgregado).css('display', 'block');

                var stockRestante = parseInt(Stock) - parseInt(cantidad);
                if (stockRestante < 1) {
                    $(article).find(".resta").attr('disabled', 'disabled');
                    $(article).find(".suma").attr('disabled', 'disabled');
                    $(article).find("#txtCantidad").attr('disabled', 'disabled');
                    $(article).find(".btnAgregarOfertaProducto").attr('disabled', 'disabled');

                    $(article).find(".claseStock").text("0");
                    $(article).find("#txtCantidad").val("0");
                } else {
                    $(article).find(".claseStock").text(stockRestante);
                    $(article).find("#txtCantidad").val("1");
                }

                InfoCommerceGoogle(parseFloat(cantidad * PrecioUnidad).toFixed(2), CUV, DescripcionProd, DescripcionCategoria, PrecioUnidad, cantidad, DescripcionMarca, DescripcionEstrategia, posicionEstrategia);

                CargarCantidadProductosPedidos();

                TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), CUV);
                
                var imagenProducto = article.find("[data-imagen-producto]").attr("data-imagen-producto");

                var mensaje = '';
                if (response.EsReservado === true) {
                    mensaje = _mensajeAgregarPedido.reservado;
                } else {
                    mensaje = _mensajeAgregarPedido.normal;
                }

                AbrirMensaje25seg(mensaje, imagenProducto);

                setTimeout(function () {
                    $("#divMensajeProductoAgregado").fadeOut();
                }, 2000);

            },
            error: function (response, error) {
                if (checkTimeout(response)) {
                    CloseLoading();
                }
            }
        });

    };

    var AgregarProductoLiquidacionBienvenida = function (contenedor) {
        var inputCantidad = $(contenedor).find("[data-input='cantidad']");
        var inputCantidadValor = inputCantidad.val();
        if (_mensajeCantidad(inputCantidadValor, inputCantidad)) {
            return false;
        }

        waitingDialog();

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
            TipoOfertaSisID: ConstantesModule.ConfiguracionOferta.Liquidacion,
        };

        var imagenProducto = $(contenedor).find(".producto_img_home img").attr("src");

        $.ajaxSetup({
            cache: false
        });

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(item),
            async: true,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CerrarLoad();
                    return false;
                }

                if (_mensajeRespuestaError(data)) {
                    return false;
                }

                MostrarBarra(data, '1');

                CargarResumenCampaniaHeader(true);
                TrackingJetloreAdd(item.Cantidad, $("#hdCampaniaCodigo").val(), item.CUV);
                TagManagerClickAgregarProductoLiquidacion(item);

                CerrarLoad();
                HidePopupTonosTallas();
                ProcesarActualizacionMostrarContenedorCupon();

                var mensaje = '';
                if (data.EsReservado === true) {
                    mensaje = _mensajeAgregarPedido.reservado;
                } else {
                    mensaje = _mensajeAgregarPedido.normal;
                }

                AbrirMensaje25seg(mensaje, imagenProducto);

            },
            error: function (data, error) {
                if (checkTimeout(data)) {
                    CerrarLoad();
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

    //var _registrarAnalytics = function (model, textoBusqueda) {
    //    try {
    //        AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, "Desplegable", textoBusqueda);
    //    } catch (e) {
    //    }
    //};

    var _limpiarRecomendados = function () {
        var seccionProductosRecomendados = $('.divProductosRecomendados');
        seccionProductosRecomendados.slideUp(200);
        if (isPagina('Pedido')) {
            $("#txtDescripcionProd").val("");
            $("#hdfDescripcionProd").val("");
            $("#txtPrecioR").val("");
            $("#divMensaje").text("");
            $("#txtCUV").focus();
            $("#txtCantidad").val("");

            if (isMobile()) {
                PedidoOnSuccess()
                VisibleEstrategias(true);
                $("#divResumenPedido").show();
                $("footer").show();
                $(".footer-page").css({ "margin-bottom": "0px" });
                $("#divProductoMantenedor").hide();
            }
        }
    }

    var _registroLiquidacion = function (model, cantidad, producto, recomendado) {

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
            url: baseUrl + _url.urlAgregarUnico,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(Item),
            async: true,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CerrarLoad();
                    return false;
                }

                if (_mensajeRespuestaError(data)) {
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

                if (!isMobile()) CargarResumenCampaniaHeader();

                if (isMobile() && isPagina('Pedido')) ActualizarGanancia(data.DataBarra);

                CerrarLoad();

                limpiarRecomendados();

                var modelCarrito = {
                    'DescripcionCompleta': model.DescripcionProd,
                    'CUV': model.CUV,
                    'Precio': model.PrecioUnidad,
                    'DescripcionMarca': model.CUV,
                    'CodigoTipoEstrategia': model.EstrategiaID,
                    'MarcaId': model.MarcaID,
                    'Cantidad': model.Cantidad
                };

                var _textoBusqueda = localStorage.getItem('valorBuscador');
                var _vRecomendaciones = localStorage.getItem('vRecomendaciones');

                if (!(typeof AnalyticsPortalModule === 'undefined') && (_vRecomendaciones === 'undefined' || _vRecomendaciones === 'null' || _vRecomendaciones === null)) {
                    AnalyticsPortalModule.MarcaAnadirCarritoBuscador(modelCarrito, 'Resultados', _textoBusqueda);
                }

                localStorage.removeItem('vRecomendaciones');

            },
            error: function (data, error) {
                CerrarLoad();
            }
        });
    }

    var RegistroProductoBuscador = function (divPadre, valueJSON, origenSeccion) {

        var model = JSON.parse($(divPadre).find(valueJSON).val());
        var divCantidad = $(divPadre).find("[data-input='cantidad']");
        var agregado = $(divPadre).find(".etiqueta_buscador_producto");
        var cantidad = divCantidad.val();
        model.Cantidad = cantidad;

        if (model.TipoPersonalizacion == "LIQ") {
            _registroLiquidacion(model, cantidad, agregado);
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
            var codigoEstrategia = model.CodigoTipoEstrategia;
            var LimiteVenta = model.LimiteVenta;
            var CantidadesAgregadas = model.CantidadesAgregadas;
            var EstrategiaID = model.EstrategiaID;
            var MaterialGanancia = model.MaterialGanancia;

            if (_mensajeCantidad(cantidad, $(".rango_cantidad_pedido"))) {
                return false;
            }

            var urlInsertar = baseUrl + _url.urlAgregarUnico;

            var modelFinal = {
                CUV: cuv,
                Cantidad: cantidad,
                PrecioUnidad: precioUnidad,
                TipoEstrategiaID: parseInt(tipoEstrategiaId),
                CodigoEstrategia: codigoEstrategia,
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
                LimiteVenta: LimiteVenta,
                MaterialGanancia: MaterialGanancia
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

                    if (_mensajeRespuestaError(data)) {
                        if (!IsNullOrEmpty(data.message)) {
                            AbrirMensaje(data.message);
                        }
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

                    if (!isMobile()) CargarResumenCampaniaHeader();

                    if (isMobile() && isPagina('Pedido')) ActualizarGanancia(data.DataBarra);

                    CerrarLoad();

                    _limpiarRecomendados();

                    var imagenProducto = divPadre.find("[data-imagen-producto]").attr("data-imagen-producto");

                    var mensaje = '';
                    if (data.EsReservado === true) {
                        mensaje = _mensajeAgregarPedido.reservado;
                    } else {
                        mensaje = _mensajeAgregarPedido.normal;
                    }

                    AbrirMensaje25seg(mensaje, imagenProducto);

                    var modelCarrito = {
                        'DescripcionCompleta': modelFinal.DescripcionProd,
                        'CUV': modelFinal.CUV,
                        'Precio': modelFinal.PrecioUnidad,
                        'DescripcionMarca': modelFinal.CUV,
                        'CodigoTipoEstrategia': modelFinal.CodigoEstrategia,
                        'MarcaId': modelFinal.MarcaID,
                        'Cantidad': modelFinal.Cantidad,
                        'DescripcionEstrategia': modelFinal.DescripcionEstrategia,
                        'MaterialGanancia': modelFinal.MaterialGanancia
                    };

                    var _textoBusqueda = localStorage.getItem('valorBuscador');
                    var _vRecomendaciones = localStorage.getItem('vRecomendaciones');

                    if (!(typeof AnalyticsPortalModule === 'undefined') && (_vRecomendaciones === 'undefined' || _vRecomendaciones === 'null' || _vRecomendaciones === null)) {
                        AnalyticsPortalModule.MarcaAnadirCarritoBuscador(modelCarrito, origenSeccion, _textoBusqueda);
                    }

                    TrackingJetloreAdd(modelFinal.Cantidad, $("#hdCampaniaCodigo").val(), modelFinal.CUV);

                    agregado.html('<span class="text-uppercase text-bold d-inline-block">Agregado</span>');

                    var totalAgregado = parseInt(cantidad) + parseInt(CantidadesAgregadas);
                    $(divPadre).find(".hdBuscadorCantidadesAgregadas").val(totalAgregado);
                    localStorage.removeItem('vRecomendaciones')
                    return true;
                },
                error: function (data, error) {
                    _ajaxError(data);
                    return false;
                }
            });
        }
    }

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

            if (_mensajeCantidad(model.Cantidad, objCantidad)) {
                CloseLoadingOF();
                return false;
            }

            window.dataAgregarOF = _agregarOfertaFinal(model);
            if (window.dataAgregarOF.success) {
                if (typeof MostrarBarra === 'function') {
                    var prevTotal = mtoLogroBarra;
                    MostrarBarra(window.dataAgregarOF);
                    showPopupNivelSuperado(window.dataAgregarOF.DataBarra, prevTotal);
                }

                AgregarOfertaFinalLog(model.CUV, model.Cantidad, tipoOfertaFinal_Log, gap_Log, 1, 'Producto Agregado');
                ActualizarValoresPopupOfertaFinal(window.dataAgregarOF);
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

        if (add == null) {
            add = {};
            add.success = false;
        }
        agregoOfertaFinal = true;
        return add;
    };

    var _insertarProductoPorUrl = function (model, asyncX, urlMobile) {
        var retorno = new Object();

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
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

                if (_mensajeRespuestaError(data)) {
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
                            'actionField': { 'list': 'Est�ndar' },
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

        divDialog = $.trim(divDialog);

        var retorno = {};
        jQuery.ajax({
            type: "POST",
            url: baseUrl + _url.urlAgregarUnico,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(model),
            async: asyncX == undefined || asyncX == null ? true : asyncX,
            success: function (data) {
                if (!checkTimeout(data)) {
                    if (cerrarSplash) CerrarSplash();
                    return false;
                }

                if (_mensajeRespuestaError(data)) {
                    return false;
                }

                $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

                if (divDialog != "") {
                    HideDialog(divDialog);
                }

                if (data.mensajeCondicional) {
                    AbrirMensajeImagen(data.mensajeCondicional);
                }

                if (model != null && model != undefined)
                    PedidoOnSuccessSugerido(model);

                CargarDetallePedido();
                $("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                microefectoPedidoGuardado();
                if (cerrarSplash) CerrarSplash();
                var prevTotal = mtoLogroBarra || 0;
                MostrarBarra(data);
                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
                showPopupNivelSuperado(data.DataBarra, prevTotal);

                retorno = data;
                return true;
            },
            error: function (data, error) {
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
                EsCuponNuevas: cuvEsCuponNuevas
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
                EsCuponNuevas: cuvEsCuponNuevas
            };
        }

        var flag = $("#hdfEsBusquedaSR").val();
        if (flag == "true") {
            model.EstrategiaID = $("#hdfEstrategiaId").val();
        }

        var EsDuoPerfecto = false;
        var CodigoEstrategia = $("#hdTipoEstrategiaCodigo").val();
        if (CodigoEstrategia === ConstantesModule.TipoEstrategia.PackNuevas) {
            var _EsOfertaIndependiente = $("#hdEsOfertaIndependiente").val();
            var EsOfertaIndependiente = (typeof _EsOfertaIndependiente === 'undefined') ? true : JSON.parse(_EsOfertaIndependiente);
            var _esDuoPerfecto = $("#hdEsDuoPerfecto").val();
            EsDuoPerfecto = ((typeof _esDuoPerfecto === 'undefined') ? false : JSON.parse(_esDuoPerfecto)) && (!EsOfertaIndependiente);
        };

        model.EsDuoPerfecto = EsDuoPerfecto;

        ShowLoading();
        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
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
                    $("#btnAgregarProducto").removeAttr("disabled", "disabled");
                    $("#btnAgregarProducto").show();
                    var errorCliente = data.errorCliente || false;

                    //INI HD-3693
                    //if (!errorCliente) AbrirMensaje(data.message, data.tituloMensaje);
                    if (!errorCliente) {
                        var msjBloq = validarpopupBloqueada(data.message);
                        if (msjBloq != "") alert_msg_bloqueadas(msjBloq);
                        else AbrirMensaje(data.message, data.tituloMensaje);
                    }
                    //FIN HD-3693
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
                    CloseLoading();
                    return false;
                }

                CloseLoading();

                //INI HD-3908
                if (_flagNueva && IsNullOrEmpty(data.mensajeAviso)) {
                    //try {
                    //    var $AgregadoTooltip = $("[data-agregado=\"tooltip\"]");
                    //    $AgregadoTooltip.show();
                    //    setTimeout(function () { $AgregadoTooltip.hide(); }, 4000);
                    //} catch (e) {
                    //    console.error(e);
                    //}

                    var mensaje = '';
                    if (data.EsReservado === true) {
                        mensaje = _mensajeAgregarPedido.reservado;
                    } else {
                        mensaje = _mensajeAgregarPedido.normal;
                    }

                    AbrirMensaje25seg(mensaje);
                }
                //FIN HD-3908
                var prevTotal = mtoLogroBarra || 0;
                MostrarBarra(data);
                var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
                if (existeError == "1") {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Ocurrió un error al ejecutar la operación.</div>');
                    $("#btnAgregarProducto").show();
                    $("#btnAgregarProducto").removeAttr("disabled");
                    CloseLoading();
                    return false;
                }
                showPopupNivelSuperado(data.DataBarra, prevTotal);
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

                if (data.mensajeCondicional) {
                    AbrirMensajeImagen(data.mensajeCondicional);
                }

                $("#hdCuvEnSession").val("");
                ProcesarActualizacionMostrarContenedorCupon();
                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
                dataLayer.push({
                    'event': 'addToCart',
                    'ecommerce': {
                        'add': {
                            'actionField': { 'list': 'Est�ndar' },
                            'products': [{
                                'name': data.data.DescripcionProd,
                                'price': String(data.data.PrecioUnidad),
                                'brand': data.data.DescripcionLarga,
                                'id': data.data.CUV,
                                'category': 'NO DISPONIBLE',
                                'variant': data.data.DescripcionOferta == "" ? "Est�ndar" : data.data.DescripcionOferta,
                                'quantity': Number(model.Cantidad),
                                'position': 1
                            }]
                        }
                    }
                });

                if (belcorp.pedido.applyChanges)
                    belcorp.pedido.applyChanges("onProductoAgregado", data);

                var seccionProductosRecomendados = $('.divProductosRecomendados');
                seccionProductosRecomendados.slideUp(200);

                //INI HD-3908
                if (data.listCuvEliminar != null) {
                    $.each(data.listCuvEliminar, function (i, cuvElem) {

                        ActualizarLocalStoragePalancas(cuvElem, false);
                    })
                }

                //divProductoInformacion                
                var imagenProducto = null;
                var objDataImg = $('#divProductoInformacion').find('div.producto_por_agregar_imagen').find('img');
                if (objDataImg !== 'undefined' && objDataImg !== null) {
                    imagenProducto = $(objDataImg).attr('src');
                }

                var localStorageModule = new LocalStorageModule();
                localStorageModule.ActualizarCheckAgregado($.trim($("#hdfEstrategiaId").val()), $("#hdfCampaniaID").val(), $("#hdfCodigoPalanca").val(), true);
                //FIN HD-3908
            },
            error: function (data, error) {
                CloseLoading();
            }
        });

    };

    var AgregarProductoListadoPasePedido = function () {

        var flagNueva = $.trim($("#hdFlagNueva").val());
        if (flagNueva == "0" || flagNueva == "") {
            $("form#frmInsertPedido").submit();
        } else {
            AgregarProductoZonaEstrategia(flagNueva == "1" ? 2 : flagNueva);
        }

        $("#btnAgregar").removeAttr("disabled");

        return false;
    };

    var AgregarProductoZonaEstrategia = function (tipoEstrategiaImagen) {

        var param2 = {
            CUV: $("#txtCUV").val(),
            Cantidad: $("#txtCantidad").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            TipoEstrategiaID: $("#hdTipoEstrategiaID").val(),
            MarcaID: $("#hdfMarcaID").val(),
            EstrategiaID: $("#hdfEstrategiaId").val(),
            DescripcionProd: $("#txtDescripcionProd").val(),
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoEstrategiaImagen: tipoEstrategiaImagen || 0,
            EsOfertaIndependiente: $("#hdEsOfertaIndependiente").val(),
            EsCuponNuevas: cuvEsCuponNuevas
        };

        var EsDuoPerfecto = false;
        var CodigoEstrategia = $("#hdTipoEstrategiaCodigo").val();
        if (CodigoEstrategia === ConstantesModule.TipoEstrategia.PackNuevas) {
            var EsOfertaIndependiente = (typeof param2.EsOfertaIndependiente === 'undefined') ? true : JSON.parse(param2.EsOfertaIndependiente);
            var _esDuoPerfecto = $("#hdEsDuoPerfecto").val();
            EsDuoPerfecto = ((typeof _esDuoPerfecto === 'undefined') ? false : JSON.parse(_esDuoPerfecto)) && (!EsOfertaIndependiente);
        };

        param2.EsDuoPerfecto = EsDuoPerfecto;

        AbrirSplash();
        jQuery.ajax({
            type: "POST",
            url: baseUrl + _url.urlAgregarUnico,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(param2),
            async: true,
            success: function (data) {
                if (!checkTimeout(data)) {
                    CerrarSplash();
                    return false;
                }

                if (_mensajeRespuestaError(data)) {
                    return false;
                }

                $("#hdErrorInsertarProducto").val(data.errorInsertarProducto);

                //INI HD-3908
                if (_flagNueva && IsNullOrEmpty(data.mensajeAviso)) {
                    //try {
                    //    var $AgregadoTooltip = $("[data-agregado=\"tooltip\"]");
                    //    $AgregadoTooltip.show();
                    //    setTimeout(function () { $AgregadoTooltip.hide(); }, 4000);
                    //} catch (e) {
                    //    console.error(e);
                    //}

                    var mensaje = '';
                    if (data.EsReservado === true) {
                        mensaje = _mensajeAgregarPedido.reservado;
                    } else {
                        mensaje = _mensajeAgregarPedido.normal;
                    }

                    AbrirMensaje25seg(mensaje);
                }
                //FIN HD-3908
                cierreCarouselEstrategias();
                CargarCarouselEstrategias();
                HideDialog("divVistaPrevia");
                PedidoOnSuccess();



                //INI HD-3908
                if (data.listCuvEliminar != null) {
                    $.each(data.listCuvEliminar, function (i, cuvElem) {

                        ActualizarLocalStoragePalancas(cuvElem, false);
                    })
                }
                var localStorageModule = new LocalStorageModule();
                localStorageModule.ActualizarCheckAgregado($.trim($("#hdfEstrategiaId").val()), $("#hdfCampaniaID").val(), $("#hdfCodigoPalanca").val(), true);
                //FIN HD-3908

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
                            'actionField': { 'list': "Est�ndar" },
                            'products': [{
                                'name': data.data.DescripcionProd,
                                'price': String(data.data.PrecioUnidad),
                                'brand': data.data.DescripcionLarga,
                                'id': data.data.CUV,
                                'category': "NO DISPONIBLE",
                                'variant': data.data.DescripcionOferta == "" ? "Est�ndar" : data.data.DescripcionOferta,
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
            form.url = baseUrl + _url.urlAgregarUnico;
            form.data.EstrategiaID = $("#hdfEstrategiaId").val();
            form.data.DescripcionProd = $("#DescripcionProd").val();
        }

        AbrirSplash();
        $.ajax({
            url: form.url,
            type: form.type,
            data: form.data,
            success: function (response) {
                if (!checkTimeout(response)) {
                    CerrarSplash();
                    return false;
                }

                if (response.success == true) {
                    $("#hdErrorInsertarProducto").val(response.errorInsertarProducto);

                    var prevTotal = mtoLogroBarra;
                    MostrarBarra(response);
                    showPopupNivelSuperado(response.DataBarra, prevTotal);
                    if (response.modificoBackOrder) showDialog("divBackOrderModificado");
                    CargarDetallePedido();
                    $("#pCantidadProductosPedido").html(response.cantidadTotalProductos > 0 ? response.cantidadTotalProductos : 0);
                    microefectoPedidoGuardado();
                    if (!IsNullOrEmpty(response.mensajeAviso)) AbrirMensaje(response.mensajeAviso, response.tituloMensaje);
                    if (response.mensajeCondicional) {
                        AbrirMensajeImagen(response.mensajeCondicional);
                    }
                    TrackingJetloreAdd(form.data.Cantidad, $("#hdCampaniaCodigo").val(), form.data.CUV);
                    dataLayer.push({
                        'event': "addToCart",
                        'label': $("#hdMetodoBusqueda").val(),
                        'ecommerce': {
                            'add': {
                                'actionField': { 'list': "Est�ndar" },
                                'products': [{
                                    'name': form.data.DescripcionProd,
                                    'price': form.data.PrecioUnidad,
                                    'brand': response.data.DescripcionLarga,
                                    'id': form.data.CUV,
                                    'category': "NO DISPONIBLE",
                                    'variant': response.data.DescripcionOferta == "" ? "Est�ndar" : response.data.DescripcionOferta,
                                    'quantity': Number(form.data.Cantidad),
                                    'position': 1
                                }]
                            }
                        }
                    });

                    var mensaje = '';
                    if (response.EsReservado === true) {
                        mensaje = _mensajeAgregarPedido.reservado;
                    } else {
                        mensaje = _mensajeAgregarPedido.normal;
                    }

                    AbrirMensaje25seg(mensaje);
                }
                else {
                    var errorCliente = response.errorCliente || false;
                    //INI HD-3693
                    //if (!errorCliente) AbrirMensaje(response.message, response.tituloMensaje);
                    if (!errorCliente) {
                        var msjBloq = validarpopupBloqueada(response.message);
                        if (msjBloq != "") alert_msg_bloqueadas(msjBloq);
                        else AbrirMensaje(response.message, response.tituloMensaje);
                    }
                    //FIN HD-3693
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

            },
            error: function (response, x, xh, xhr) { }
        });
    };

    var AgregarProductoListadoPasePedidoMobile = function () {
        _insertarProductoPasePedidoMobile();
    };
    /* Fin - Region Pase Pedido */

    /* Ini - Region Sugerido */
    var InsertarProductoSugerido = function (model) {
        ShowLoading();

        jQuery.ajax({
            type: 'POST',
            url: baseUrl + _url.urlAgregarUnico,
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

                if (_mensajeRespuestaError(data)) {
                    return false;
                }

                var prevTotal = mtoLogroBarra || 0;
                MostrarBarra(data);
                var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
                if (existeError == "1") {
                    AbrirMensaje("Ocurri� un error al ejecutar la operaci�n.");
                    CloseLoading();
                    return false;
                }

                CloseLoading();
                showPopupNivelSuperado(data.DataBarra, prevTotal);

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

function UpdateTransaction(CantidadActual, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, esCuponNuevas, rowElement, txtLPCant, setId, txtLPTempCant) {
    var CliID = $(rowElement).find(".hdfLPCli").val();
    var CliDes = $(rowElement).find(".txtLPCli").val();
    var Cantidad = $(txtLPCant).val();
    var CantidadAnti = $(txtLPTempCant).val();
    var DesProd = $(rowElement).find(".lblLPDesProd").html();

    var ClienteID_ = $("#ddlClientes").val();
    var PrecioUnidad = $(rowElement).find(".hdfLPPrecioU").val();
    if (CliDes.length == 0) { CliID = 0; }

    var StockNuevo = parseInt(Cantidad) - parseInt(CantidadAnti);

    var Unidad = $(rowElement).find(".hdfLPPrecioU").val();
    //var Total = DecimalToStringFormat(parseFloat(Cantidad * Unidad));
    //$(rowElement).find(".lblLPImpTotal").html(Total);
    //$(rowElement).find(".lblLPImpTotalMinimo").html(Total);
    var _mensajeModificarPedido = ConstantesModule.MensajeModificarPedido;

    var item = {
        CampaniaID: CampaniaID,
        PedidoID: PedidoID,
        PedidoDetalleID: PedidoDetalleID,
        ClienteID: CliID,
        Cantidad: CantidadActual,
        PrecioUnidad: PrecioUnidad,
        Stock: StockNuevo,
        Nombre: CliDes,
        DescripcionProd: DesProd,
        ClienteID_: ClienteID_,
        SetId: setId,
        TipoOfertaSisID: TipoOfertaSisID || 0,
        TipoEstrategiaID: TipoOfertaSisID || 0,
        CUV: CUV,
        EsCuponNuevas: esCuponNuevas
    };

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "PedidoRegistro/UpdateTransaction",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(item),
        async: true,
        success: function (data) {

            CerrarSplash();
            if (!checkTimeout(data))
                return false;

            if (data.success != true) {
                $(txtLPCant).val(CantidadAnti);
                var errorCliente = data.errorCliente || false;
                if (!errorCliente) {
                    messageInfoError(data.message);
                }
                else {
                    messageInfoError(data.message, null, function () {
                        showClienteDetalle(currentClienteEdit, function (cliente) {
                            currentInputClienteID.val(cliente.ClienteID);
                            currentInputClienteNombre.val(cliente.Nombre);
                            currentInputEdit.val(cliente.Nombre);

                            currentInputEdit.blur();
                        }, function () {
                            if (currentInputEdit != null) currentInputEdit.focus();
                        });
                    });
                }
                return false;
            }
            //Se pone aquí el nuevo mensaje para TESLA-07
            var isReservado = data.EsReservado || false;
            var mensaje = '';
            if (isReservado) {
                mensaje = _mensajeModificarPedido.reservado;
            } else {
                mensaje = _mensajeModificarPedido.normal;
            }

            if (esMobile) {
                messageInfo(mensaje);
            }
            else {
                AbrirMensaje25seg(mensaje);
                //CerrarLoad();
            }
            //Comentado según requerimiento TESLA-3

            //var tooltip = $('[data-agregado="tooltip"]');
            //if (typeof tooltip !== 'undefined') {
            //    $('[data-agregado="mensaje1"]').html("¡Listo! ");
            //    $('[data-agregado="mensaje2"]').html(" Modificaste tu pedido");
            //    tooltip.show();
            //    setTimeout(function () { tooltip.hide(); }, 4000);
            //}
            //FIN COMENTARIO TESLA-3

            if ($(rowElement).find(".txtLPCli").val().length == 0) {
                $(rowElement).find(".hdfLPCliDes").val($("#hdfNomConsultora").val());
                $(rowElement).find(".txtLPCli").val($("#hdfNomConsultora").val());
            }

            $(txtLPTempCant).val($(txtLPCant).val());
            $(rowElement).find(".hdfLPCliIni").val($(rowElement).find(".hdfLPCli").val());

            var nomCli = $("#ddlClientes option:selected").text();
            var monto = data.Total_Cliente;

            $(".pMontoCliente").css("display", "none");

            if (data.ClienteID_ != "-1") {
                $(".pMontoCliente").css("display", "block");
                $("#spnNombreCliente").html(nomCli + " :");
                $("#spnTotalCliente").html(variablesPortal.SimboloMoneda + monto);
            }

            $("#hdfTotal").val(data.Total);
            $("#spPedidoWebAcumulado").text(variablesPortal.SimboloMoneda + " " + data.TotalFormato);

            var totalUnidades = parseInt($("#pCantidadProductosPedido").html());
            totalUnidades = totalUnidades - parseInt(CantidadAnti) + parseInt(Cantidad);
            $("#pCantidadProductosPedido").html(totalUnidades);
            
            CargarDetallePedido();
            var prevTotal = mtoLogroBarra;
            MostrarBarra(data);
            showPopupNivelSuperado(data.DataBarra, prevTotal);

            if (data.modificoBackOrder) {
                showDialog("divBackOrderModificado");
            }

            if (data.mensajeCondicional) {
                AbrirMensajeImagen(data.mensajeCondicional);
            }

           

            var diferenciaCantidades = parseInt(Cantidad) - parseInt(CantidadAnti);
            if (diferenciaCantidades > 0)
                TrackingJetloreAdd(diferenciaCantidades.toString(), $("#hdCampaniaCodigo").val(), CUV);
            else if (diferenciaCantidades < 0)
                TrackingJetloreRemove((diferenciaCantidades * -1).toString(), $("#hdCampaniaCodigo").val(), CUV);
        },
        error: function (data, error) {
            CerrarSplash();
        }
    });
}


function UpdateLiquidacion(event, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, FlagValidacion, CantidadModi, setId, esCuponNuevas) {
    var rowElement = $(event.target).closest(".contenido_ingresoPedido");
    var txtLPCant = $(rowElement).find(".txtLPCant");
    var txtLPTempCant = $(rowElement).find(".txtLPTempCant");
    AbrirSplash();
    var CantidadAnti, PROL, CliID, CliDes, Cantidad, DesProd, Flag, StockNuevo, PrecioUnidad;
    if (HorarioRestringido()) {
        CantidadAnti = $(txtLPTempCant).val();
        $(txtLPCant).val(CantidadAnti);
        CerrarSplash();
        return false;
    }

    var cant = $(txtLPCant).val();
    var cantAnti = $(txtLPTempCant).val();

    if (cant == cantAnti) {
        CerrarSplash();
        return false;
    }

    if (cant == "" || cant == "0") {
        AbrirMensaje("Ingrese una cantidad mayor que cero.");
        $(txtLPCant).val(cantAnti);
        CerrarSplash();
        return false;
    }

    if (isNaN(cant)) {
        CerrarSplash();
        return false;
    }

    var val = ValidarUpdate(PedidoDetalleID, FlagValidacion, rowElement);
    if (!val) {
        CerrarSplash();
        return false;
    }

    var CantidadSoli = (cant - cantAnti);
    PrecioUnidad = $(rowElement).find(".hdfLPPrecioU").val();
    var param = ({
        CUV: CUV,
        PrecioUnidad: PrecioUnidad,
        Cantidad: CantidadSoli,
        TipoOferta: TipoOfertaSisID || 0,
        EsCuponNuevas: esCuponNuevas
    });

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
                    var regex = /(\d+)/g;
                    var cantLimitada = parseInt(datos.message.match(regex)[1]);
                    if (parseInt(cantAnti) == cantLimitada) {
                        AbrirMensajeEstrategia(datos.message);
                        CerrarSplash();
                        $(txtLPCant).val(cantAnti);
                    } else {
                        AbrirMensajeEstrategia(datos.message);
                        UpdateTransaction(cantLimitada, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, esCuponNuevas, rowElement, txtLPCant, setId, txtLPTempCant);
                    }
                    return false;
                } else {
                    UpdateTransaction(cant, CampaniaID, PedidoID, PedidoDetalleID, TipoOfertaSisID, CUV, esCuponNuevas, rowElement, txtLPCant, setId, txtLPTempCant);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                HideDialog("divVistaPrevia");
                CerrarSplash();
            }
        }
    });

    /*Fin*/

}
