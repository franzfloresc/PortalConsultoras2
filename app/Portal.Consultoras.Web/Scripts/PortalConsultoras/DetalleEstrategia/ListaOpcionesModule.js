/// <reference path="../../../Scripts/jquery-1.11.2.js" />
/// <reference path="../../../Scripts/General.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/MainLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Bienvenida/Estrategia.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/EstrategiaAccion.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregarProvider.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaAgregar/EstrategiaAgregar.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Estrategia/EstrategiaComponente.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital-DataLayer.js" />
/// <reference path="../../../Scripts/PortalConsultoras/EstrategiaPersonalizada/LocalStorage.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Pedido/barra.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Mobile/Shared/MobileLayout.js" />
/// <reference path="../../../Scripts/PortalConsultoras/TagManager/Home-Pedido.js" />
/// <reference path="../../../Scripts/PortalConsultoras/RevistaDigital/RevistaDigital.js" />
/// <reference path="../../../Scripts/PortalConsultoras/Shared/ConstantesModule.js" />
/// <reference path="../../../Scripts/PortalConsultoras/DetalleEstrategia/OpcionesSeleccionadasModule.js" />
/// <reference path="../../../Scripts/PortalConsultoras/DetalleEstrategia/FichaModule.js" />

var opcionesEvents = opcionesEvents || {};
registerEvent.call(opcionesEvents, "onComponentSelected");

