var ProductoRecomendadoModule = (function () {

    var _elementos = {
        noMostrarProductosRecomendados: '.cerrar_seccion_productos_recomendados',
        divProducto: "#divProductosRecomendados",
        templateProducto: "#producto-recomendado-template",
        botonAgregar: ".btn_producto_recomendado_agregalo",
        valueJSON: ".hdRecomendadoJSON"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches,
        maxCaracteresRecomendaciones: maxCaracteresRecomendaciones
    };
    var _provider = {
        RecomendacionesPromise: function (params) {
            var dfd = jQuery.Deferred();

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "ProductoRecomendado/ObtenerProductos",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                cache: false,
                success: function (data) {
                    dfd.resolve(data);
                    if (!(typeof AnalyticsPortalModule === 'undefined'))
                        AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(data, _config.isMobile,0);
                },
                error: function (data, error) {
                    dfd.reject(data, error);
                }
            });
            return dfd.promise();
        }
    };
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
            $(document).on("click", _elementos.noMostrarProductosRecomendados, _eventos.OcultarProductosRecomendados);
            $(document).on("click", _elementos.botonAgregar, _eventos.AgregarProductoRecomendado);
        },

        ArmarCarruselProductosRecomendados: function () {
            var carrusel = $('#carouselProductosRecomendados');

            if (carrusel[0].slick) {
                return;
            }
            carrusel.on('init', function (event, slick) {
                $('.previous').hide();
                if (slick.slideCount <= 3) {
                    $('.next').hide();
                }
            });
            carrusel.slick({
                infinite: false,
                //centerMode: true,
                centerPadding: '0px',
                lazyLoad: 'ondemand',
                slidesToShow: 3,
                slidesToScroll: 1,
                autoplay: false,
                speed: 300,
                variableWidth: true,
                prevArrow:  '<a class="productos_recomendados_controles_carrusel previous js-slick-prev-h"><img src="/Content/Images/arrow_left.svg")" alt="" /></a>',
                nextArrow:  '<a class="productos_recomendados_controles_carrusel next js-slick-next-h"><img src="/Content/Images/arrow_right.svg")" alt="" /></a>'
            }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {

                if (nextSlide == slick.slideCount - 3) {
                    $('.next').fadeOut(100);
                    $('.previous').fadeIn(100);
                } else if (nextSlide != slick.slideCount - 3 && nextSlide != 0) {
                    $('.next').fadeIn(100);
                    $('.previous').fadeIn(100);
                } else if (currentSlide == 0 || nextSlide == 0) {
                    $('.next').fadeIn(100);
                    $('.previous').fadeOut(100);
                }

                if (!(typeof AnalyticsPortalModule === 'undefined'))
                    AnalyticsPortalModule.MarcaRecomendacionesFlechaSiguiente();

                //if (!(typeof AnalyticsPortalModule === 'undefined'))
                //    AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(data, _config.isMobile, nextSlide);

            }).on('afterChange', function (event, slick, currentSlide) {
               
                if (!(typeof AnalyticsPortalModule === 'undefined'))
                    AnalyticsPortalModule.MarcaRecomendacionesFlechaAnterior();
            });
        },
        ArmarCarruselProductosRecomendadosMobile: function () {
            var carrusel = $('#carouselProductosRecomendados');

            if (carrusel[0].slick) {
                return;
            }
            carrusel.slick({
                infinite: false,
                //centerMode: true,
                centerPadding: '0px',
                lazyLoad: 'ondemand',
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: false,
                speed: 300,
                variableWidth: true,
                prevArrow: '',
                nextArrow: ''
            }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
                
                var numeroSlide = slick.slideCount - 2;

                if (!(typeof AnalyticsPortalModule === 'undefined'))
                    AnalyticsPortalModule.MarcaRecomendacionesFlechaAnterior();

                //if (!(typeof AnalyticsPortalModule === 'undefined'))
                    //AnalyticsPortalModule.MarcaProductImpressionRecomendaciones(data, _config.isMobile, numeroSlide);

            }).on('afterChange', function (event, slick, currentSlide) {

                
                if (!(typeof AnalyticsPortalModule === 'undefined'))
                    AnalyticsPortalModule.MarcaRecomendacionesFlechaSiguiente();
            });
        },

        ObtenerProductos: function (cuv, codigoProducto) {
            var modelo = {
                cuv: cuv,
                codigoProducto: codigoProducto
            };
            _provider.RecomendacionesPromise(modelo)
                .done(function (data) {
                    $(_elementos.divProducto).html("");
                    if (data.Total !== 0) {
                        $.each(data.Productos, function (index, item) {
                            item.posicion = index + 1;
                            if (item.Descripcion.length > _config.maxCaracteresRecomendaciones) {
                                item.Descripcion = item.Descripcion.substring(0, _config.maxCaracteresRecomendaciones) + "...";
                            }
                        });
                        SetHandlebars(_elementos.templateProducto, data.Productos, _elementos.divProducto);
                        if (_config.isMobile) {
                            _funciones.ArmarCarruselProductosRecomendadosMobile();
                        } else {
                            if (data.Total > 3) {
                                _funciones.ArmarCarruselProductosRecomendados();
                            }
                        }
                        _eventos.MostrarProductosRecomendados();
                    }

                }).fail(function (data, error) {

                });
        },
        OcultarSeccionRecomendados: function (e) {
            $(_elementos.divProducto).slideUp(200);
        }
    };
    var _eventos = {
        OcultarProductosRecomendados: function (e) {
            e.preventDefault();
            $(_elementos.divProducto).slideUp(200);
            set_local_storage(true, 'ocultar_productos_recomendados');
            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaOcultarRecomendaciones();
        },
        MostrarProductosRecomendados: function (e) {
            $(_elementos.divProducto).slideDown(200);
        },

        AgregarProductoRecomendado: function (e) {
            e.preventDefault();
            AbrirLoad();
            var divPadre = $(this).parents("[data-item='ProductoRecomendadoBuscador']").eq(0);

            if (!(typeof AnalyticsPortalModule === 'undefined'))
                AnalyticsPortalModule.MarcaAnadirCarritoRecomendaciones(divPadre, _elementos.valueJSON);

            BuscadorProvider.RegistroProductoBuscador(divPadre, _elementos.valueJSON);
        }
    };

    //Public functions
    function ObtenerProductos(cuv, codigoProducto) {
        _funciones.ObtenerProductos(cuv, codigoProducto);
    }
    function Inicializar() {
        _funciones.InicializarEventos();
        // _funciones.ArmarCarruselProductosRecomendados();
    }
    function OcultarProductosRecomendados() {
        _funciones.OcultarSeccionRecomendados();
    }

    return {
        Inicializar: Inicializar,
        ObtenerProductos: ObtenerProductos,
        OcultarProductosRecomendados: OcultarProductosRecomendados
    };
})();

$(document).ready(function () {
    ProductoRecomendadoModule.Inicializar();
});