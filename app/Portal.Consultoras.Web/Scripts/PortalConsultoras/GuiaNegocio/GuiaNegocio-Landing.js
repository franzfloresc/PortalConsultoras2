$(document).ready(main);

var contador = 0;

function main() {
    $('.cerrar-vineta .sbcont span').click(function () {
        // $('nav').toggle();

        if (contador == 1) {
            $('.cont-vineta').animate({
                right: '0'
            });
            $('.cerrar-vineta').animate({
                right: '150px'
            });
            contador = 0;
        } else {
            contador = 1;
            $('.cont-vineta').animate({
                right: '-100%'
            });
            $('.cerrar-vineta').animate({
                right: '0%'
            });
        }

    });
};