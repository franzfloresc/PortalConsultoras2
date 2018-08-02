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
                            });

                            var lista = r;

                            if (lista.length <= 0) {
                                $('#ResultadoBuscador').fadeOut(150);
                                me.Funciones.CampoDeBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                            } else {
                                $('#ResultadoBuscador').html('');
                                console.log(r);
                                SetHandlebars('#js-ResultadoBuscador', lista, '#ResultadoBuscador');

                                $.each($('#ResultadoBuscador .resultado_busqueda_producto'), function (index, obj) {
                                    var h = $(obj).find('.resultado_busqueda_nom_producto').height();
                                    if (h > TotalCaracteresEnListaBuscador) {
                                        var txt = $(obj).find('.resultado_busqueda_nom_producto').html();
                                        var splits = txt.split(" ");
                                        var lent = splits.length;
                                        var cont = false;
                                        for (var i = lent; i < 0; i++) {
                                            if (cont) continue;
                                            splits.splice(i - 1, 1);
                                            $(obj).find(".resultado_busqueda_nom_producto").html(splits.join(" "));
                                            var hx = $(obj).find(".resultado_busqueda_nom_producto").height();
                                            if (hx <= TotalCaracteresEnListaBuscador) {
                                                var txtF = splits.join(" ");
                                                txtF = txtF.substr(0, txtF.length - 3);
                                                $(obj).find(".resultado_busqueda_nom_producto").html(txtF + "...");
                                                cont = true;
                                            }
                                        }
                                    }
                                });
                            }

                            setTimeout(function () {
                                $('.spinner').fadeOut(150);
                                $('#ResultadoBuscador').fadeIn(150);
                            }, 400);
                            console.log(r);
                        }
                        service.then(successBusqueda, function (e) {
                            console.log(e);
                        });

                    } else {
                        $('#ResultadoBuscador').fadeOut(150);
                        me.Funciones.CampoDeBusquedaSinCaracteres($(this));
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