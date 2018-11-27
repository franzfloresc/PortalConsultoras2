var ProductosRecomendados = (function () {

    var _elementos = {
        noMostrarProductosRecomendados:'.cerrar_seccion_productos_recomendados'
    };
    var _config = {
        isMobile: window.matchMedia("(max-width:991px)").matches
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

            carrusel.slick({
                infinite: false,
                lazyLoad: 'ondemand',
                slidesToShow: 3,
                slidesToScroll: 1,
                autoplay: false,
                speed: 300,
                prevArrow: '<a class="productos_recomendados_controles_carrusel js-slick-prev-h"><img src="/Content/Images/arrow_left.svg")" alt="" /></a>',
                nextArrow: '<a class="productos_recomendados_controles_carrusel next js-slick-next-h"><img src="/Content/Images/arrow_right.svg")" alt="" /></a>'
            });
        }
    };
    var _eventos = {
        OcultarProductosRecomendados: function (e) {
            e.preventDefault();
            var seccionProductosRecomendados = $(this).parents('.productos_recomendados_wrapper');
            seccionProductosRecomendados.slideUp(200);
        }
    };
    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
        _funciones.ArmarCarruselProductosRecomendados();
    }

    return {
        Inicializar: Inicializar
    };
})();

$(document).ready(function () {

    ProductosRecomendados.Inicializar();

});