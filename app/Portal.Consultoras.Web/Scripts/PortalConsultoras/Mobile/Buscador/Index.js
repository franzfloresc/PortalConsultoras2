var BuscadorPortalConsultorasMobile;
var xhr = null;

var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();

// teclas especiales
var keys = [
    { name: 'shift', val: 16 },
    { name: 'ctrl', val: 17 },
    { name: 'alt', val: 18 },
    { name: 'pause', val: 19 },
    { name: 'caps ', val: 20 },
    { name: 'page up', val: 33 },
    { name: 'page down', val: 34 },
    { name: 'page down', val: 35 },
    { name: 'end', val: 36 },
    { name: 'home', val: 37 },
    { name: 'up arrow', val: 38 },
    { name: 'right arrow', val: 39 },
    { name: 'down arrow', val: 40 },
    { name: 'insert', val: 45 },
    { name: 'left window key', val: 91 },
    { name: 'right window key', val: 92 },
    { name: 'num lock', val: 144 },
    { name: 'f1', val: 112 },
    { name: 'f2', val: 113 },
    { name: 'f3', val: 114 },
    { name: 'f4', val: 115 },
    { name: 'f5', val: 116 },
    { name: 'f6', val: 117 },
    { name: 'f7', val: 118 },
    { name: 'f8', val: 119 },
    { name: 'f9', val: 120 },
    { name: 'f10', val: 121 },
    { name: 'f11', val: 122 },
    { name: 'f12', val: 123 }
];


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

                    // validar teclas especiales
                    var key = keys.find(key => key.val === event.which);
                    if (typeof key != 'undefined') {
                        return false;
                    }

                    $('#ResultadoBuscadorMobile').html('');
                    var valBusqueda = $(this).val();
                    var cantidadCaracteresParaMostrarSugerenciasBusquedaMobile = $(this).val().length;

                    if (cantidadCaracteresParaMostrarSugerenciasBusquedaMobile >= CaracteresBuscador) {
                        me.Funciones.CampoDeBusquedaMobileConCaracteres();
                        $('.spinner').fadeIn(150);

                        if (xhr && xhr.readyState != 4) {
                            xhr.abort();
                        }

                        delay(function () {

                            xhr = $.ajax({
                                type: 'POST',
                                url: baseUrl + "Mobile/Buscador/BusquedaProductos",
                                data: JSON.stringify({ busqueda: valBusqueda, totalResultados: TotalResultadosBuscador }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                cache: false,
                                success: function (msg) {
                                    console.log(msg);
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
                                    //$('#ResultadoBuscadorMobile').fadeOut(150);
                                    //me.Funciones.CampoDeBusquedaMobileSinCaracteres($('.opcion_limpiar_campo_busqueda_productos'));
                                    $('.spinner').fadeOut(150);
                                    $('.busqueda_sin_resultados').fadeIn(60);
                                } else {
                                    SetHandlebars('#js-ResultadoBuscador', lista, '#ResultadoBuscadorMobile');
                                    setTimeout(function () {
                                        if ($('.busqueda_sin_resultados').is(':visible')) {
                                            $('.busqueda_sin_resultados').fadeOut(60);
                                        }
                                        $('.spinner').delay(50);
                                        $('.spinner').fadeOut(150);
                                        $('#ResultadoBuscadorMobile').fadeIn(150);
                                    }, 400);
                                }
                            }

                            xhr.then(successBusqueda, function (e) {
                                console.log(e);
                            });

                        }, 200);

                    } else {
                        //me.Funciones.CampoDeBusquedaSinCaracteres($(this));
                        if ($('.busqueda_sin_resultados').is(':visible')) {
                            $('.busqueda_sin_resultados').fadeOut(60);
                        }
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
                   

                    var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
                    var model = JSON.parse($(divPadre).find(".hdBuscadorJSON").val());
                    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
                    var agregado = $(divPadre).find(".etiqueta_buscador_producto");

                    modelLiquidacionOfertas = {
                        Cantidad: cantidad,
                        ConfiguracionOfertaID: 3,
                        MarcaID: model.MarcaId,
                        CUV: model.CUV,
                        PrecioUnidad: model.Precio,
                        DescripcionProd: model.Descripcion,
                        DescripcionEstrategia: model.DescripcionEstrategia,
                        origenPedidoLiquidaciones: model.OrigenPedidoWeb
                    };

                    if (model.TipoPersonalizacion == 'LIQ') {
                        labelAgregadoLiquidacion = agregado;
                        RegistrarProductoOferta(e);
                    } else {
                        AbrirLoad();
                        var urlInsertar = '';
                        if (model.TipoPersonalizacion == 'CAT') {
                            urlInsertar = baseUrl + 'Pedido/PedidoInsertarBuscador';
                        } else {
                            urlInsertar = baseUrl + 'Pedido/PedidoAgregarProducto';
                        }

                        var cuv = model.CUV;
                        var tipoOfertaSisID = 0;
                        var configuracionOfertaID = 0;
                        var indicadorMontoMinimo = 1;
                        var marcaID = model.MarcaId;
                        var precioUnidad = model.Precio;
                        var descripcionProd = model.Descripcion;
                        var descripcionEstrategia = model.DescripcionEstrategia;
                        var OrigenPedidoWeb = model.OrigenPedidoWeb;
                        var posicion = model.posicion;
                        var tipoEstrategiaId = 0;//model.TipoEstrategiaId;
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

                        var urlInsertar = '';
                        if (model.TipoPersonalizacion == 'CAT') {
                            urlInsertar = baseUrl + 'Pedido/PedidoInsertarBuscador';
                        } else {
                            urlInsertar = baseUrl + 'Pedido/PedidoAgregarProducto';
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

                        jQuery.ajax({
                            type: 'POST',
                            url: urlInsertar,
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
                        console.log(UrlDetalle);
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