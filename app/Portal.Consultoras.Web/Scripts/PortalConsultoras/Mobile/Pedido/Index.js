
$(document).ready(function () {

    $("#divProductoMantenedor").hide();

    CargarProductosDestacados();

    $("#txtCodigoProducto").on("keyup", function () {
        posicion = -1;
        var codigo = $("#txtCodigoProducto").val();

        $("#divProductoMantenedor").hide();
        $("#divResumenPedido").hide();
        $("#btnAgregarProducto").hide();
        
        if (codigo == "") {
            $("#divListaEstrategias").show();
            $("#divResumenPedido").show();
            $("footer").show();
        } else {
            $("#divListaEstrategias").hide();
            $("footer").hide();
        }

        if (codigo.length == 5) {
            $("#txtCodigoProducto").blur();
            BuscarByCUV(codigo);
        }
    });

    $("#suma, #resta").click(function (event) {
        if (!ValidarPermiso(this)) {
            event.preventDefault();
            return false;
        }
        var cambio = $(this).attr("id") == "suma" ? +1 : -1;
        var numactual = $("#txtCantidad").val();
        numactual = Number(numactual) + cambio;
        numactual = numactual < 1 ? 1 : numactual > 99 ? 99 : numactual;
        $("#txtCantidad").val(numactual);
    });
    
    $("#btnAgregarProducto").click(function () {
        var cantidadProductos = $.trim($("#txtCantidad").val()) || 0;
        if (cantidadProductos > 0) {
            //$("#divMensajeErrorAgregar").html("");

            AgregarProductoListado();
        } //else {
            //$("#divMensajeErrorAgregar").html("Debe ingresar un valor entre 1 y 99");
        //}
    });

    //$("#linkAgregarCliente").click(function(event) {
    //    ShowAgregarCliente();
    //});


    //$("body").on("click", ".btnAgregarEstrategia", function () {

    //    if (ReservadoOEnHorarioRestringido())
    //        return false;

    //    var article = $(this).parents("[data-item]").eq(0);
    //    var valorCuv = $(article).find(".valorCuv").val();

    //    $("#txtCodigoProducto").val(valorCuv);
    //    $("#txtCodigoProducto").keyup();

    //    posicion = $(article).find(".valorPosicion").val();

    //    TagManagerCarruselClickAgregarEstrategia(this);
    //});

    //TagManagerCarruselInicio();

    var CuvEnSession = $("#hdCuvEnSession").val();
    if (CuvEnSession != null) {
        $("#txtCodigoProducto").val(CuvEnSession);
        $("#txtCodigoProducto").keyup();
    }

    //$("#btnResetBusqueda").click(function(e) {
    //    e.preventDefault();
    //    $("#txtCodigoProducto").val("");
    //    $("#txtCodigoProducto").keyup();
    //});
});

/** Buscar Producto **/

function ValidarPermiso(obj) {
    var permiso = $(obj).attr("disabled") || "";
    if (permiso != "") {
        return false;
    }
    return true;
}

