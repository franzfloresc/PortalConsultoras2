$(document).ready(function () {
    $('.demo-lightSlider a.btn-ver-mas').click(function () {
        $('.contenedor-items-revista').toggle();
    });

    $('#lightSlider').lightSlider({
        gallery: true,
        item: 1,
        loop: true,
        slideMargin: 0,
        thumbItem: 9,
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


