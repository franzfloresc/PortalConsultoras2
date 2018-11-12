﻿var BuscadorPortalConsultoras;
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
    { name: 'tab', val: 9 },
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

    var BuscadorSB;
    var ContadorBusquedas = 0;
    BuscadorSB = function () {
        var me = this;

        me.Funciones = {
            InicializarEventos: function () {
                $(document).on('click', 'body', me.Eventos.CerrarResultadosBusqueda);
                $(document).on('focus', '#CampoBuscadorProductos', me.Eventos.OcultarTooltipInformativo);
                $(document).on('keyup', '#CampoBuscadorProductos', me.Eventos.AccionesCampoBusquedaAlDigitar);
                $(document).on('click', '.opcion_limpiar_campo_busqueda_productos', me.Eventos.LimpiarCampoBusqueda);
                $(document).on('click', '.agregarProductoBuscador', me.Eventos.AgregarProducto);
                $(document).on('click', '.redireccionarFicha', me.Eventos.RedireccionarAFichaDeFotoYDescripcion);
            },
            ModificarAnchoBuscadorFiltros: function () {

                var enlacesVisiblesMenuLateralDerechoSegunVista = $('.visibilidadEnlaceMenu:visible');

                if ($('.new_menu').first().find('a').attr("title") == "SOCIA EMPRESARIA") {
                    if (enlacesVisiblesMenuLateralDerechoSegunVista.length > 2) {
                        $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria_vista_pedido');
                    } else {
                        if (window.location.href.indexOf("Bienvenida") > -1) {
                            $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria_vista_bienvenida');
                        } else {
                            $('.buscador_productos').addClass('buscador_productos_con_enlace_menu_socia_empresaria');
                        }
                    }
                } else {
                    $('.menu_new_esika').addClass('anchoMenu_sinEnlaceSociaEmpresaria');
                    if (enlacesVisiblesMenuLateralDerechoSegunVista.length > 2) {
                        $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria_vista_pedido');
                    } else {
                        if (window.location.href.indexOf("Bienvenida") > -1) {
                            $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria_vista_bienvenida');
                        } else {
                            $('.buscador_productos').addClass('buscador_productos_sin_enlace_menu_socia_empresaria');
                        }
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
                $('.lista_resultados_busqueda_productos').animate({
                    'min-height': '95px',
                    'height': 'auto'
                }, 100);

                $('.campo_busqueda_fondo_on_focus').delay(50);
                $('.campo_busqueda_fondo_on_focus').fadeOut(100);
                $(element).removeClass('campo_buscador_productos_activo');
                $('.opcion_limpiar_campo_busqueda_productos').fadeOut(100);
                $('.enlace_busqueda_productos').delay(50);
                $('.enlace_busqueda_productos').fadeIn(100);
            },
            AccionesLimpiarBusqueda: function (campoBuscador, resultadoBuscador) {
                me.Funciones.CampoDeBusquedaSinCaracteres(campoBuscador);
                $(campoBuscador).val('');
                $(resultadoBuscador).html('');
            }
        },
            me.Eventos = {
                AccionesCampoBusquedaAlDigitar: function (event) {
                    if ($('.tooltip_informativo_sobre_opcion_busqueda_prod').is(':visible')) {
                        $('.tooltip_informativo_sobre_opcion_busqueda_prod').fadeOut(100);
                    }

                    // validar teclas especiales
                    var key = false;
                    $.each(keys, function (i, value) {
                       if (value.val === event.which) key = true;
                    });
                    if (key) return false;

                    $('#ResultadoBuscador').html('');
                    var valBusqueda = $(this).val();
                    var cantidadCaracteresParaMostrarSugerenciasBusqueda = $(this).val().length;

                    if (event.which == 27) {
                        if ($('.lista_resultados_busqueda_productos').length > 0) {
                            me.Funciones.AccionesLimpiarBusqueda($('#CampoBuscadorProductos'), $('#ResultadoBuscador'));
                            return false;
                        }
                    }

                    if (cantidadCaracteresParaMostrarSugerenciasBusqueda >= CaracteresBuscador) {

                        me.Funciones.CampoDeBusquedaConCaracteres($('#CampoBuscadorProductos'));
                            if (ContadorBusquedas === 0) {
                                if (!(typeof AnalyticsPortalModule === 'undefined'))
                                    AnalyticsPortalModule.MarcaBarraBusqueda();
                                ContadorBusquedas++;
                            }                           
                        
                            
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
                                    $('.spinner').fadeOut(150);
                                    $('.busqueda_sin_resultados').fadeIn(60);
                                } else {
                                    setTimeout(function () {
                                        if ($('.busqueda_sin_resultados').is(':visible')) {
                                            $('.busqueda_sin_resultados').fadeOut(60);
                                        }
                                        $('.spinner').fadeOut(150);
                                        $('#ResultadoBuscador').delay(50);
                                        $('#ResultadoBuscador').fadeIn(100);
                                        $('.lista_resultados_busqueda_productos').animate({
                                            'min-height': $('#ResultadoBuscador').height() + 43
                                        }, 100);

                                    }, 400);

                                    SetHandlebars('#js-ResultadoBuscador', lista, '#ResultadoBuscador');
                                        $(".lista_resultados_busqueda_productos").one("mouseover", function () {
                                            var buscar = $("#CampoBuscadorProductos").val();
                                            AnalyticsPortalModule.MarcaSeleccionarContenidoBusqueda(buscar);

                                        });
                                }

                            }

                            xhr.then(successBusqueda, function (e) {
                            });

                        }, 200);

                    } else {
                        me.Funciones.CampoDeBusquedaSinCaracteres($(this));
                        if ($('.busqueda_sin_resultados').is(':visible')) {
                            $('.busqueda_sin_resultados').fadeOut(60);
                        }
                        $('#ResultadoBuscador').fadeOut(150);
                        me.Funciones.CampoDeBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                    }

                },
                LimpiarCampoBusqueda: function (e) {
                    e.preventDefault();
                    me.Funciones.AccionesLimpiarBusqueda($('#CampoBuscadorProductos'), $('#ResultadoBuscador'));
                    $('#CampoBuscadorProductos').focus();
                },
                CerrarResultadosBusqueda: function (e) {
                    var buscadorProductos = $('.buscador_productos');
                    var seMuestraListaResultadosBusqueda = $('.lista_resultados_busqueda_productos').css('display') == 'block';
                    if (seMuestraListaResultadosBusqueda) {
                        if ((!buscadorProductos.is(e.target) && buscadorProductos.has(e.target).length === 0)) {
                            me.Funciones.AccionesLimpiarBusqueda($('#CampoBuscadorProductos'), $('#ResultadoBuscador'));
                        }
                    }
                },
                OcultarTooltipInformativo: function () {
                    if ($('.tooltip_informativo_sobre_opcion_busqueda_prod').is(':visible')) {
                        $('.tooltip_informativo_sobre_opcion_busqueda_prod').fadeOut(100);
                    }
                },
                AgregarProducto: function (e) {
                    e.preventDefault();
                    AbrirLoad();

                    var divPadre = $(this).parents("[data-item='ProductoBuscador']").eq(0);
                    var model = JSON.parse($(divPadre).find(".hdBuscadorJSON").val());
                    var cantidad = $(divPadre).find("[data-input='cantidad']").val();
                    var agregado = $(divPadre).find(".etiqueta_buscador_producto");

                    if (model.TipoPersonalizacion == 'LIQ') {
                        RegistroLiquidacion(model, cantidad, agregado);
                    } else {
                        var cuv = model.CUV;
                        var tipoOfertaSisID = model.TipoPersonalizacion == 'CAT' ? 0 : model.TipoEstrategiaId;
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
                                if (!(typeof AnalyticsPortalModule === 'undefined'))
                                    AnalyticsPortalModule.MarcaAnadirCarritoBuscador(model, OrigenPedidoWeb, $("#CampoBuscadorProductos").val());
                              
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
                        //window.location = UrlDetalle;
                        if (!(typeof AnalyticsPortalModule === 'undefined'))
                            AnalyticsPortalModule.MarcaEligeUnaOpcion(UrlDetalle);
                        return true;
                    }
                }
            },
            me.Inicializar = function () {
                me.Funciones.InicializarEventos();
                setTimeout(function () {
                    me.Funciones.ModificarAnchoBuscadorFiltros();
                }, 1000);
            }
    }

    BuscadorPortalConsultoras = new BuscadorSB();
    BuscadorPortalConsultoras.Inicializar();

});

$(document).keyup(function (e) {
    if (e.keyCode == 27) { // escape key maps to keycode `27`

        if ($('.lista_resultados_busqueda_productos').length > 0) {
            $('.lista_resultados_busqueda_productos').fadeOut(100);
            $('.lista_resultados_busqueda_productos').removeClass('animarAlturaListaResultadosBusqueda');
            $('.campo_busqueda_fondo_on_focus').delay(50);
            $('.campo_busqueda_fondo_on_focus').fadeOut(100);
            $('#CampoBuscadorProductos').removeClass('campo_buscador_productos_activo');
            $('.opcion_limpiar_campo_busqueda_productos').fadeOut(100);
            $('.enlace_busqueda_productos').delay(50);
            $('.enlace_busqueda_productos').fadeIn(100);
            $('#ResultadoBuscador').html('');

            $('#CampoBuscadorProductos').val('');
            $('#CampoBuscadorProductos').focus();
            $('#ResultadoBuscador').html('');
        }
    }
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

                            if (isPagina('pedido')) {
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