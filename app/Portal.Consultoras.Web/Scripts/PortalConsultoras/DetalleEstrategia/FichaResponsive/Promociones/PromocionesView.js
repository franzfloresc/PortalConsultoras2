var PromocionesView = function () {
    var _presenter = null;

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _elements = {
        banner: {
            id: "#banner-promocion",
            templateid: "#banner-promocion-template",
            all: "[data-selector]",
            hideBannerClass: "banner_promociones_ocultar",
        },
        promocionesModal: {
            id: "#modal-promociones",
            btnCerrar: {
                id: "#cerrar-promociones-modal"
            },
            condiciones: {
                id: "#carrusel-condiciones",
                templateid: "#template-producto-carrusel-responsive",
                contenedorid: "#seccion-carrusel-condiciones",
            },
            promocion: {
                id: "#producto-promocion",
                templateid: "#producto-promocion-template"
            }
        }
    };

    var _attributes = {
        origenPedidoWeb: "data-OrigenPedidoWeb",
        origenPedidoWebAgregar: "data-OrigenPedidoWebAgregar",
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
        $(_elements.banner.all).addClass(_elements.banner.hideBannerClass);
    };

    var _showBanner = function (estrategia) {
        SetHandlebars(_elements.banner.templateid,
            estrategia,
            _elements.banner.id);

        $(_elements.banner.all).removeClass(_elements.banner.hideBannerClass);

        $("body").on("click", _elements.banner.all, function (e) {
            e.preventDefault();
            _presenter.onShowModalPromocionesClicked();

        });

        $(_elements.promocionesModal.btnCerrar.id).click(function (e) {
            e.preventDefault();
            _hideModal(_elements.promocionesModal.id);
        });
    };

    var _cleanUnAttributesOnModalPromociones = function () {
        $(_elements.promocionesModal.id).find("[" + _attributes.origenPedidoWeb + "]").each(function (elem) {
            $(elem).removeAttr(_attributes.origenPedidoWeb);
        });

        $(_elements.promocionesModal.id).find("[" + _attributes.origenPedidoWebAgregar + "]").each(function (elem) {
            $(elem).removeAttr(_attributes.origenPedidoWebAgregar);
        });

        $(_elements.promocionesModal.promocion.id).attr(_attributes.origenPedidoWeb, "");
        $(_elements.promocionesModal.condiciones.contenedorid).attr(_attributes.origenPedidoWeb, "");
    };

    var _showModalPromociones = function () {
        _cleanUnAttributesOnModalPromociones();
        _showModal(_elements.promocionesModal.id);
    };

    var _showConditions = function (estrategia) {
        $(_elements.promocionesModal.condiciones.id).slick("unslick");
        $(_elements.promocionesModal.condiciones.id).html("");
        $(_elements.promocionesModal.condiciones.contenedorid).removeAttr(_attributes.origenPedidoWebAgregar);
        $(_elements.promocionesModal.condiciones.contenedorid).attr(_attributes.origenPedidoWebAgregar, estrategia.OrigenAgregarCondiciones);
        SetHandlebars(_elements.promocionesModal.condiciones.templateid, estrategia.Promocion, _elements.promocionesModal.condiciones.id);
        $(_elements.promocionesModal.condiciones.id).slick({
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            swipe: true,
            swipeToSlide: true,
            fade: false,
            arrows: false,
            infinite: false,
            centerMode: false,
            variableWidth: true
        });
        setTimeout(function () {
            $(_elements.promocionesModal.condiciones.id).slick('setPosition');
        }, 500);
    };

    var _showPromotion = function (estrategia) {
        $(_elements.promocionesModal.condiciones.id).removeAttr("data-origenpedidowebagregar");
        SetHandlebars(_elements.promocionesModal.promocion.templateid, estrategia.Promocion, _elements.promocionesModal.promocion.id);
        $(_elements.promocionesModal.promocion.id).attr("data-origenpedidowebagregar", estrategia.OrigenAgregarPromocion);
    };

    return {
        setPresenter: _setPresenter,
        hideBanner: _hideBanner,
        showBanner: _showBanner,
        showModalPromociones: _showModalPromociones,
        showConditions: _showConditions,
        showPromotion: _showPromotion,
    };
};
