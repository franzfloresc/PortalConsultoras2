$(document).ready(function () {
    $('#lightSlider').lightSlider({
        gallery: true,
        item: 1,
        loop: true,
        slideMargin: 0,
        thumbItem: 5,
        addClass: '',
        mode: "slide",
        useCSS: true,
        cssEasing: 'ease', //'cubic-bezier(0.25, 0, 0.25, 1)',//
        easing: 'linear', //'for jquery animation',////
        speed: 400, //ms'
        auto: false,
        loop: false,
        slideEndAnimation: true,
        pause: 2000,
        enableTouch: true,
        enableDrag: true,
        freeMove: true,
        swipeThreshold: 40,
        keyPress: true,
        controls: true,
        prevHtml: '',
        nextHtml: ''
    });
});

$(document).ready(main);

var contador = 1;

function main() {
    $('.btn-mostrar-productos').click(function () {
        if (contador == 1) {
            $('.contenedor-items-revista').css("display", "block");
            $('.demo-lightSlider a.btn-ver-mas span.txt-ocultar').css("display", "block");
            $('.demo-lightSlider a.btn-ver-mas span.txt-ver').css("display", "none");
            contador = 0;
        } else {
            contador = 1;
            $('.contenedor-items-revista').css("display", "none");
            $('.demo-lightSlider a.btn-ver-mas span.txt-ocultar').css("display", "none");
            $('.demo-lightSlider a.btn-ver-mas span.txt-ver').css("display", "block");
        }
    });
    
}