var ListaOpcionesModule = (function () {
    "use strict";

    var _componente = {};
    
    var _elements = {
        contenedorTituloOpciones: {
            id: "#contendor-titulo-opciones"
        },
        contenedorAplicarSeleccion: {
            id: "#contenedor-aplicar-seleccion"
        },
        listaOpciones: {
            id: "#lista-opciones",
            templateId: "#lista-opciones-template",
            height: function () {
                //var heightContenedorTituloOpciones = $(_elements.contenedorTituloOpciones.id).innerHeight();
                //var heightContenedorAplicarSeleccion = $(_elements.contenedorAplicarSeleccion.id).innerHeight();
                return window.innerHeight - 169; //(heightContenedorTituloOpciones + heightContenedorAplicarSeleccion);
            }
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
        },
        divElegirOpciones: {
            id: "#elegir-opciones-modal",
            marginRight: "0",
            opacity: "1",
            modalFondo: {
                id: ".modal-fondo",
                opacity: ".7"
            }

        },
        divContenedorOpcionesSeleccionadas: {
            id: "#contenedor-opciones-seleccionadas"
        }
    };

    var moverListaOpcionesOcultarSeleccionados = function() {
        $(_elements.listaOpciones.id).css("padding-top", "0px");
        if (isMobile()) {
            $(_elements.listaOpciones.id).css("padding-top", "63px");
        } else {
            $(_elements.listaOpciones.id).css("height", _elements.listaOpciones.height());
        }
    };

    var moverListaOpcionesMostrarSeleccionados = function () {
        if (isMobile()) {
            $(_elements.listaOpciones.id).css("padding-top", "161px");
        } else {
            $(_elements.listaOpciones.id).css("height", (_elements.listaOpciones.height() - 96));
        }
    };

    var _actualizarCantidadSeleccionada = function () {
        $.each(_componente.Hermanos, function (index, hermano) {
            hermano.cantidadSeleccionada = 0;
            $.each(_componente.resumenAplicados, function (index2, item) {
                if (hermano.Cuv === item.Cuv) {
                    hermano.cantidadSeleccionada++;
                }
            });
        });
        return false;
    };

    var _actualizarCantidadFaltantes = function () {
        var cantidadTotal = 0;
        $.each(_componente.Hermanos, function (index, hermano) {
            cantidadTotal += hermano.cantidadSeleccionada;
        });
        _componente.cantidadFaltantes = _componente.FactorCuadre - cantidadTotal;
        _componente.mostrarListo =
            typeof _componente.mostrarListo !== "undefined" && _componente.cantidadFaltantes === 0;
    };

    var _inicializarComponenteModel = function (componente) {
        _componente = componente;
        _componente.Hermanos = componente.Hermanos || [];
        _componente.HermanosSeleccionados = componente.HermanosSeleccionados || [];
        _componente.resumenAplicados = componente.resumenAplicados || [];
        _componente.cantidadFaltantes = _componente.cantidadFaltantes || _componente.FactorCuadre || 0;

        $.each(_componente.Hermanos, function (index, hermano) {
            hermano = _componente.Hermanos[index];
            hermano.cantidadSeleccionada = hermano.cantidadSeleccionada || 0;
            hermano.cantidadFaltantes = hermano.FactorCuadre || 0;
            hermano.cantidadAplicada = hermano.cantidadAplicada || 0;
        });
        if (_componente.resumenAplicados.length > 0) {
            _componente.HermanosSeleccionados = jQuery.extend(true, [], _componente.resumenAplicados);
            _actualizarCantidadSeleccionada();
            _actualizarCantidadFaltantes();
            _componente.mostrarListo = false;
        }
    };

    var _renderListaOpciones = function() {
        
        if (_componente.HermanosSeleccionados.length === 0) {
            moverListaOpcionesOcultarSeleccionados();
        } else {
            moverListaOpcionesMostrarSeleccionados();
        }
        //
        $(_elements.listaOpciones.id).html("");
        SetHandlebars(_elements.listaOpciones.templateId, _componente, _elements.listaOpciones.id);
        //
        if (_componente.HermanosSeleccionados.length === _componente.FactorCuadre) {
            $(_elements.btnAplicarSeleccion.id)
                .removeClass(_elements.btnAplicarSeleccion.disabledClass)
                .addClass(_elements.btnAplicarSeleccion.activeClass);
        } else {
            $(_elements.btnAplicarSeleccion.id)
                .removeClass(_elements.btnAplicarSeleccion.activeClass)
                .addClass(_elements.btnAplicarSeleccion.disabledClass);
        }
    };

    var ListarOpciones = function (componente) {
        if (typeof componente === "undefined" ||
            componente === null) throw "param componente is not defined or null";
        //
        _inicializarComponenteModel(componente);
        //
        _renderListaOpciones();
        //
        setTimeout(function() {
            opcionesEvents.applyChanges("onOptionSelected", _componente);
        }, 200);
        //
        return false;
    };

    var _agregarOpcionAComponenteModel = function (cuv) {
        cuv = $.trim(cuv);
        var opcion = {};
        $.each(_componente.Hermanos, function (index, hermano) {
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
        //_componente.HermanosSeleccionados.push(opcion);
        //_componente.HermanosSeleccionados.push(opcion);
        //_componente.HermanosSeleccionados.push(opcion);
        //_componente.HermanosSeleccionados.push(opcion);
        //_componente.HermanosSeleccionados.push(opcion);
        _actualizarCantidadFaltantes();
    };

    var SeleccionarOpcion = function (cuv, event) {
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";
        //
        if (_componente.esCampaniaSiguiente) {
            return false;
        }
        //
        if (_componente.FactorCuadre === _componente.HermanosSeleccionados.length) {
            return false;
        }
        //
        if (typeof event !== "undefined") EstrategiaAgregarModule.AdicionarCantidad(event);
        //
        _agregarOpcionAComponenteModel(cuv);
        //
        _renderListaOpciones();
        //
        opcionesEvents.applyChanges("onOptionSelected", _componente);
        //
        
        var estrategia = fichaModule.GetEstrategia();
        
        if (_componente.FactorCuadre < 2 ) {
            AnalyticsPortalModule.MarcarPopupBotonEligeloSoloUno(estrategia, _componente );
        } else {
            console.log("Complete here the second part");
        }
        
        return false;
    };

    var _eliminarOpcionDeComponenteModel = function (cuv) {
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
            _actualizarCantidadFaltantes();
        }
    };

    var EliminarOpcion = function (cuv, event) {
        
        if (typeof cuv === "undefined" ||
            cuv === null ||
            $.trim(cuv) === "") throw "param componente is not defined or null";
        //
        if (_componente.esCampaniaSiguiente) {
            return false;
        }
        
        var nombreComponente = getNombreComponente(cuv);
        //
        if (typeof event !== "undefined") EstrategiaAgregarModule.DisminuirCantidad(event);
        //
        _eliminarOpcionDeComponenteModel(cuv);
        //
        _renderListaOpciones();
        //
        opcionesEvents.applyChanges("onOptionSelected", _componente);
        //
        //Google Analytics (EPM-1442)
        
        var estrategia = fichaModule.GetEstrategia();
        AnalyticsPortalModule.MarcarEliminarOpcionSeleccionada(estrategia, nombreComponente)
        return false;
    };
    var getNombreComponente = function (cuv) {
        var NombreBulk = "";
        $.each(_componente.HermanosSeleccionados, function (index, item) {
            
            if (item.Cuv === cuv) {
                NombreBulk = item.NombreBulk;
            }
            return false;
        });
        return NombreBulk;
    };

    var GetComponente = function () {
        return _componente;
    };

    var CloseElegirOpcionesModal = function () {
        _componente.HermanosSeleccionados = [];
        if (_componente.resumenAplicados.length == 0) {
            $.each(_componente.Hermanos, function (index, item) {
                item.cantidadSeleccionada = 0;
            });
        }
        if (isMobile()) {
            $(_elements.divElegirOpciones.id).modal("hide");
        } else {
            $(".contenedor_seleccion").css("margin-right", "-320px");
            $(".contenedor_seleccion").css("opacity", "0");
            $(".modal-fondo").css("opacity", "0");
            $(".modal-fondo").hide();
            $("body").removeClass("modal_activado");
        }
        
        var estrategia = fichaModule.GetEstrategia();
        if (_componente.FactorCuadre === 1) {
            AnalyticsPortalModule.MarcarCerrarPopupEligeUnaOpcion(estrategia);
        } else {
            AnalyticsPortalModule.MarcarPopupCerrarEligeXOpciones(estrategia);
        }
        
        
    }

    return {
        ListarOpciones: ListarOpciones,
        SeleccionarOpcion: SeleccionarOpcion,
        EliminarOpcion: EliminarOpcion,
        GetComponente: GetComponente,
        CloseElegirOpcionesModal: CloseElegirOpcionesModal,
        MoverListaOpcionesOcultarSeleccionados: moverListaOpcionesOcultarSeleccionados,
        MoverListaOpcionesMostrarSeleccionados: moverListaOpcionesMostrarSeleccionados
    };
}());

opcionesEvents.subscribe("onComponentSelected", function (componente) {
    ListaOpcionesModule.ListarOpciones(componente);
});

$(document).ready(function () {
    $(window).on('resize', function () {
        var _componente = ListaOpcionesModule.GetComponente() || {};
        if (_componente.HermanosSeleccionados) {
            if (_componente.HermanosSeleccionados.length === 0) {
                ListaOpcionesModule.MoverListaOpcionesOcultarSeleccionados();
            } else {
                ListaOpcionesModule.MoverListaOpcionesMostrarSeleccionados();
            }
        }
    });
});