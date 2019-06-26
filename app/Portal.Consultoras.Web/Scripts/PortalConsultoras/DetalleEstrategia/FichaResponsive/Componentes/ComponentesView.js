/// <reference path="../../../../jquery-3.3.1.js" />

var ComponentesView = function () {
    var _presenter = null;

    var _elements = {
        estrategia: {
            btnAgregar: {
                id: "#btnAgregalo",
                //clase: {
                //    bloqueado: "btn_desactivado_general"
                //}
            }
        },
        componente: {
            templateId: "#componente-estrategia-template",
            id: "#componentes",
            button: {
                clase: ".tono_select_opt"
            },
            btnShowModal: {
                all: "[btn-show-types-tones-modal]",
            },
            resumen: {
                templateId: "#resumen-componente-template",
                id: "#resumen-opciones-{0}"
            },
            tono: {
                cuv: "[data-tono-cuv='{0}']",
                div: "[data-tono-div]",
                cuv2: "[data-tono-cuv]",
                bordeSeleccionado: "borde_seleccion_tono",
                opcionSeleccionada: "opciones-seleccionadas",
                opcionesSeleccionadas: "div[data-opciones-seleccionadas]",
                dataDigitable: "tono-digitable"
            }
        },
        tiposTonosModal: {
            id: "#popup_tonos",
            header : {
                id : "#contenedor-cabecera"
            },
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
            btnElegido: {
                id: function (grupo, cuv) {
                    grupo = grupo || "";
                    cuv = cuv || "";
                    if (grupo == "" || cuv == "") return "";

                    return "#btn-elegido-" + grupo + "-" + cuv;
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
            eliminarTipoTono:{
                all : "[remove-type-tone]"
            },
            bloquear:{
                all: "[block-group]",
                claseHabilitado : "active",
                claseInhabilitado : "btn_deshabilitado",
            },
            aplicarSeleccion : {
                contenedor :"#contenedor-aplicar-seleccion",
                id : "#btn-aplicar-seleccion",
                claseHabilitado : "active",
                claseInhabilitado : "btn_deshabilitado",

            }
        }
    };

    var _setPresenter = function (presenter) {
        _presenter = presenter;
    };

    var _renderComponentes = function (componente) {
        SetHandlebars(_elements.componente.templateId, componente, _elements.componente.id);

        $(_elements.componente.id).on("click", _elements.componente.btnShowModal.all, function (e) {
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

        $(_elements.tiposTonosModal.tiposTonos.id).on("click", _elements.tiposTonosModal.eliminarTipoTono.all, function (e) {
            e.preventDefault();
            var grupo = $(e.target).data("grupo");
            var cuv = $(e.target).data("cuv");
            _presenter.removeTypeOrTone(grupo, cuv);
        });

        $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).on("click", _elements.tiposTonosModal.eliminarTipoTono.all, function (e) {
            e.preventDefault();
            var grupo = $(e.target).data("grupo");
            var cuv = $(e.target).data("cuv");
            var indice = $(e.target).data("indice");
            _presenter.removeTypeOrTone(grupo, cuv, indice);
        });

        $(_elements.tiposTonosModal.id).on("click", _elements.tiposTonosModal.aplicarSeleccion.id, function (e) {
            e.preventDefault();
            var grupo = $(e.target).data("grupo");
            _presenter.applySelectedTypesOrTones(grupo);
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

    var _updateModalHeight = function(){
        var hModal = $(window).outerHeight();
        var hHeader = $(_elements.tiposTonosModal.header.id).outerHeight();
        var hApplyChanges = $(_elements.tiposTonosModal.aplicarSeleccion.contenedor).outerHeight();

        $(_elements.tiposTonosModal.tiposTonos.id).height(hModal - hHeader - hApplyChanges);
    };

    var _showTypesAndTonesModal = function () {
        _showModal(_elements.tiposTonosModal.id);
        _updateModalHeight();
       

        $(window).on("resize", function () {
            _updateModalHeight();
        });

        return true;
    };

    var _hideTypeAndTonesModal = function () {
        _hideModal(_elements.tiposTonosModal.id);
        $(window).off("resize");
        return true;
    };

    var _showQuantitySelector = function (grupo, cuv, cantidad) {
        $(_elements.tiposTonosModal.btnEligelo.id(grupo, cuv)).hide();
        $(_elements.tiposTonosModal.btnElegido.id(grupo, cuv)).hide();
        $(_elements.tiposTonosModal.txtCantidad.id(grupo, cuv)).val(cantidad);
        $(_elements.tiposTonosModal.selectorCantidad.id(grupo, cuv)).show();
        return true;
    };

    var _showChooseIt = function (grupo, cuv) {
        $(_elements.tiposTonosModal.btnEligelo.id(grupo, cuv)).show();
        $(_elements.tiposTonosModal.btnElegido.id(grupo, cuv)).hide();
        $(_elements.tiposTonosModal.selectorCantidad.id(grupo, cuv)).hide();
        return true;
    };

    var _showChoosen = function (grupo, cuv) {
        $(_elements.tiposTonosModal.btnEligelo.id(grupo, cuv)).hide();
        $(_elements.tiposTonosModal.btnElegido.id(grupo, cuv)).show();
        $(_elements.tiposTonosModal.selectorCantidad.id(grupo, cuv)).hide();
        return true;
    };

    var _showSelectedTypesOrTones = function (componente) {
        if(typeof componente ==="undefined" || componente === null ) return false;

        if (componente.HermanosSeleccionados.length > 0) {
            $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).slick("unslick");
            $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).html("");
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
        }else{
            $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).slick("unslick");
            $(_elements.tiposTonosModal.tiposTonosSeleccionados.id).html("");
            $(_elements.tiposTonosModal.tiposTonosSeleccionados.contenedor).hide();
        }

        _updateModalHeight();
        
        return true;
    };

    var _blockTypesOrTones = function(){
        $(_elements.tiposTonosModal.bloquear.all).addClass(_elements.tiposTonosModal.bloquear.claseInhabilitado);
        return true;
    };

    var _unblockTypesOrTones = function(){
        $(_elements.tiposTonosModal.bloquear.all).removeClass(_elements.tiposTonosModal.bloquear.claseInhabilitado);
        return true;
    };

    var _unblockApplySelection = function (grupo) {
        if(typeof grupo ==="undefined" || grupo === null ) return false;

        $(_elements.tiposTonosModal.aplicarSeleccion.id)
            .removeClass(_elements.tiposTonosModal.aplicarSeleccion.claseInhabilitado)
            .addClass(_elements.tiposTonosModal.aplicarSeleccion.claseHabilitado);
        //
        $(_elements.tiposTonosModal.aplicarSeleccion.id).data("grupo", grupo);
        //
        return true;
    };

    var _blockApplySelection = function(){
        $(_elements.tiposTonosModal.aplicarSeleccion.id)
            .removeClass(_elements.tiposTonosModal.aplicarSeleccion.claseHabilitado)
            .addClass(_elements.tiposTonosModal.aplicarSeleccion.claseInhabilitado);
        //
        $(_elements.tiposTonosModal.aplicarSeleccion.id).data("grupo", "");
        //
        return true;
    };

    var _renderResumen = function (componente) {
        var id = _elements.componente.resumen.id.replace("{0}", componente.Cuv);

        SetHandlebars(_elements.componente.resumen.templateId, componente, id);

        $(id).siblings(_elements.componente.button.clase).hide(); // Oculta boton "elige opcion"
        $(id).show();

        $(id)
            .parents(_elements.componente.tono.opcionesSeleccionadas)
            .data(_elements.componente.tono.dataDigitable, componente.FactorCuadre);
            //.parents("[data-opciones-seleccionadas]")
            //.attr("data-opciones-seleccionadas", _componente.FactorCuadre);

        return id;
    };

    var _showBorderItemSelected = function (componente) {
        $(_elements.componente.tono.div).find(_elements.componente.tono.cuv2).removeClass(_elements.componente.tono.bordeSeleccionado);

        $.each(componente.resumenAplicadosVisualizar, function (i, objeto) {
            if(objeto.cantidadAplicada)
                $(_elements.componente.tono.div)
                    .find(_elements.componente.tono.cuv.replace("{0}", objeto.Cuv))
                    .addClass(_elements.componente.tono.bordeSeleccionado);
        });

        return true;
    };

    //var _verifyButtonActive = function () {
    //    var show = true;

    //    $(_elements.componente.tono.opcionesSeleccionadas).each(function () {
    //        if (parseInt($(this).data(_elements.componente.tono.opcionSeleccionada)) === 0 && parseInt($(this).data(_elements.componente.tono.dataDigitable)) === 1)
    //            show = false;
    //    });

    //    // TODO: revisar
    //    if (show)
    //        $(_elements.estrategia.btnAgregar.id).removeClass(_elements.estrategia.btnAgregar.clase.bloqueado);

    //    return true;
    //};

    return {
        setPresenter: _setPresenter,
        renderComponente: _renderComponentes,
        setTitle: _setTitle,
        setSelectedQuantityText: _setSelectedQuantityText,
        showComponentTypesAndTones: _showComponentTypesAndTones,
        showTypesAndTonesModal: _showTypesAndTonesModal,
        hideTypeAndTonesModal: _hideTypeAndTonesModal,
        showChooseIt: _showChooseIt,
        showChoosen: _showChoosen,
        showQuantitySelector: _showQuantitySelector,
        showSelectedTypesOrTones: _showSelectedTypesOrTones,
        blockTypesOrTones: _blockTypesOrTones,
        unblockTypesOrTones: _unblockTypesOrTones,
        unblockApplySelection : _unblockApplySelection,
        blockApplySelection: _blockApplySelection,
        renderResumen: _renderResumen,
        showBorderItemSelected: _showBorderItemSelected,
        //verifyButtonActive: _verifyButtonActive
    };
};