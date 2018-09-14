var BuscadorPortalConsultoras;
var xhr = null;

var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();

// teclas especiales
const keys = [
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
                //$('.lista_resultados_busqueda_productos').removeClass('animarAlturaListaResultadosBusqueda');
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

                    // validar teclas especiales
                    var key = keys.find(key => key.val === event.which);
                    if (typeof key != 'undefined') {
                        return false;
                    }

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
                                    //me.Funciones.CampoDeBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                                    //$('#ResultadoBuscador').fadeOut(150);
                                    $('.spinner').fadeOut(150);
                                    $('.busqueda_sin_resultados').fadeIn(60);
                                } else {
                                    console.log('============ URL BUSCADOR ==========');
                                    console.log(lista[0].URLBsucador);
                                    console.log('============ URL BUSCADOR ==========');


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
                                        //$('.lista_resultados_busqueda_productos').addClass('animarAlturaListaResultadosBusqueda');
                                    }, 400);

                                    SetHandlebars('#js-ResultadoBuscador', lista, '#ResultadoBuscador');
                                }

                            }

                            xhr.then(successBusqueda, function (e) {
                                console.log(e);
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
                        var cuv = model.CUV;
                        var tipoOfertaSisID = model.TipoEstrategiaId;
                        var configuracionOfertaID = tipoOfertaSisID;
                        var indicadorMontoMinimo = 1;
                        var marcaID = model.MarcaId;
                        var precioUnidad = model.Precio;
                        var descripcionProd = model.Descripcion;
                        var descripcionEstrategia = model.DescripcionEstrategia;
                        var OrigenPedidoWeb = model.OrigenPedidoWeb;
                        var posicion = model.posicion;
                        var tipoEstrategiaId = tipoOfertaSisID;//$(divPadre).find(".hdBuscadorCodigoPalanca").val();
                        var LimiteVenta = model.LimiteVenta;
                        var CantidadesAgregadas = model.CantidadesAgregadas;

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

                        console.log('model', model);
                        
                        jQuery.ajax({
                            type: 'POST',
                            url: baseUrl + 'Pedido/PedidoInsertarBuscador',
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
                        //console.log(UrlDetalle);
                        window.location = UrlDetalle;
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