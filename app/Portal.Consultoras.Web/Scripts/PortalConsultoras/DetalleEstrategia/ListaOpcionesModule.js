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
    var _componente = {};
    var _componenteSeleccionados = {
        Hermanos : []
    };
    var _elements = {
        listaOpciones: {
            id: "#lista-opciones",
            templateId: "#lista-opciones-template"

        },
        btnAplicarSeleccion: {
            id: "#btn-aplicar-seleccion",
            activeClass: "activo",
            disabledClass: "disabled"
        },
        btnEligelo : {
            activeClass: "activo"
        }
    };

    var _moverListaOpcionesOcultarSeleccionados = function() {
        $(_elements.listaOpciones.id).css("padding-top", "0px");
        if (isMobile())
            $(_elements.listaOpciones.id).css("padding-top", "63px");
    };

    var _cargarOpciones = function (componente) {
        _componenteSeleccionados = {};
        if (typeof componente === "undefined" ||
            componente === null) throw "param componente is not defined or null";

        _componente = componente;
        _componenteSeleccionados.Hermanos = [];
        //
        _moverListaOpcionesOcultarSeleccionados();
        $(_elements.listaOpciones.id).html("");
        SetHandlebars(_elements.listaOpciones.templateId, _componente, _elements.listaOpciones.id);
        $(_elements.btnAplicarSeleccion.id).addClass(_elements.btnAplicarSeleccion.disabledClass);
        //
        return false;
    };

    var _moverListaOpcionesMostrarSeleccionados = function () {
        if (isMobile())
            $(_elements.listaOpciones.id).css("padding-top", "154px");
    };

    var _seleccionarOpcion = function (event, cuv) {
        if (_componente.FactorCuadre === _componenteSeleccionados.Hermanos.length) {
            return false;
        }
        //
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";
        //
        var opcion = {};
        $.each(_componente.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                opcion = _componente.Hermanos[index];
                $(event.target).addClass(_elements.btnEligelo.activeClass);
                _moverListaOpcionesMostrarSeleccionados();
                return false;
            }
        });
        //
        if (typeof opcion === "undefined" || opcion === null) throw "var opcion is not defined or null";
        _componenteSeleccionados.Hermanos.push(opcion);
        if (_componente.FactorCuadre === _componenteSeleccionados.Hermanos.length) {
            $(_elements.btnAplicarSeleccion.id)
                .removeClass(_elements.btnAplicarSeleccion.disabledClass)
                .addClass(_elements.btnAplicarSeleccion.activeClass);
        }
        //
        opcionesEvents.applyChanges("onOptionSelected", _componenteSeleccionados);
        //
        return false;
    }

    var _eliminarOpcion = function (cuv) {
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";

        var opcion;
        var i = 0;
        $.each(_componenteSeleccionados.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                opcion = _componente.Hermanos[index];
                i = index;
                return false;
            }
        });

        if (typeof opcion !== "undefined" && opcion !== null) {
            _componenteSeleccionados.Hermanos = _componenteSeleccionados.Hermanos || [];
            _componenteSeleccionados.Hermanos.splice(i,1);
            opcionesEvents.applyChanges("onOptionSelected", _componenteSeleccionados);
        }

        return false;

    }

    var _getComponente = function () {
        return _componente;
    }

    return {
        CargarOpciones: _cargarOpciones,
        SeleccionarOpcion: _seleccionarOpcion,
        EliminarOpcion: _eliminarOpcion,
        GetComponente: _getComponente
    };
}());

opcionesEvents.subscribe("onComponentSelected", function (componente) {
    ListaOpcionesModule.CargarOpciones(componente);
});