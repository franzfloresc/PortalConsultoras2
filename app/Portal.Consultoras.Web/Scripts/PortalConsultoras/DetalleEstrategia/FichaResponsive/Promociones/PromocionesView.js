var PromocionesView = function () {
    var _presenter = null;

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _elements = {
        banner: {
            all: "[data-selector]",
        },
        promocionesModal: {
            id: "#modal-promociones",
            btnCerrar: {
                id: "#cerrar-promociones-modal"
            }
        }
    };

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

    var _hideBanner = function () {
        $(_elements.banner.all).hide();
    };

    var _showBanner = function () {
        $(_elements.banner.all).show();

        $("body").on("click", _elements.banner.all, function (e) {
            e.preventDefault();
            _presenter.onShowModalPromocionesClicked();
            
        });

        $(_elements.promocionesModal.btnCerrar.id).click(function (e) {
            e.preventDefault();
            _hideModal(_elements.promocionesModal.id);
        });
    };

    var _showModalPromociones = function () {
        _showModal(_elements.promocionesModal.id);
    };

    return {
        setPresenter: _setPresenter,
        hideBanner: _hideBanner,
        showBanner: _showBanner,
        showModalPromociones: _showModalPromociones,
    };
};
