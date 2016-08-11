
function main() {
    $('.icon-menu').click(function () {
        $('.menu').animate({ left: '0px' }, 200);
        $('body').animate({ left: '100%' }, 200);
        $('body').css({ 'overflow-x': 'hidden' });
        $('body').css({ 'overflow-y': 'hidden' });
        $('.icon-close').css({ 'display': 'block' });
        $('.bg_white').css({ 'display': 'block' });
    });
    $('.icon-close').click(function () {
        $('.menu').animate({ left: '-100%' }, 200);
        $('body').animate({ left: '0px' }, 200);
        $('.icon-close').css({ 'display': 'none' });
        $('.bg_white').css({ 'display': 'none' });
        $('body').css({ 'overflow-y': 'scroll' });
    });
}

(function ($) {
    $(document).ready(function () {
        $('#cssmenu > ul > li > a').click(function () {
            $('#cssmenu li').removeClass('active');
            $(this).closest('li').addClass('active');
            var checkElement = $(this).next();
            if ((checkElement.is('ul')) && (checkElement.is(':visible'))) {
                $(this).closest('li').removeClass('active');
                checkElement.slideUp('normal');
            }
            if ((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
                $('#cssmenu ul ul:visible').slideUp('normal');
                checkElement.slideDown('normal');
            }
            if ($(this).closest('li').find('ul').children().length == 0) {
                return true;
            } else {
                return false;
            }
        });
    });
})(jQuery);


$(document).ready(function () {
    main();
});