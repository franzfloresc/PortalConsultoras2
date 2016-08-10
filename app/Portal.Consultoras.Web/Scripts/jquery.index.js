$(document).ready(function() {

    var item_selected = null;
    var desfase = ($(window).width() - 1280) / 2;


    $('#menu li').mouseenter(function () {
        $('.submenu').css('display', 'none');
        var submenu = $(this).parent().parent().find('#submenu' + ($(this).index() + 1));
        submenu.stop().fadeTo('fast', 1).css({ 'width': $(window).width() });
        var submenuLeft = ($(this).offset().left + ($(this).outerWidth() / 2)) - (submenu.outerWidth() / 2);

        desfase = ($(window).width() - 1280) / 2;
        if ($(window).width() > 1280) {
            if (submenuLeft + submenu.width() < 1280) {
                //submenu.css({ 'left': (submenuLeft > desfase) ? submenuLeft : 0 });
                submenu.css({ 'left': 0 });
                //console.log('left', submenuLeft + submenu.width(), submenuLeft, submenu.width(), desfase);
            }
            else {
                submenu.css({ 'right': desfase });//, 'left': 'auto' });
                //console.log('right');
            }
        }
        else {
            submenu.css({ 'left': 0 });
            //console.log('left minor 1280');
        }
        $("#white_bg_for_menu").css('width', desfase);

        $(this).addClass('li_selected');
        item_selected = $(this);
    });

    $('#menu li').mouseleave(function () {
        $('#menu li').removeClass('li_selected');
    });

    $('.submenu').mouseenter(function () {
        $(item_selected).addClass('li_selected');
    });

    $('.submenu').mouseleave(function () {
        $('.submenu').fadeTo('fast', 0.0).css('display', 'none');
        $(item_selected).removeClass('li_selected');
    });

    $('#logo_tsmv, #header_tsmv, #white_bg_for_menu').mouseover(function () {
        $('.submenu').fadeTo('fast', 0.0).css('display', 'none');
        $(item_selected).removeClass('li_selected');
    });

});

$(window).resize(function () {
    desfase = ($(window).width() - 1280) / 2;
    $("#white_bg_for_menu").css('width', desfase);
});


