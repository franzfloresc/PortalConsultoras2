function showLoader() {
    $('#load_img').wrap("<div id='loader_background' style='background-color:RGBA(0,0,0,0.5); width:" + $(window).width() + "px; height:" + $(window).height() + "px; position:fixed; top:0px; left:0px; bottom:0; right:0; z-index:10; opacity:0;'></div>");
    $('#load_img').css({ 'display': 'block', 'top': ($(window).height() / 2) - 35, 'left': ($(window).width() / 2) - 35, 'opacity': 0 });

    $('#load_img, #loader_background').animate({
        opacity: 1
    }, 150, function () {
        // Animation complete.
    });
}

function hideLoader() {

    $('#load_img, #loader_background').animate({
        opacity: 0
    }, 150, function () {
        // Animation complete.
        $('#load_img').css({ 'display': 'none' });
        $('#load_img').unwrap();
    });

}