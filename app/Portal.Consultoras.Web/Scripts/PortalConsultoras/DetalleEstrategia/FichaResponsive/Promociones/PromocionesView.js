const _promoModal = document.getElementById('modal_promociones')


//document.addEventListener('click', function (event) {
//    if (event.target.matches('a[href], a[href] *')) {
//        event.preventDefault();
//        console.log('works fine')
//    }
//}, false);

document.addEventListener('click', function (event) {
    if (event.target.closest('[data-selector]')) {
        
        _showModal('#modal_promociones')
        console.log('abre modal')
    }
    if (event.target.parentElement.matches("#cerrar-promociones-modal")) {
        _hideModal('#modal_promociones')
        console.log('cierra modal')
    }
}, false);

var _showModal = function (idModal) {
    if ($("body").find(".modal-fondo").length == 0) {
        $("body").append('<div class="modal-fondo" style="opacity: 0.8; display:none"></div>');
    }

    $("body").css('overflow', 'hidden');
    $('.modal-fondo').css('opacity', '.8');
    $('.modal-fondo').show();
    $(idModal).addClass("popup_active");

    return true;
};

var _hideModal = function (idModal) {
    $(idModal).removeClass('popup_active');
    $('.modal-fondo').css('opacity', '0');
    $('.modal-fondo').hide();
    $("body").css('overflow', 'auto');

    return true;
};