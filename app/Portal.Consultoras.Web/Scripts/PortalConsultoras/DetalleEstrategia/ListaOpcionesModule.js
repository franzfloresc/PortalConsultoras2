/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
/// <reference path="../../../Scripts/PortalConsultoras/DetalleEstrategia/OpcionesSeleccionadasModule.js" />

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var ListaOpcionesModule = (function () {
    "use strict";

    var _componente = {};
    
    var _elements = {
        listaOpciones: {
            id: "#lista-opciones",
            templateId: "#lista-opciones-template"

        },
        btnAplicarSeleccion: {
            id: "#btn-aplicar-seleccion",
            activeClass: "active",
            disabledClass: "disabled"
        },
        liEligelo : {
            id: "#li-eligelo-"
        },
        btnEligelo: {
            id: "#btn-eligelo-",
            activeClass: "active",
            textElígelo: "Elígelo",
            textElegido:"Elegido"
        },
        liCantidadOpciones : {
            id: "#li-cantidad-opciones-"
        }
    };

    var _moverListaOpcionesOcultarSeleccionados = function() {
        $(_elements.listaOpciones.id).css("padding-top", "0px");
        if (isMobile())
            $(_elements.listaOpciones.id).css("padding-top", "63px");
    };

    var ListarOpciones = function (componente) {
        if (typeof componente === "undefined" ||
            componente === null) throw "param componente is not defined or null";
        //
        _componente = componente;
        _componente.Hermanos = componente.Hermanos || [];
        _componente.cantidadFaltantes = _componente.cantidadFaltantes || _componente.FactorCuadre || 0;
        $.each(_componente.Hermanos,function(index, hermano) {
            hermano.cantidadSeleccionada = hermano.cantidadSeleccionada || 0;
            hermano.cantidadFaltantes = hermano.FactorCuadre || 0;
        });
        _componente.HermanosSeleccionados = componente.HermanosSeleccionados ||[];
        if (_componente.HermanosSeleccionados.length > 0) {
            // TODO : Mejorar validacion
            $(_elements.btnAplicarSeleccion.id)
                .removeClass(_elements.btnAplicarSeleccion.disabledClass)
                .addClass(_elements.btnAplicarSeleccion.activeClass);
        } else {
            _moverListaOpcionesOcultarSeleccionados();
            $(_elements.btnAplicarSeleccion.id)
                .removeClass(_elements.btnAplicarSeleccion.activeClass)
                .addClass(_elements.btnAplicarSeleccion.disabledClass);
        }

        $(_elements.listaOpciones.id).html("");
        SetHandlebars(_elements.listaOpciones.templateId, _componente, _elements.listaOpciones.id);
        setTimeout(function() {
            opcionesEvents.applyChanges("onOptionSelected", _componente);
        }, 200);
        return false;
    };

    var _moverListaOpcionesMostrarSeleccionados = function () {
        if (isMobile())
            $(_elements.listaOpciones.id).css("padding-top", "161px");
    };

    var _actualizarCantidadFaltantes = function() {
        var cantidadTotal = 0;
        $.each(_componente.HermanosSeleccionados, function (index, hermanoSeleccionado) {
            cantidadTotal += hermanoSeleccionado.cantidadSeleccionada;
        });
        _componente.cantidadFaltantes = _componente.FactorCuadre - cantidadTotal;
    };
    
    var SeleccionarOpcion = function (cuv) {
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";
        //
        if (_componente.FactorCuadre === _componente.HermanosSeleccionados.length) {
            return false;
        }
        //
        cuv = $.trim(cuv);
        var opcion = {};
        $.each(_componente.Hermanos, function(index, hermano) {
            if (cuv === hermano.Cuv) {
                opcion = _componente.Hermanos[index];
                opcion.cantidadSeleccionada = opcion.cantidadSeleccionada || 0;
                opcion.cantidadSeleccionada++;
                return false;
            }
        });
        //
        if (typeof opcion === "undefined" || opcion === null) throw "var opcion is not defined or null";
        _componente.HermanosSeleccionados.push(opcion);
        _actualizarCantidadFaltantes();
        _moverListaOpcionesMostrarSeleccionados();
        if (_componente.FactorCuadre === 1) {
            $(_elements.btnEligelo.id + cuv).text(_elements.btnEligelo.textElegido);
            $(_elements.btnEligelo.id + cuv).addClass(_elements.btnEligelo.activeClass);
        }
        if (_componente.FactorCuadre > 1) {
            $(_elements.liEligelo.id + cuv).hide();
            $(_elements.liCantidadOpciones.id + cuv).show();
        }
        if (_componente.FactorCuadre === _componente.HermanosSeleccionados.length) {
            $(_elements.btnAplicarSeleccion.id)
                .removeClass(_elements.btnAplicarSeleccion.disabledClass)
                .addClass(_elements.btnAplicarSeleccion.activeClass);
        }
        //
        opcionesEvents.applyChanges("onOptionSelected", _componente);
        //
        return false;
    };

    var EliminarOpcion = function (cuv) {
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";

        var hermanoSeleccionadoIndex;
        $.each(_componente.HermanosSeleccionados, function (index1, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                hermanoSeleccionadoIndex = index1;
                $.each(_componente.Hermanos, function (index2, item) {
                    if (hermano.Cuv === item.Cuv) {
                        item.cantidadSeleccionada = item.cantidadSeleccionada > 0 ? (item.cantidadSeleccionada - 1) : 0;
                        return false;
                    }
                });
                return false;
            }
        });

        if (typeof hermanoSeleccionadoIndex !== "undefined") {
            _componente.HermanosSeleccionados.splice(hermanoSeleccionadoIndex, 1);
            _moverListaOpcionesOcultarSeleccionados();
            _actualizarCantidadFaltantes();

            opcionesEvents.applyChanges("onOptionSelected", _componente);

            if (_componente.FactorCuadre !== _componente.HermanosSeleccionados.length) {
                $(_elements.btnAplicarSeleccion.id)
                    .removeClass(_elements.btnAplicarSeleccion.activeClass)
                    .addClass(_elements.btnAplicarSeleccion.disabledClass);
            }
        }

        //TODO : Mejorar
        $(_elements.btnEligelo.id + cuv).removeClass(_elements.btnEligelo.activeClass);

        return false;
    }

    var GetComponente = function () {
        return _componente;
    }

    return {
        ListarOpciones: ListarOpciones,
        SeleccionarOpcion: SeleccionarOpcion,
        EliminarOpcion: EliminarOpcion,
        GetComponente: GetComponente
    };
}());

opcionesEvents.subscribe("onComponentSelected", function (componente) {
    ListaOpcionesModule.ListarOpciones(componente);
});