function BuscarByCUV(cuv) {
    if (cuv == $('#hdfCUV').val()) {
        $("#divProductoMantenedor").show();
        return false;
    }

    $("#divProductoObservaciones").html('');

    ShowLoading();
    jQuery.ajax({
        type: 'POST',
        url: urlFindByCUV,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ CUV: cuv }),
        async: true,
        cache: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                CloseLoading();
                return false;
            }

            var item = data[0];
            if (item.MarcaID == 0) {
                $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>' + item.CUV + '</div>');
                $("#divProductoInformacion").hide();

                //$("#divProductosNuevasOfertas").hide();
                $('#hdfCUV').val(cuv);
                $("#divProductoMantenedor").show();
                CloseLoading();
                return false;
            }

            $("#hdTipoOfertaSisID").val(item.TipoOfertaSisID);
            $("#hdConfiguracionOfertaID").val(item.ConfiguracionOfertaID);

            jQuery.ajax({
                type: 'POST',
                url: urlObtenerMarcaEstrategia,
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(item),
                success: function (response) {
                    if (!checkTimeout(response)) {
                        CloseLoading();
                        return false;
                    }
                    if (!response.success) {
                        CloseLoading();
                        window.messageInfo(response.message);
                        return false;
                    }

                    item.DescripcionMarca = response.data.DescripcionMarca;
                    item.DescripcionEstrategia = response.data.DescripcionEstrategia;
                    item.LimiteVenta = response.data.LimiteVenta;
                    item.FlagNueva = response.data.FlagNueva;
                    item.TipoEstrategiaID = response.data.TipoEstrategiaID;
                    $("#hdTipoEstrategiaID").val(item.TipoEstrategiaID);

                    //if (item.FlagNueva === "1") {
                    //    ValidarExistenciaDeOtraOfertaNuevaRegistrada(cuv);
                    //    CargarProductosNuevasOfertas(cuv);
                    //} else {
                    //    $("#divProductosNuevasOfertas").hide();
                    //}

                    ObservacionesProducto(item);
                    CloseLoading();
                },
                error: function (response, error) {
                    if (checkTimeout(response)) {
                        CloseLoading();
                        console.error(response);
                    }
                }
            });
            
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();

                if (data.message == "" || data.message === undefined) {
                    location.href = urlSesionExperirada;
                } else {
                    console.error(data);
                }
            }
        }
    });
     
}

function ObservacionesProducto(item) {
    if (item.TipoOfertaSisID == "1707") {
        if (esShowRoom == "1") {
            $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br />Producto disponible sólo desde la sección de Pre-venta Digital.</div>');
        } else {
            $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br />Esta promoción no se encuentra disponible.</div>');
        }

        $("#divProductoInformacion").hide();
        return false;
    } 
    if (!item.TieneStock) {

        $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br />Producto Agotado.</div>');

        $("#divProductoInformacion").hide();
        IngresoFAD(item);
        return false;
    }

    $("#divProductoObservaciones").html("");
    if (item.EsExpoOferta == true) {
        $("#divProductoObservaciones").append('<div class="alert-top-icon text-success" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/> Producto de ExpoOferta.</div>');
    }
    if (item.CUVRevista.length != 0 && item.DesactivaRevistaGana == 0) {
        $("#divProductoObservaciones").append('<div id="divProdRevista" class="alert-top-icon text-success" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/> Producto en Revista SOMOS BELCORP con oferta especial.</div>');
    }

    if (item.MensajeCUV != null) {
        if (item.MensajeCUV != "") {
            window.messageInfo(item.MensajeCUV);
        }
    }
    
    if (item.ObservacionCUV != null) {
        $("#divProductoObservaciones").html('<div class="alert-top-icon text-success" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>' + item.ObservacionCUV + '</div>');
    }

    //var estrategiaEncontrada = ObtenerEstrategiaCoincidente(item.CUV);

    //if (estrategiaEncontrada) {
    //    item.Descripcion = estrategiaEncontrada.DescripcionCUV2.split('|')[0];
    //    item.PrecioCatalogo = estrategiaEncontrada.Precio2;
    //}

    $("#hdfCUV").val(item.CUV);
    $("#hdfDescripcionCategoria").val(item.DescripcionCategoria);
    $("#hdfDescripcionEstrategia").val(item.DescripcionEstrategia);
    $("#hdfDescripcionMarca").val(item.DescripcionMarca);
    $("#hdfIndicadorMontoMinimo").val(item.IndicadorMontoMinimo);
    $("#hdfMarcaID").val(item.MarcaID);
    $("#hdfPrecioUnidad").val(item.PrecioCatalogo);
    $("#hdfDescripcionProd").val(item.Descripcion);
    $("#hdfValorFlagNueva").val(item.FlagNueva);
    $("#hdLimiteVenta").val(item.LimiteVenta);

    $("#txtCodigoProducto").val(item.CUV);
    $("#txtCantidad").val("1");

    //Validar Si es nueva oferta para deshabilitar el input de cantidad
    $("#txtCantidad, #suma, #resta").attr("disabled", item.FlagNueva == "1");

    var paisColombia = "4";
    //$("#spnTextoPrecio").html("Precio Unitario: ");
    if (paisColombia == paisIDSesion) {
        $("#spnPrecio").html(simbolo + " " + SeparadorMiles(parseFloat(item.PrecioCatalogo).toFixed(0)));
    } else {
        $("#spnPrecio").html(simbolo + " " + parseFloat(item.PrecioCatalogo).toFixed(2));
    }

    $("#divNombreProducto").html(item.Descripcion);

    $("#btnAgregarProducto").show();
    $("#btnAgregarProducto").removeAttr("disabled");
    $("#divProductoInformacion").show();
    $("#divProductoMantenedor").show();
    CloseLoading();
}

