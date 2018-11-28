﻿var ProductoRecomendadoModule = (function () {

    var _elementos = {
        noMostrarProductosRecomendados: '.cerrar_seccion_productos_recomendados',
        divProducto: "#divProductosRecomendados",
        templateProducto: "#producto-recomendado-template"
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
    };
    var _provider = {
        RecomendacionesPromise: function(params) {
            var dfd = jQuery.Deferred();

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "ProductoRecomendado/ObtenerProductos",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                cache: false,
                success: function(data) {
                    dfd.resolve(data);
                },
                error: function(data, error) {
                    dfd.reject(data, error);
                }
            });
            return dfd.promise();
        }
    };
    var _funciones = { //Funciones privadas
        InicializarEventos: function () {
            $(document).on("click", _elementos.noMostrarProductosRecomendados, _eventos.OcultarProductosRecomendados);
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
                slidesToShow: _config.isMobile ? 1 : 3,
                slidesToScroll: 1,
                autoplay: false,
                speed: 300,
                variableWidth: _config.isMobile ? true : false,
                prevArrow: _config.isMobile ? '' : '<a class="productos_recomendados_controles_carrusel previous js-slick-prev-h"><img src="/Content/Images/arrow_left.svg")" alt="" /></a>',
                nextArrow: _config.isMobile ? '' : '<a class="productos_recomendados_controles_carrusel next js-slick-next-h"><img src="/Content/Images/arrow_right.svg")" alt="" /></a>'
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

            }).on('afterChange', function(event, slick, currentSlide) {
                //$('.previous').hide();
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
                    SetHandlebars(_elementos.templateProducto, data.Productos, _elementos.divProducto);
                    if (data.Total > 3) {
                         _funciones.ArmarCarruselProductosRecomendados();
                    }

                    _eventos.MostrarProductosRecomendados();
                }).fail(function (data, error) {

                });
        },
    };
    var _eventos = {
        OcultarProductosRecomendados: function (e) {
            e.preventDefault();
            $(_elementos.divProducto).slideUp(200);
        },
        MostrarProductosRecomendados: function (e) {
            e.preventDefault();
            $(_elementos.divProducto).slideDown(200);
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
        _eventos.OcultarProductosRecomendados();
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