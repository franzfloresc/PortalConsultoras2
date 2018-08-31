var BuscadorPortalConsultorasMobile;

$(document).ready(function () {
    'use strict';

    var BuscadorSBMobile;

    BuscadorSBMobile = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('keyup', '#CampoBuscadorProductosMobile', me.Eventos.AccionesCampoBusquedaMobileAlDigitar);
                $(document).on('click', '.opcion_limpiar_campo_busqueda_productos', me.Eventos.LimpiarCampoBusqueda);
                $(document).on('click', '.agregarProductoBuscador', me.Eventos.AgregarProducto);
                $(document).on('click', '.redireccionarFicha', me.Eventos.RedireccionarAFichaDeFotoYDescripcion);
            },
            CampoDeBusquedaMobileConCaracteres: function () {
                $('.vistaResultadosBusquedaMobile').delay(50);
                $('.vistaResultadosBusquedaMobile').fadeIn(100);
                $('.enlace_busqueda_filtros').fadeOut(100);
                $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);
            },
            CampoDeBusquedaMobileSinCaracteres: function (element) {
                $('.vistaResultadosBusquedaMobile').fadeOut(100);
                $(element).fadeOut(100);
                $('.enlace_busqueda_filtros').delay(50);
                $('.enlace_busqueda_filtros').fadeIn(100);
                $('#ResultadoBuscadorMobile').html('');
            }
        },
            me.Eventos = {
                AccionesCampoBusquedaMobileAlDigitar: function () {
                    var cantidadCaracteresParaMostrarSugerenciasBusquedaMobile = $(this).val().length;
                    if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= CaracteresBuscador) {
                        me.Funciones.CampoDeBusquedaMobileConCaracteres();
                        $('.spinner').fadeIn(150);


                        var service = $.ajax({
                            type: "POST",
                            url: baseUrl + "Mobile/Buscador/BusquedaProductos",
                            data: JSON.stringify({ busqueda: $(this).val(), totalResultados: TotalResultadosBuscador }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false
                        });



                        var successBusqueda = function (r) {

                            $.each(r, function (index, item) {
                                item.posicion = index + 1;
                                if (item.Descripcion.length > TotalCaracteresEnListaBuscador) {
                                    item.Descripcion = item.Descripcion.substring(0, TotalCaracteresEnListaBuscador) + '...';
                                }
                            });

                            var lista = r;

                            if (lista.length <= 0) {
                                $('#ResultadoBuscadorMobile').fadeOut(150);
                                me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                            } else {
                                $('#ResultadoBuscadorMobile').html('');
                                SetHandlebars('#js-ResultadoBuscadorMobile', lista, '#ResultadoBuscadorMobile');
                            }

                            setTimeout(function () {
                                $('.spinner').delay(50);
                                $('.spinner').fadeOut(150);
                                $('#ResultadoBuscadorMobile').fadeIn(150);
                            }, 400);
                        }
                        service.then(successBusqueda, function (e) {
                            console.log(e);
                        });
                        //aquí va el metodo que llama el api
                    } else {
                        $('#ResultadoBuscadorMobile').fadeOut(150);
                        me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                    }
                },
                LimpiarCampoBusqueda: function (e) {
                    e.preventDefault();
                    me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                    $('#CampoBuscadorProductosMobile').val('');
                    $('#CampoBuscadorProductosMobile').focus();
                    $('#divResultadoBuscadorMobile').html('');
                },
                AgregarProducto: function (e) {
                    e.preventDefault();
                    AbrirLoad();

                    var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
                    var cuv = $(divPadre).find('.hdBuscadorCUV').val();
                    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
                    var tipoOfertaSisID = $(divPadre).find(".hdBuscadorCodigoPalanca").val();
                    var configuracionOfertaID = tipoOfertaSisID;
                    var indicadorMontoMinimo = 1;
                    var marcaID = $(divPadre).find(".hdBuscadorMarcaId").val();
                    var precioUnidad = $(divPadre).find(".hdBuscadorPrecio").val();
                    var descripcionProd = $(divPadre).find(".hdBuscadorDescripcion").val();
                    var descripcionEstrategia = $(divPadre).find(".hdBuscadorDescripcionEstrategia").val();
                    var OrigenPedidoWeb = OrigenPedidoMobileBuscador;
                    var posicion = $(divPadre).find(".hdBuscadorPosicion").val();
                    var tipoEstrategiaId = tipoOfertaSisID;//$(divPadre).find(".hdBuscadorCodigoPalanca").val();
                    var agregado = $(divPadre).find(".etiqueta_buscador_producto");
                    var LimiteVenta = $(divPadre).find('.hdBuscadorLimiteVenta').val();
                    var CantidadesAgregadas = $(divPadre).find('.hdBuscadorCantidadesAgregadas').val();


                    if (!isInt(cantidad)) {
                        AbrirMensaje("La cantidad ingresada debe ser un número mayor que cero, verifique");
                        $(".rango_cantidad_pedido").val(1);
                        CerrarLoad();
                        return false;
                    }

                    if (HorarioRestringido()) {
                        CerrarLoad();
                        return false;
                    }

                    if (cantidad <= 0) {
                        AbrirMensaje("La cantidad ingresada debe ser mayor que cero, verifique");
                        $(".rango_cantidad_pedido").val(1);
                        CerrarLoad();
                        return false;
                    }

                    var model = {
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
                        DescripcionMarca: '',
                        DescripcionEstrategia: descripcionEstrategia,
                        Posicion: posicion
                    }

                    if (LimiteVenta == 0) {
                        jQuery.ajax({
                            type: 'POST',
                            url: baseUrl + 'Pedido/PedidoInsertar',
                            dataType: 'json',
                            contentType: 'application/json; charset=utf-8',
                            data: JSON.stringify(model),
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


                                //CargarDetallePedido();
                                //$("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                                //microefectoPedidoGuardado();
                                CerrarLoad();
                                TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
                                agregado.html("Agregado");
                                var totalAgregado = parseInt(cantidad) + parseInt(CantidadesAgregadas);
                                $(divPadre).find('.hdBuscadorCantidadesAgregadas').val(totalAgregado);
                                return true;
                            },
                            error: function (data, error) {
                                AjaxError(data);
                                return false;
                            }
                        });
                    }
                    else {
                        var saldo = parseInt(CantidadesAgregadas) + parseInt(cantidad);
                        if (saldo <= parseInt(LimiteVenta)) {
                            jQuery.ajax({
                                type: 'POST',
                                url: baseUrl + 'Pedido/PedidoInsertar',
                                dataType: 'json',
                                contentType: 'application/json; charset=utf-8',
                                data: JSON.stringify(model),
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
                                    //CargarDetallePedido();
                                    //$("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                                    //microefectoPedidoGuardado();
                                    CerrarLoad();
                                    TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);
                                    agregado.html("Agregado");
                                    var totalAgregado = parseInt(cantidad) + parseInt(CantidadesAgregadas);
                                    $(divPadre).find('.hdBuscadorCantidadesAgregadas').val(totalAgregado);
                                    return true;
                                },
                                error: function (data, error) {
                                    AjaxError(data);
                                    return false;
                                }
                            });
                        }
                        else {
                            AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + LimiteVenta + ") del producto.");
                        }
                    }
                },
                RedireccionarAFichaDeFotoYDescripcion: function (e) {
                    e.preventDefault();
                    var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
                    var codigoEstrategia = $(divPadre).find('.hdBuscadorCodigoTipoEstrategia').val();
                    var codigoCampania = $(divPadre).find('.hdBuscadorCampaniaID').val();
                    var codigoCuv = $(divPadre).find('.hdBuscadorCUV').val();
                    var OrigenPedidoWeb = $(divPadre).find('.hdBuscadorOrigenPedidoWeb').val();

                    var codigo = ['030', '005', '001', '007', '008', '009', '010', '011'];

                    if (codigo.indexOf(codigoEstrategia) >= 0) {
                        var UrlDetalle = GetPalanca(codigoEstrategia);
                        if (UrlDetalle == "") return false;
                        UrlDetalle += codigoCampania + "/" + codigoCuv + "/" + OrigenPedidoWeb;
                        //console.log(UrlDetalle);
                        window.location = UrlDetalle;
                        return true;
                    }
                }

            },
            me.Inicializar = function () {
                me.Funciones.InicializarEventos();
            }
    }

    BuscadorPortalConsultorasMobile = new BuscadorSBMobile();
    BuscadorPortalConsultorasMobile.Inicializar();

});