function IngresoFAD(producto) {
    var item = {
        CUV: producto.CUV,
        PrecioUnidad: producto.PrecioCatalogo
    };

    jQuery.ajax({
        type: 'POST',
        url: urlIngresoFAD,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {

                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });
}

function ObtenerEstrategiaCoincidente(cuv) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);

    var estratgiaEncontrada;

    $.each(listaRecomendados, function (index, value) {
        if (cuv === value.CUV2) {
            estratgiaEncontrada = value;
        }
    });

    return estratgiaEncontrada;
}

/** Insertar Pedido **/

function AgregarProductoListado() {
    ShowLoading();
    if (ReservadoOEnHorarioRestringido()) {
        CloseLoading();
        return false;
    }

    var CUV = $('#hdfCUV').html();
    $("#hdCuvRecomendado").val(CUV);
    $("#btnAgregarProducto").attr("disabled", "disabled");
    $("#btnAgregarProducto").hide();

    var tipoOferta = $("#hdTipoOfertaSisID").val();
    if (tipoOferta == ofertaLiquidacion) {
        $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Este producto solo lo puedes agregar a tu pedido desde la zona de liquidaciones.</div>');
        CloseLoading();
        return false;
    }

    var Cantidad = $("#txtCantidad").val();

    if (tipoOferta == ofertaAccesorizate) {
        $.ajaxSetup({ cache: false });

        var CUV = $("#hdfCUV").val();

        $.getJSON(urlValidarUnidadesPermitidasPedidoProducto, { CUV: CUV }, function (data) {
            if (parseInt(data.Saldo) < parseInt(Cantidad)) {
                if (data.Saldo == data.UnidadesPermitidas) {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (' + data.UnidadesPermitidas + ') del producto.</div>');
                } else if (data.Saldo == "0") {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Las Unidades Permitidas de Venta son solo (' + data.UnidadesPermitidas + '), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.</div>');
                } else {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Las Unidades Permitidas de Venta son solo (' + data.UnidadesPermitidas + '), pero Usted solo puede adicionar (' + data.Saldo + ') más, debido a que ya agregó este producto a su pedido, verifique.</div>');
                }
                
                CloseLoading();
                return false;
            }

            $.ajaxSetup({
                cache: false
            });
            $.getJSON(urlObtenerStockActualProducto, { CUV: CUV }, function (data) {
                if (parseInt(data.Stock) < parseInt(Cantidad)) {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Lamentablemente, la cantidad solicitada para el producto de liquidación sobrepasa el stock actual (' + data.Stock + ').</div>');
                    CloseLoading();
                    return false;
                }

                InsertarProducto();
                return true;
            });
            
            CloseLoading();
            return false;
        });

        return true;
    }

    var param = ({
        MarcaID: 0,
        CUV: CUV,
        PrecioUnidad: 0,
        Descripcion: 0,
        Cantidad: Cantidad,
        IndicadorMontoMinimo: 0,
        TipoOferta: $("#hdTipoEstrategiaID").val()
    });

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>' + datos.message + '</div>');
                CloseLoading();
            } else {
                InsertarProducto();
                return true;
            }
        },
        error: function (data, error) {
            CloseLoading();
            if (checkTimeout(data)) {
                $("#btnAgregarProducto").show();
                $("#btnAgregarProducto").removeAttr("disabled");
                console.error(data);
            }
        }
    });
        
    
}

function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false){
                restringido = false;
                return false;
            }
            
            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    ShowLoading();
                    location.href = urlValidadoPedido;
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    //alert_msg(data.message, fnRedireccionar);
                    messageInfo(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) messageInfo(data.message);
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}
function alert_msg(message, fnClose) {
    messageInfoValidado('<h3 class="text-primary">' + message + '</h3>', fnClose);
}

