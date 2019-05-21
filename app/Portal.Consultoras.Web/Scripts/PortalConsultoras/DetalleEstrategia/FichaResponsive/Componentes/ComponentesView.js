/// <reference path="../../../../jquery-3.3.1.js" />

var ComponentesView = function () {
    var _presenter = null;

    var _elements = {
        componentes: {
            templateId: "#componente-estrategia-template",
            id: "#componentes",
        },
        componente: {
            btnShowModal : {
                all : "[btn-show-types-tones-modal]",
            }
        },
        tiposTonosModal: {
            id: "#popup_tonos",
            titulo: {
                id: "[header-title]"
            },
            cantidadSeleccionados: {
                id: "[header-selected-quantity]"
            },
            btnCerrar: {
                id: "#cerrar-tipos-tonos-modal"
            }
        }
    };

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _renderComponentes = function (componente) {
        SetHandlebars(_elements.componentes.templateId, componente, _elements.componentes.id);

        $(_elements.componentes.id).on("click", _elements.componente.btnShowModal.all, function (e) {
            var cuvComponent = $(e.target).data("component-cuv");
            _presenter.showTypesAndTonesModal(cuvComponent);
        });

        $(_elements.tiposTonosModal.btnCerrar.id).click(function (e) {
            _hideTypeAndTonesModal();
        });

        return true;
    };

    var _setTitle = function (title) {
        title = title || "";
        $(_elements.tiposTonosModal.titulo.id).html(title);

        return true;
    };

    
    var _setSelectedQuantityText = function (text) {
        text = text || "";
        $(_elements.tiposTonosModal.cantidadSeleccionados.id).html(text);

        return true;
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

    var _showTypeAndTonesModal = function () {
        return _showModal(_elements.tiposTonosModal.id);
    };

    var _hideTypeAndTonesModal = function () {
        return _hideModal(_elements.tiposTonosModal.id);
    };

    return {
        setPresenter: _setPresenter,
        renderComponente: _renderComponentes,
        setTitle: _setTitle,
        setSelectedQuantityText: _setSelectedQuantityText,
        showTypeAndTonesModal: _showTypeAndTonesModal
    };
};