function AjaxError(data) {
    CerrarLoad();
    if (checkTimeout(data)) AbrirMensaje(data.message);
}

function PedidoOnSuccessSugerido(model) {

    $("#divObservaciones").html("");
    $("#hdnDescripcionEstrategia").val("");
    $("#hdnDescripcionLarga").val("");
    $("#hdnDescripcionProd").val("");

    $("#hdfCUV").val("");
    $("#hdfDescripcionProd").val("");
    $("#txtCUV").val("");
    $("#hdfMarcaID").val("");
    $("#hdfPrecioUnidad").val("");
    $("#txtPrecioR").val("");
    $("#txtDescripcionProd").val("");
    $("#txtCantidad").val("");
    $("#txtClienteDescripcion").val($("#hdfClienteDescripcion").val());
    $("#btnAgregar").attr("disabled", "disabled");

    $("#hdnRegistrosPaginar").val($("#hdnRegistros").val());
    $("#hdnRegistrosDePaginar").val($("#hdnRegistrosDe").val());
    $("#hdnRegistrosTotalPaginar").val($("#hdnRegistrosTotal").val());
    $("#hdnPaginaPaginar").val($("#hdnPagina").val());
    $("#hdnPaginaDePaginar").val($("#hdnPaginaDe").val());
    $("#ddlClientes").val($("#hdnClienteID2_").val());
    $("#hdnClienteID_").val($("#hdnClienteID2_").val());

    CalcularTotal();
    $("#txtCUV").focus();
}