function InsertarProducto() {
    var esOfertaNueva = $("#hdfValorFlagNueva").val() === "1";
    var urlInsertar = esOfertaNueva ? urlInsertOfertaNueva : urlInsert;
    var model;

    var defered = jQuery.Deferred();

    if (!esOfertaNueva) {
        model = {
            Tipo: 1,
            CUVComplemento: "",
            MarcaIDComplemento: 0,
            PrecioUnidadComplemento: 0,
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoOfertaSisID: $("#hdTipoOfertaSisID").val(),
            ConfiguracionOfertaID: $("#hdConfiguracionOfertaID").val(),
            Registros: "",
            RegistrosDe: "",
            RegistrosTotal: "",
            Pagina: "",
            PaginaDe: "",
            ClienteID_: "",
            DescripcionEstrategia: "",
            DescripcionLarga: "",
            CUV: $("#hdfCUV").val(),
            MarcaID: $("#hdfMarcaID").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            DescripcionProd: $("#divNombreProducto").html(),
            Cantidad: $("#txtCantidad").val(),
            ClienteID: $("#ddlClientes").val(),
            ClienteDescripcion: $("#ddlClientes option:selected").text()
        };

        defered.resolve();
    } else {
        model = {
            MarcaID: $("#hdfMarcaID").val(),
            CUV: $("#hdfCUV").val(),
            PrecioUnidad: $("#hdfPrecioUnidad").val(),
            Descripcion: $("#divNombreProducto").html(),
            Cantidad: $("#txtCantidad").val(),
            IndicadorMontoMinimo: $("#hdfIndicadorMontoMinimo").val(),
            TipoOferta: $("#hdTipoOfertaSisID").val()
        };

        generarTextoNuevaOfertaActual(model, defered);
    }

    defered.done(function () {
        jQuery.ajax({
            type: 'POST',
            url: urlInsertar,
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

                var existeError = $(data).filter("input[id=hdErrorInsertarProducto]").val();
                if (existeError == "1") {
                    $("#divProductoObservaciones").html('<div class="alert-top-icon text-danger" style="margin-top: 0;"><i class="icon-exclamation-circle"></i><br/>Ocurrió un error al ejecutar la operación.</div>');
                    $("#btnAgregarProducto").show();
                    $("#btnAgregarProducto").removeAttr("disabled");
                    CloseLoading();
                    return false;
                }

                CloseLoading();
                $("#divMensajeProductoAgregado").show();

                $("#divProductoObservaciones").html("");
                $("#divProductoMantenedor").hide();
                $("#divListaEstrategias").show();
                $("#divResumenPedido").show();

                var cuv = $("#hdfCUV").val();
                CargarProductosDestacados(cuv);

                PedidoOnSuccess();

                CalcularTotal();

                $("#hdCuvEnSession").val("");

                setTimeout(function () {
                    $("#divMensajeProductoAgregado").fadeOut();
                    $('.toUp').click();
                }, 2000);
                
                
            },
            error: function (data, error) {
                CloseLoading();
                if (checkTimeout(data)) {
                    console.error(data);
                }
            }
        });
    });
}

function generarTextoNuevaOfertaActual(model, defered) {
    jQuery.ajax({
        type: 'POST',
        url: urlRefrescarPedidoOfertaNuevaActual,
        dataType: 'html',
        contentType: 'application/json; charset=utf-8',
        async: true,
        success: function (data) {
            var find = '"';
            var re = new RegExp(find, 'g');
            data = data.replace(re, '');

            model.ElementoOfertaTipoNuevo = data;
            defered.resolve();
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });

    return defered.promise();
}

function CargarProductosDestacados(cuv) {
    jQuery.ajax({
        type: 'POST',
        url: urlCargarListaEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ cuv: cuv }),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                AgregarProductoCarrusel(data);
                //RegistrarOwlCarrousel();
                //TagManagerCarruselProductoVentaCruzada();
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                console.error(data);
            }
        }
    });
}

