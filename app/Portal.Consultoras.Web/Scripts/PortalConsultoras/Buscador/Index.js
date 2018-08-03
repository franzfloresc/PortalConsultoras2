var BuscadorPortalConsultoras;

$(document).ready(function () {
    'use strict';

    var BuscadorSB;

    BuscadorSB = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('keyup', '#CampoBuscadorProductos', me.Eventos.AccionesCampoBusquedaAlDigitar);
                $(document).on('click', '.opcion_limpiar_campo_busqueda_productos', me.Eventos.LimpiarCampoBusqueda);
                $(document).on('click', '.agregarProductoBuscador', me.Eventos.AgregarProducto);
            },
            ModificarAnchoBuscadorFiltros: function () {
                if (window.location.href.indexOf("Pedido") > -1) {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria_vista_pedido');
                    } else {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria_vista_pedido');
                    }
                } else if (window.location.href.indexOf("Ofertas") > -1) {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria_vista_ofertas');
                    } else {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria_vista_ofertas');
                    }
                } else {
                    if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria');
                    } else {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria');
                    }
                }
            },
            CampoDeBusquedaConCaracteres: function (campoBuscador) {
                $(campoBuscador).addClass('campo_buscador_productos_activo');
                $('.campo_busqueda_fondo_on_focus').fadeIn(100);
                $('.lista_resultados_busqueda_productos').delay(50);
                $('.lista_resultados_busqueda_productos').fadeIn(100);
                $('.enlace_busqueda_productos').fadeOut(100);
                $('.opcion_limpiar_campo_busqueda_productos').delay(50);
                $('.opcion_limpiar_campo_busqueda_productos').fadeIn(100);
            },
            CampoDeBusquedaSinCaracteres: function (element) {
                $('.lista_resultados_busqueda_productos').fadeOut(100);
                $('.lista_resultados_busqueda_productos').removeClass('animarAlturaListaResultadosBusqueda');
                $('.campo_busqueda_fondo_on_focus').delay(50);
                $('.campo_busqueda_fondo_on_focus').fadeOut(100);
                $(element).removeClass('campo_buscador_productos_activo');
                $('.opcion_limpiar_campo_busqueda_productos').fadeOut(100);
                $('.enlace_busqueda_productos').delay(50);
                $('.enlace_busqueda_productos').fadeIn(100);
                $('#ResultadoBuscador').html('');
            }
        },
            me.Eventos = {
                AccionesCampoBusquedaAlDigitar: function () {
                    var cantidadCaracteresParaMostrarSugerenciasBusqueda = $(this).val().length;

                    if (cantidadCaracteresParaMostrarSugerenciasBusqueda >= CaracteresBuscador) {

                        me.Funciones.CampoDeBusquedaConCaracteres($('#CampoBuscadorProductos'));
                        $('.spinner').fadeIn(150);

                        var service = $.ajax({
                            url: baseUrl + "Buscador/BusquedaProductos",
                            method: 'POST',
                            data: {
                                busqueda: $(this).val()
                            }
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
                                me.Funciones.CampoDeBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                                $('#ResultadoBuscador').fadeOut(150);
                            } else {
                                $('#ResultadoBuscador').html('');

                                SetHandlebars('#js-ResultadoBuscador', lista, '#ResultadoBuscador');
                            }

                            setTimeout(function () {
                                $('.spinner').fadeOut(150);
                                $('#ResultadoBuscador').fadeIn(150);
                                $('.lista_resultados_busqueda_productos').addClass('animarAlturaListaResultadosBusqueda');
                            }, 400);
                        }
                        service.then(successBusqueda, function (e) {
                            console.log(e);
                        });

                    } else {
                        me.Funciones.CampoDeBusquedaSinCaracteres($(this));
                        $('#ResultadoBuscador').fadeOut(150);
                    }

                },
                LimpiarCampoBusqueda: function (e) {
                    e.preventDefault();
                    me.Funciones.CampoDeBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                    $('#CampoBuscadorProductos').val('');
                    $('#CampoBuscadorProductos').focus();
                    $('#ResultadoBuscador').html('');
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
                    var OrigenPedidoWeb = OrigenPedidoDesktopBuscador;
                    var posicion = $(divPadre).find(".hdBuscadorPosicion").val();
                    var tipoEstrategiaId = tipoOfertaSisID;//$(divPadre).find(".hdBuscadorCodigoPalanca").val();
                    var agregado = $(divPadre).find(".etiqueta_buscador_producto");

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

                    /*$.getJSON(baseUrl + 'ShowRoom/ValidarUnidadesPermitidasPedidoProducto', { CUV: model.CUV, PrecioUnidad: model.PrecioUnidad, Cantidad: model.Cantidad }, function (data) {
                        if (data.message != '') {
                            AbrirMensaje(data.message);
                            return false;
                        }
                        if (parseInt(data.Saldo) < parseInt(cantidad)) {
                            var Saldo = data.Saldo;
                            var UnidadesPermitidas = data.UnidadesPermitidas;

                            CerrarLoad();

                            if (Saldo == UnidadesPermitidas)
                                AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                            else {
                                if (Saldo == "0")
                                    AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                                else
                                    AbrirMensaje("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                            }
                        } else {
                            $.getJSON(baseUrl + 'ShowRoom/ObtenerStockActualProducto', { CUV: model.CUV }, function (data) {
                                console.log(data);
                                if (parseInt(data.Stock) < model.Cantidad) {
                                    AbrirMensaje("Lamentablemente, no puede agregar el Producto, ya que sobrepasa el stock actual (" + data.Stock + "), verifique");
                                    return false;
                                } else {*/
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

                            if (isPagina('pedido')) {
                                if (model != null && model != undefined)
                                    PedidoOnSuccessSugerido(model);

                                CargarDetallePedido();
                                $("#pCantidadProductosPedido").html(data.cantidadTotalProductos > 0 ? data.cantidadTotalProductos : 0);
                                MostrarBarra(data);
                            }

                            microefectoPedidoGuardado();

                            CargarResumenCampaniaHeader();

                            CerrarLoad();

                            TrackingJetloreAdd(model.Cantidad, $("#hdCampaniaCodigo").val(), model.CUV);

                            agregado.html("Agregado");

                            return true;
                        },
                        error: function (data, error) {
                            AjaxError(data);
                            return false;
                        }
                    });
                    /*               }
                               });
                           }
                       });*/
                }
            },
            me.Inicializar = function () {
                me.Funciones.InicializarEventos();
                me.Funciones.ModificarAnchoBuscadorFiltros();
            }
    }

    BuscadorPortalConsultoras = new BuscadorSB();
    BuscadorPortalConsultoras.Inicializar();

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