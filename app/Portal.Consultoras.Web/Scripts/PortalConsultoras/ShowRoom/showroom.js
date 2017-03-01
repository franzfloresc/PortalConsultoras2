/* 1: Escritorio    2: Mobile
1: Index    | 11: Detalle Oferta
2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {

        $('.responsive').slick({
            dots: true,
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 4,
            // You can unslick at a given breakpoint now by adding:
            // settings: "unslick"
            // instead of a settings object

        });
    }

    $("body").on("click", "[data-btn-agregar-sr]", function (e) {
        
    });
});