function PedidoOnSuccess() {
    var ItemCantidad = $("#txtCantidad").val();
    var ItemPrecio = $("#spnPrecio").html();
    var ItemTotal = parseFloat(ItemCantidad * ItemPrecio).toFixed(2);

    TagManagerClickAgregarProducto(ItemTotal, $("#hdfCUV").val(), $("#divNombreProducto").html(), $("#hdfDescripcionCategoria").val(),
        ItemPrecio, ItemCantidad, $("#hdfDescripcionMarca").val(), $("#hdfDescripcionEstrategia").val(), posicion);

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#hdfCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#spnPrecio").val("");
    $("#divNombreProducto").html("");
    $("#txtCantidad").val("");
    $("#txtCodigoProducto").val("");
    $("#btnAgregarProducto").attr("disabled", "disabled");
    $("#divProductoObservaciones").html("");
}

function TagManagerClickAgregarProducto(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, posicion) {
    var cuvSesion = $.trim($("#hdCuvEnSession").val());
    var descripcionTitulo = "";
    if (cuvSesion == "") {
        descripcionTitulo = "Productos destacados – Pedido";
        if (posicion == -1) {
            posicion = 1;
            descripcionTitulo = "Estándar";
        }
    } else { //viene de la pagina productos recomendados
        descripcionTitulo = "Productos destacados";
        var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
        var listaRecomendados = JSON.parse(cadListaRecomendados);

        for (var i = 0; i < listaRecomendados.length; i++) {
            var recomendado = listaRecomendados[i];
            var cuv = recomendado.CUV2;
            if (cuv == cuvSesion) {
                variant = recomendado.DescripcionEstrategia;
                posicion = recomendado.ID;
                break;
            }
        }
    }

    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }

        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': descripcionTitulo },
                    'products': [
                        {
                            'name': DescripcionProd,
                            'price': Precio,
                            'brand': Marca,
                            'id': CUV,
                            'category': Categoria,
                            'variant': variant,
                            'quantity': parseInt(Cantidad),
                            'position': parseInt(posicion)
                        }
                    ]
                }
            }
        });
    }

    posicion = -1;
}

function CalcularTotal() {
    jQuery.ajax({
        type: 'POST',
        url: urlCalcularTotal,
        dataType: 'json',
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                if (!response.success) {
                    if (response.message != "") {
                        window.messageInfo(response.message);
                    }                    
                    return false;
                }

                var data = response.data;
                $("#spnCantidadProductos").html(data.CantidadProductos);
                $(".num-menu-shop").html(data.CantidadProductos);
                $("#spnDescripcionTotal").html(data.DescripcionTotal);

                //if (data.CodigoIso == "DO" || data.CodigoIso == "PR" || data.CodigoIso == "MX" || data.CodigoIso == "CO") {
                //    $("#spnTotalMontoMinimo").html(data.DescripcionTotalMinimo);
                //} else {
                //    $("#spnTotalMontoMinimo").html("");
                //}
            }
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                console.error(response);
            }
        }
    });
}

/** Insertar Estrategia **/

function TagManagerCarruselClickAgregarEstrategia(boton) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);
    
    var article = $(boton).parents("[data-item]").eq(0);
    var valorPosicion = $(article).find(".valorPosicionCarrusel").val();

    var recomendado = listaRecomendados[valorPosicion - 1] || new Object();

    var valorFlagNueva = $(article).find(".valorFlagNueva").val();
    $("#hdfValorFlagNueva").val(valorFlagNueva);

    dataLayer.push({
        'event': 'productClick',
        'ecommerce': {
            'click': {
                'actionField': { 'list': 'Productos destacados – Pedido', 'action': 'click' },
                'products': [
                    {
                        'name': recomendado.DescripcionCUV2,
                        'id': recomendado.CUV2,
                        'category': 'NO DISPONIBLE',
                        'variant': recomendado.DescripcionEstrategia,
                        'position': recomendado.ID
                    }
                ]
            }
        }
    });
}

/** Funciones de Google Tag Manager Carrousel**/

function AgregarProductoCarrusel(data) {
    $('#slick-prev').remove();
    $('#slick-next').remove();
    if($('#divContenidoEstrategias').hasClass('slick-initialized')){
        $('#divContenidoEstrategias').unslick();
    };

    var source = $("#html-estrategia").html();
    var template = Handlebars.compile(source);
    var htmlDiv = template(data);
    $("#divContenidoEstrategias").html(htmlDiv);

    RegistrarOwlCarrousel();
}

