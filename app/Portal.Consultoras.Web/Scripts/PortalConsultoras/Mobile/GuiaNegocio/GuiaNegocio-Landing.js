$(document).ready(function () {
    var contadorbottomgnd = 1;
    $('.revistagnd').click(function () {
        // $('nav').toggle();

        if (contadorbottomgnd == 1) {
            $('.revistagnd').animate({
                bottom: '0'
            });
            contadorbottomgnd = 0;
        } else {
            contadorbottomgnd = 1;
            $('.revistagnd').animate({
                bottom: '-132px'
            });
        }

    });
});