function HorarioRestringido() {
    var horarioRestringido = false;
    $.ajaxSetup({
        cache: false
    });
    jQuery.ajax({
        type: "GET",
        url: baseUrl + "Pedido/EnHorarioRestringido",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    if (mostrarAlerta == true)
                        AbrirMensaje(data.message);
                    horarioRestringido = true;
                }
            }
        },
        error: function (data, error) { }
    });
    return horarioRestringido;
}

function CargarDetallePedido(page, rows) {
    $(".pMontoCliente").css("display", "none");

    $("#tbobyDetallePedido").html('<div><div style="width:100%;"><div style="text-align: center;"><br>Cargando Detalle de Productos<br><img src="' + urlLoad + '" /></div></div></div>');

    var clienteId = $("#ddlClientes").val() || -1;
    var obj = {
        sidx: "",
        sord: "",
        page: page || 1,
        rows: rows || $($('[data-paginacion="rows"]')[0]).val() || 20,
        clienteId: clienteId
    };

    $.ajax({
        type: "POST",
        url: baseUrl + "Pedido/CargarDetallePedido",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(obj),
        async: true,
        success: function (response) {
            if (checkTimeout(response)) {
                var data = response.data;

                ActualizarMontosPedido(data.FormatoTotal, data.Total, data.TotalCliente);

                $("#pCantidadProductosPedido").html(data.TotalProductos);

                $("#hdnRegistrosPaginar").val(data.Registros);
                $("#hdnRegistrosDePaginar").val(data.RegistrosDe);
                $("#hdnRegistrosTotalPaginar").val(data.RegistrosTotal);
                $("#hdnPaginaPaginar").val(data.Pagina);
                $("#hdnPaginaDePaginar").val(data.PaginaDe);

                $("#hdnRegistros").val(data.Registros);
                $("#hdnRegistrosDe").val(data.RegistrosDe);
                $("#hdnRegistrosTotal").val(data.RegistrosTotal);
                $("#hdnPagina").val(data.Pagina);
                $("#hdnPaginaDe").val(data.PaginaDe);

                var htmlCliente = "";

                $("#ddlClientes").empty();

                $.each(data.ListaCliente, function (index, value) {
                    if (value.ClienteID == -1) {
                        htmlCliente += '<option value="-1">Cliente</option>';
                    } else {
                        htmlCliente += '<option value="' + value.ClienteID + '">' + value.Nombre + "</option>";
                    }
                });

                $("#ddlClientes").append(htmlCliente);
                $("#ddlClientes").val(clienteId);

                data.ListaDetalleModel = data.ListaDetalleModel || [];
                $.each(data.ListaDetalleModel, function (ind, item) {
                    item.EstadoSimplificacionCuv = data.EstadoSimplificacionCuv;
                });

                var html = ArmarDetallePedido(data.ListaDetalleModel);
                $("#tbobyDetallePedido").html(html);

                var htmlPaginador = ArmarDetallePedidoPaginador(data);
                $("#paginadorCab").html(htmlPaginador);
                $("#paginadorPie").html(htmlPaginador);

                $("#paginadorCab [data-paginacion='rows']").val(data.Registros || 10);
                $("#paginadorPie [data-paginacion='rows']").val(data.Registros || 10);

                MostrarInformacionCliente(clienteId);
                mostrarSimplificacionCUV();

                MostrarBarra(response);
                CargarAutocomplete();

                if ($("#penmostreo").length > 0) {
                    if ($("#penmostreo").attr("[data-tab-activo]") == "1") {
                        $("ul.paginador_notificaciones").hide();
                    }
                }
            }
        },
        error: function (response, error) { }
    });
}