function RegistrarOwlCarrousel() {
    var btnPrev = '<span class="previous_ofertas_mobile" id="slick-prev" style="margin-left:-13%;">'
                + '<img src="' + urlCarruselPrev + '")" alt="-" onclick="javascript:TagManagerCarruselPrevia(false);"/>'
            + '</span>';
    var btnNext = '<span class="previous_ofertas_mobile" id="slick-next" style="margin-right:-13%; text-align:right; right:0;">'
                + '<img src="' + urlCarruselNext + '" alt="-" onclick="javascript:TagManagerCarruselSiguiente(false);"/>'
            + '</span>';

    $('#divContenidoEstrategias').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        autoplay: false,
        dots: false,
        prevArrow: btnPrev,
        nextArrow: btnNext,
        infinite: true,
        speed: 300,
        responsive: [
            {
                breakpoint: 960,
                settings: { slidesToShow: 3, slidesToScroll: 1 }
            },
            {
                breakpoint: 680,
                settings: { slidesToShow: 1, slidesToScroll: 1 }
            },
            {
                breakpoint: 380,
                settings: { slidesToShow: 1, slidesToScroll: 1 }
            }
        ]
    });

    $("#divContenidoEstrategias").on('swipe', function (event, slick, direction) {
        if (direction == 'left') {
            TagManagerCarruselSiguiente(true);
        } else if (direction == 'right') {
            TagManagerCarruselPrevia(true);
        }
    });
}

function TagManagerCarruselInicio() {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);
    var cantidadRecomendados = $(".slick-active").length;

    var arrayEstrategia = new Array();
    for (var i = 0; i < cantidadRecomendados; i++) {
        var recomendado = listaRecomendados[i] || new Object();
        var impresionRecomendado = {
            'name': recomendado.DescripcionCUV2,
            'id': recomendado.CUV2,
            'price': recomendado.Precio2.toString(),
            'brand': recomendado.DescripcionMarca,
            'category': 'NO DISPONIBLE',
            'variant': recomendado.DescripcionEstrategia,
            'list': 'Productos destacados – Pedido',
            'position': recomendado.ID
        };

        arrayEstrategia.push(impresionRecomendado);
    }

    if (arrayEstrategia.length > 0) {
        dataLayer.push({
            'event': 'productImpression',
            'ecommerce': {
                'impressions': arrayEstrategia
            }
        });
    }
}

function TagManagerCarruselPrevia(esDrag) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);

    var primeraEstrategia = $(".slick-active").get(0);
    var posicionEstrategia = $(primeraEstrategia).find(".valorPosicionCarrusel").val();

    if (!esDrag) {
        if (posicionEstrategia == 1) {
            posicionEstrategia = listaRecomendados.length;
        } else {
            posicionEstrategia = posicionEstrategia - 1;
        }
    }
    posicionEstrategia = posicionEstrategia < 0 ? 0 : posicionEstrategia >= listaRecomendados.length ? listaRecomendados.length - 1 : posicionEstrategia;
    var recomendado = listaRecomendados[posicionEstrategia] || new Object();
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCUV2,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Productos destacados – Pedido',
        'position': recomendado.ID
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
}

function TagManagerCarruselSiguiente(esDrag) {
    var cadListaRecomendados = $("#hdListaEstrategiasPedido").val() || "[]";
    var listaRecomendados = JSON.parse(cadListaRecomendados);
    var cantidadRecomendadosVisibles = $(".slick-active").length;

    var ultimaEstrategia = $(".slick-active").get(cantidadRecomendadosVisibles - 1);
    var posicionEstrategia = $(ultimaEstrategia).find(".valorPosicionCarrusel").val();

    if (!esDrag) {
        if (posicionEstrategia == listaRecomendados.length) {
            posicionEstrategia = 1;
        } else {
            posicionEstrategia = parseInt(posicionEstrategia) + 1;
        }
    }

    posicionEstrategia = posicionEstrategia < 0 ? 0 : posicionEstrategia >= listaRecomendados.length ? listaRecomendados.length - 1 : posicionEstrategia;
    var recomendado = listaRecomendados[posicionEstrategia] || new Object();
    var arrayEstrategia = new Array();

    var impresionRecomendado = {
        'name': recomendado.DescripcionCUV2,
        'id': recomendado.CUV2,
        'price': recomendado.Precio2.toString(),
        'brand': recomendado.DescripcionMarca,
        'category': 'NO DISPONIBLE',
        'variant': recomendado.DescripcionEstrategia,
        'list': 'Productos destacados – Pedido',
        'position': recomendado.ID
    };

    arrayEstrategia.push(impresionRecomendado);

    dataLayer.push({
        'event': 'productImpression',
        'ecommerce': {
            'impressions': arrayEstrategia
        }
    });
}


