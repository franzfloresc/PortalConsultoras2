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
            }
        },
        me.Eventos = {
            AccionesCampoBusquedaAlDigitar: function () {
                var cantidadCaracteresParaMostrarSugerenciasBusqueda = $(this).val().length;
                if (cantidadCaracteresParaMostrarSugerenciasBusqueda > 0) {
                    me.Funciones.CampoDeBusquedaConCaracteres($('#CampoBuscadorProductos'));
                    if (cantidadCaracteresParaMostrarSugerenciasBusqueda >= CaracteresBuscador) {

                        var service = $.ajax({
                            url: baseUrl + "Buscador/BusquedaProductos",
                            method: 'POST',
                            data: {
                                busqueda: $(this).val()
                            }
                        });

                        var successBusqueda = function (r) {
                            var resultados = "";
                            if (r.Productos.length > 0) {
                                for (var i = 0; i < r.Productos.length; i++) {
                                    resultados += '<div class="resultado_busqueda_producto displayBlock text-left">';
                                    resultados += ' <div class="resultado_busqueda_img_prod displayInlineBlock">';
                                    resultados += '     <img src="' + r.Productos[i].Imagen + '" alt="Imagen no disponible" class="imagen_no_disponible" onerror="this.onerror=null;this.src="' + baseUrl + 'Content/Images/imagen_prod_no_disponible.png' + '""/>';
                                    resultados += ' </div>';
                                    resultados += ' <div class="resultado_busqueda_descrip_prod displayInlineBlock">';
                                    resultados += '     <div class="resultado_busqueda_nom_producto">' + r.Productos[i].Descripcion + '</div>';
                                    resultados += '     <div class="resultado_busqueda_precio_prod">';
                                    resultados += '         <span class="resultado_busqueda_precio_normal displayInlineBlock">' + r.Productos[i].Valorizado + '</span>';
                                    resultados += '         <span class="resultado_busqueda_precio_oferta displayInlineBlock">' + r.Productos[i].Precio + '</span>';
                                    resultados += '     </div>';
                                    resultados += '     <div class="resultado_busqueda_tipo_oferta_prod displayBlock text-uppercase">CATALOGO</div>';
                                    resultados += ' </div>';
                                    //condicion
                                    if (r.Productos[i].CodigoEstrategia == "2003") {
                                        resultados += '<div class="resultado_busqueda_btn_elegir_opcion_wrapper displayInlineBlock text-center">';
                                        resultados += ' <a class="btn_elegir_opcion displayBlock text-center text-uppercase">Elige tu opción</a>';
                                        resultados += '</div>';
                                    } else {
                                        resultados += ' <div class="resultado_busqueda_cantidad_prod displayInlineBlock js-no-popup" data-cantidad-contenedor="">';
                                        resultados += '     <a class="cantidad_menos_home js-no-popup" onclick="javascript:EstrategiaAgregarModule.DisminuirCantidad(event)"><img src = "' + baseUrl + 'Content/Images/Mobile/Esika/menos.png' + '" alt = "" ></a>';
                                        resultados += '     <input type="tel" value="1" size="2" maxlength="2" id="txtCantidad" data-input="cantidad" class="rango_cantidad_pedido text-center ValidaNumeral ValidaPasteNumeral js-no-popup" />';
                                        resultados += '     <a class="cantidad_mas_home js-no-popup" onclick="javascript:EstrategiaAgregarModule.AdicionarCantidad(event)"><img src = "' + baseUrl + 'Content/Images/Mobile/Esika/mas.png' + '" alt = "" ></a>';
                                        resultados += '     <div class="clear"></div>';
                                        resultados += ' </div>';
                                        resultados += ' <div class="resultado_busqueda_btn_agregar_wrapper displayInlineBlock text-center">';
                                        resultados += '     <a class="boton_Agregalo_home displayBlock text-center text-uppercase">Agrégalo</a>';
                                        resultados += ' </div>';
                                    }

                                    resultados += '</div>';
                                }
                            }
                            $('#ResultadoBuscador').html(resultados);
                        }
                        service.then(successBusqueda, function (e) {
                            console.log(e);
                        });
                    }

                } else {
                    me.Funciones.CampoDeBusquedaSinCaracteres($(this));
                }
            },
            LimpiarCampoBusqueda: function (e) {
                e.preventDefault();
                me.Funciones.CampoDeBusquedaSinCaracteres($('#CampoBuscadorProductos'));
                $('#CampoBuscadorProductos').val('');
                $('#CampoBuscadorProductos').trigger('focus');
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