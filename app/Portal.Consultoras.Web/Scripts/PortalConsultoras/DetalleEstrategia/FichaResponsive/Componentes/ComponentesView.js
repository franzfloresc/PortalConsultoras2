﻿/// <reference path="../../../../jquery-3.3.1.js" />

var ComponentesView = function () {
    var _presenter = null;

    var _elements = {
        componentes: {
            templateId: "#componente-estrategia-template",
            id: "#componentes",
        },
        componente: {
            btnShowModal: {
                all: "[btn-show-types-tones-modal]",
            }
        },
        tiposTonosModal: {
            id: "#popup_tonos",
            btnCerrar: {
                id: "#cerrar-tipos-tonos-modal"
            },
            titulo: {
                id: "[header-title]"
            },
            cantidadSeleccionados: {
                id: "[header-selected-quantity]"
            },
            tiposTonosSeleccionados: {
                templateId: "#tipos-tonos-seleccionados-template",
                id: "#tipos-tonos-seleccionados",
                contenedor: "#contenedor-tipos-tonos-seleccionados",
            },
            tiposTonos: {
                templateId: "#tipos-tonos-componente-template",
                id: "#contenedor-tipos-tonos-componente",
            },
            btnEligelo: {
                id: function (grupo, cuv) {
                    grupo = grupo || "";
                    cuv = cuv || "";
                    if (grupo == "" || cuv == "") return "";

                    return "#btn-eligelo-" + grupo + "-" + cuv;
                },
            },
            selectorCantidad: {
                id: function (grupo, cuv) {
                    grupo = grupo || "";
                    cuv = cuv || "";
                    if (grupo == "" || cuv == "") return "";

                    return "#selector-cantidad-" + grupo + "-" + cuv;
                }
            },
            txtCantidad: {
                id: function (grupo, cuv) {
                    grupo = grupo || "";
                    cuv = cuv || "";
                    if (grupo == "" || cuv == "") return "";

                    return "[txt-cantidad-" + grupo + "-" + cuv + "]";
                }
            },
            agregarTipoTono:{
                all : "[add-type-tone]"
            },
            bloquear:{
                all: "[block-group]"
            }
        }
    };

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _renderComponentes = function (componente) {
        SetHandlebars(_elements.componentes.templateId, componente, _elements.componentes.id);

        $(_elements.componentes.id).on("click", _elements.componente.btnShowModal.all, function (e) {
            e.preventDefault();
            var cuvComponent = $(e.target).data("component-cuv");
            _presenter.showTypesAndTonesModal(cuvComponent);
        });

        $(_elements.tiposTonosModal.btnCerrar.id).click(function (e) {
            e.preventDefault();
            _hideTypeAndTonesModal();
        });

        $(_elements.tiposTonosModal.tiposTonos.id).on("click", _elements.tiposTonosModal.agregarTipoTono.all, function (e) {
            e.preventDefault();
            var grupo = $(e.target).data("grupo");
            var cuv = $(e.target).data("cuv");
            _presenter.addTypeOrTone(grupo, cuv);
        });

        $(window).on('resize', function () {
            // var _componente = ListaOpcionesModule.GetComponente() || {};
            // if (_componente.HermanosSeleccionados) {
            //     if (_componente.HermanosSeleccionados.length === 0) {
            //         ListaOpcionesModule.MoverListaOpcionesOcultarSeleccionados();
            //     } else {
            //         ListaOpcionesModule.MoverListaOpcionesMostrarSeleccionados();
            //     }
            // }
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

    var _showComponentTypesAndTones = function (component) {
        if (typeof component === "undefined" || component === null) return false;

        SetHandlebars(_elements.tiposTonosModal.tiposTonos.templateId,
            component,
            _elements.tiposTonosModal.tiposTonos.id);

        $(_elements.tiposTonosModal.tiposTonos.id).show();

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

    var _showTypesAndTonesModal = function () {
        return _showModal(_elements.tiposTonosModal.id);
    };

    var _hideTypeAndTonesModal = function () {
        return _hideModal(_elements.tiposTonosModal.id);
    };

    var _showQuantitySelector = function (grupo, cuv, cantidad) {
        $(_elements.tiposTonosModal.btnEligelo.id(grupo, cuv)).hide();
        $(_elements.tiposTonosModal.txtCantidad.id(grupo, cuv)).val(cantidad);
        $(_elements.tiposTonosModal.selectorCantidad.id(grupo, cuv)).show();
        return true;
    };

    var _showSelectedTypesOrTones = function (componente) {
        if(typeof componente ==="undefined" || componente === null ) return false;
        $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).slick("unslick");
        SetHandlebars(_elements.tiposTonosModal.tiposTonosSeleccionados.templateId, componente, _elements.tiposTonosModal.tiposTonosSeleccionados.id);
        $(_elements.tiposTonosModal.tiposTonosSeleccionados.contenedor).show();
        $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplaySpeed: 2000,
            fade: false,
            arrows: false,
            infinite: false
        });

        return true;
    };

    var _blockTypesOrTones = function(){
        $(_elements.tiposTonosModal.bloquear.all).addClass("disabled");
        return true;
    };

    var _unblockTypesOrTones = function(){
        $(_elements.tiposTonosModal.bloquear.all).removeClass("disabled");
        return true;
    };

    return {
        setPresenter: _setPresenter,
        renderComponente: _renderComponentes,
        setTitle: _setTitle,
        setSelectedQuantityText: _setSelectedQuantityText,
        showComponentTypesAndTones: _showComponentTypesAndTones,
        showTypesAndTonesModal: _showTypesAndTonesModal,
        showQuantitySelector: _showQuantitySelector,
        showSelectedTypesOrTones: _showSelectedTypesOrTones,
        blockTypesOrTones: _blockTypesOrTones,
        unblockTypesOrTones: _unblockTypesOrTones
    };
};