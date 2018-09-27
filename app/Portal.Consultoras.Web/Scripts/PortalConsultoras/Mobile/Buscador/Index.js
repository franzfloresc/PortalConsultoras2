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
                    //var key = keys.find(key => key.val === event.which);
                    var key = keys.find(function (key) {
                        return key.val === event.which
                    });
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
                                url: baseUrl + "Buscador/BusquedaProductos",
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

                    AbrirLoad();

                    if (model.TipoPersonalizacion == 'LIQ') {
                        RegistroLiquidacion(model, cantidad, agregado);
                    } else {                       
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
                            Posicion: posicion,
                            EstrategiaID: EstrategiaID,
                            LimiteVenta: LimiteVenta
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

function RegistroLiquidacion(model, cantidad, producto) {

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

    $.getJSON(baseUrl + 'OfertaLiquidacion/ValidarUnidadesPermitidasPedidoProducto', { CUV: model.CUV, Cantidad: cantidad, PrecioUnidad: model.Precio }, function (data) {
        if (data.message != "") {
            CerrarLoad();
            AbrirMensaje(data.message);
            return false;
        }

        if (parseInt(data.Saldo) < parseInt(cantidad)) {
            var Saldo = data.Saldo;
            var UnidadesPermitidas = data.UnidadesPermitidas;
            $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: model.CUV }, function (data) {
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
            $.getJSON(baseUrl + 'OfertaLiquidacion/ObtenerStockActualProducto', { CUV: model.CUV }, function (data) {
                if (parseInt(data.Stock) < parseInt(cantidad)) {
                    AbrirMensaje("Lamentablemente, la cantidad solicitada sobrepasa el stock actual (" + data.Stock + ") del producto, verifique.", "LO SENTIMOS");
                    CerrarLoad();
                    return false;
                }
                else {

                    jQuery.ajax({
                        type: 'POST',
                        url: baseUrl + 'OfertaLiquidacion/InsertOfertaWebPortal',
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

                            producto.html('Agregado');

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