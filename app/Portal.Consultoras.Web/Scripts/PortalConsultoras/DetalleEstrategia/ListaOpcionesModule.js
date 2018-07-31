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

    var _cargarOpciones = function(componente) {
        if (typeof componente === "undefined" ||
            componente === null) throw "param componente is not defined or null";

        _componente = componente;
        $("#lista-opciones").css("padding-top","63px");
        $("#lista-opciones").html();
        SetHandlebars("#lista-opciones-template", _componente, "#lista-opciones");
       
        return false;
    };

    var _seleccionarOpcion = function (event, cuv) {
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";

        if (_componente.FactorCuadre === OpcionesSeleccionadasModule.GetCantidadOpcionesSeleccionadas()) return false;

        var opcion;
        $.each(_componente.Hermanos, function (index, hermano) {
            cuv = $.trim(cuv);
            if (cuv === hermano.Cuv) {
                opcion = _componente.Hermanos[index];
                $(event.target).addClass("activo");
                $("#lista-opciones").css("padding-top", "154px");
                return false;
            }
        });

        if (typeof opcion !== "undefined" && opcion !== null) {
            opcionesEvents.applyChanges("onOptionSelected", opcion);
        }

        return false;
    }

    return {
        CargarOpciones: _cargarOpciones,
        SeleccionarOpcion : _seleccionarOpcion
    };
}());
opcionesEvents.subscribe("onComponentSelected", function (componente) {
    ListaOpcionesModule.CargarOpciones(componente);
});