function CargarProductoDestacado(objParameter, objInput) {
    ShowLoading();

    if (ReservadoOEnHorarioRestringido())
        return false;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;
    var cantidadIngresada = $(objInput).parent().find("input.rango_cantidad_pedido").val();

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: urlFiltrarEstrategiasPedido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {
            var flagEstrella = (datos.data.FlagEstrella == 0) ? "hidden" : "visible";
            $("#imgTipoOfertaEdit").attr("src", datos.data.ImagenURL);
            $("#imgEstrellaEdit").css({ "visibility": flagEstrella });
            $("#imgZonaEstrategiaEdit").attr("src", datos.data.FotoProducto01);

            if (datos.data.Precio != "0") {
                $(".zona2Edit").html(datos.data.EtiquetaDescripcion + ' ' + datos.data.Simbolo + '' + datos.precio);
            } else {
                $(".zona2Edit").html("");
            }

            if (datos.data.Precio2 != "0") {
                $(".zona3Edit_1").html(datos.data.EtiquetaDescripcion2);
                $(".zona3Edit_2").html('<span>' + datos.data.Simbolo + '' + datos.precio2 + '</span>');
            } else {
                $(".zona3Edit_1").html("");
                $(".zona3Edit_2").html("");
            }

            if (datos.data.TextoLibre != "") {
                $(".zona4Edit").html(datos.data.TextoLibre);
            } else {
                $(".zona4Edit").html("");
            }

            if (datos.data.ColorFondo != "") {
                $("#divVistaPrevia").css({ "background-color": datos.data.ColorFondo });
            } else {
                $("#divVistaPrevia").css({ "background-color": "#FFF" });
            }

            $("#txtCantidadZE").val(cantidadIngresada);
            $("#txtCantidadZE").attr("est-cantidad", datos.data.LimiteVenta);
            $("#txtCantidadZE").attr("est-cuv2", datos.data.CUV2);
            $("#txtCantidadZE").attr("est-marcaID", datos.data.MarcaID);
            $("#txtCantidadZE").attr("est-precio2", datos.data.Precio2);
            $("#txtCantidadZE").attr("est-montominimo", datos.data.IndicadorMontoMinimo);
            $("#txtCantidadZE").attr("est-tipooferta", datos.data.TipoOferta);
            $("#txtCantidadZE").attr("est-descripcionMarca", datos.data.DescripcionMarca);
            $("#txtCantidadZE").attr("est-descripcionEstrategia", datos.data.DescripcionEstrategia);
            $("#txtCantidadZE").attr("est-descripcionCategoria", datos.data.DescripcionCategoria);
            $("#txtCantidadZE").attr("est-posicion", posicionItem);

            $("#ddlTallaColor").empty();
            $(".zona0Edit").html(datos.data.DescripcionMarca);

            /*Validar Programa Ofertas Nuevas*/
            $("#hdnProgramaOfertaNuevo").val(false);
            $("#OfertasResultados li").hide();
            $("#OfertaTipoNuevo").val("");

            if (datos.data.FlagNueva == 1) {
                $(".zona4Edit").hide();
                $(".zonaCantidad").hide();
                $("#hdnProgramaOfertaNuevo").val(true);
                var nroPedidos = false;
                var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

                pedidosData.each(function (indice, valor) {
                    if (valor.value == 1) {
                        nroPedidos = true;
                        var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                            $('#hdnPagina').val(), ";",
                            $('#hdnClienteID2_').val());

                        $("#OfertaTipoNuevo").val(OfertaTipoNuevo)
                        return;
                    }
                });

                if (nroPedidos) {
                    $(".zona4Edit").text(datos.data.TextoLibre);
                    $(".zona4Edit").show();
                }

                var ofertas = datos.data.DescripcionCUV2.split('|');
                $(".zona1Edit").html(ofertas[0]);
                $("#txtCantidadZE").attr("est-descripcion", ofertas[0]);
                $("#OfertasResultados li").remove(); // Limpiar la lista.

                $.each(ofertas, function (i) {
                    if (i != 0 && $.trim(ofertas[i]) != "") {
                        $("#OfertasResultados").append("<li>" + ofertas[i] + "</li>");
                    }
                });

                CloseLoading();
                AgregarProductoDestacado();
            } else {
                $(".zona4Edit").show();
                $(".zonaCantidad").show();
                $(".zona1Edit").html(datos.data.DescripcionCUV2);
                $("#txtCantidadZE").attr("est-descripcion", datos.data.DescripcionCUV2);
                var option = "";
                $(".tallaColor").hide();
                if (datos.data.TallaColor != "") {
                    var arrOption = datos.data.TallaColor.split('</>');
                    if (arrOption.length > 2) {
                        for (var i = 0; i < arrOption.length; i++) {
                            if (arrOption[i] != "") {
                                option = "<option ";
                                var strOption = arrOption[i].split('|');
                                var strCuv = strOption[0];
                                var strDescCuv = strOption[1];
                                var strDescTalla = strOption[2];
                                option += " value='" + strCuv + "' desc-talla='" + strDescCuv + "' >" + strDescTalla + "</option>";
                                $("#ddlTallaColor").append(option);
                            }
                        }

                        $(".tallaColor").show();
                    }
                }
                if (option == "") {
                    AgregarProductoDestacado();
                } else {
                    CloseLoading();
                }
            }

            InfoCommerceGoogleDestacadoProductClick(datos.data.DescripcionCUV2, datos.data.CUV2, datos.data.DescripcionCategoria, datos.data.DescripcionEstrategia, posicionItem);
            //CloseLoading();
        },
        error: function (data, error) {
            alert(datos.data.message);
            CloseLoading();
        }
    });
};
function AgregarProductoDestacado() {
    var cantidad = $("#txtCantidadZE").val();
    var cantidadLimite = $("#txtCantidadZE").attr("est-cantidad");
    var cuv = $("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $("#txtCantidadZE").attr("est-marcaID");
    var precio = $("#txtCantidadZE").attr("est-precio2");
    var descripcion = $("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $("#txtCantidadZE").attr("est-montominimo");
    var tipoOferta = $("#txtCantidadZE").attr("est-tipooferta");
    var categoria = $("#txtCantidadZE").attr("est-descripcionCategoria");
    var variant = $("#txtCantidadZE").attr("est-descripcionEstrategia");
    var marca = $("#txtCantidadZE").attr("est-descripcionMarca");
    var posicion = $("#txtCantidadZE").attr("est-posicion");
    var urlImagen = $("#imgZonaEstrategiaEdit").attr("src");

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            messageInfo("Por favor, seleccione la Talla/Color del producto.");
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        messageInfo("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        messageInfo("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        $("#loadingScreen").dialog('close');
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        messageInfo("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        $("#loadingScreen").dialog('close');
        return false;
    }

    ShowLoading();

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ElementoOfertaTipoNuevo: $("#OfertaTipoNuevo").val()
    });

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                messageInfo(datos.message);
                CloseLoading();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: urlAgregarProducto,
                    dataType: 'html',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (checkTimeout(data)) {
                            ShowLoading();
                            InfoCommerceGoogle(parseFloat(cantidad * precio).toFixed(2), cuv, descripcion, categoria, precio, cantidad, marca, variant, "Productos destacados – Pedido", parseInt(posicion));
                            CargarProductosDestacados(cuv);
                            CargarCantidadProductosPedidos();
                            CargarResumenCampania();
                            CloseLoading();
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CloseLoading();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
            }
        }
    });
};
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
};

