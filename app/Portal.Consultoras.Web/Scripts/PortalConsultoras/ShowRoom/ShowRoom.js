/* 1: Escritorio    2: Mobile
1: Index    | 11: Detalle Oferta
2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {

        //$('.js-slick-prev').remove();
        //$('.js-slick-next').remove();
        //$('.responsive').slick('unslick');

        $('.responsive').not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
        })

    }

    $("body").on("click", "[data-btn-agregar-sr]", function (e) {

    });
});
