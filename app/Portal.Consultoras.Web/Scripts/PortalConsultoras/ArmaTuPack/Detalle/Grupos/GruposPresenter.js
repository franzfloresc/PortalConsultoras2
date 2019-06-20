var GruposPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.gruposView === "undefined" || config.gruposView === null) throw "config.gruposView is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.armaTuPackDetalleEvents === "undefined" || config.armaTuPackDetalleEvents === null) throw "config.armaTuPackDetalleEvents is null or undefined";

    var _config = {
        gruposView: config.gruposView,
        armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        armaTuPackDetalleEvents: config.armaTuPackDetalleEvents
    };

    var _packComponentsModel = null;

    var _packComponents = function (value) {
        if (typeof value === "undefined") {
            return _packComponentsModel;
        } else if (value !== null) {
            value.componentesSeleccionados = value.componentesSeleccionados || [];
            value.componentesNoSeleccionados = value.componentesNoSeleccionados || [];
            value.componentes = value.componentes || [];

            $.each(value.componentes, function (idx, grupo) {
                grupo.cantidadSeleccionados = grupo.cantidadSeleccionados || 0;
                grupo.editado = grupo.editado || false;
                if (grupo.mensajeEligeopciones === undefined) {
                    if (grupo.FactorCuadre == 1) {
                        grupo.mensajeEligeopciones = "Elige 1 opción";
                    }
                    else {
                        grupo.mensajeEligeopciones = "Elige " + grupo.FactorCuadre + " opciones";
                    }
                }
                $.each(grupo.Hermanos, function (idxHx, componente) {
                    componente.cantidadSeleccionados = componente.cantidadSeleccionados || 0;
                    componente.editado = componente.editado || false;
                });
            });

            _packComponentsModel = value;
        }
    };

    var _onGruposLoaded = function (packComponents) {
        if (typeof packComponents === "undefined" || packComponents === null) {
            throw "packComponents is null or undefined";
        }

        if (!Array.isArray(packComponents.componentes) || packComponents.componentes.length === 0) {
            throw "packComponents has no components";
        }
        
        _packComponents(packComponents);
        _config.gruposView.renderGrupos(packComponents);
    };

    var _updateGroupView = function (
        cantidadSeleccionadosPorGrupo,
        cantidadSeleccionadosPorComponente,
        factorCuadre,
        codigoGrupo,
        cuvComponente) {
        if (cantidadSeleccionadosPorGrupo == 0) {
            _config.gruposView.showChooseIt(cuvComponente);
            _config.gruposView.showGroupOptions(codigoGrupo);
            _config.gruposView.hideGroupReady(codigoGrupo);
            _config.gruposView.unblockGroup(codigoGrupo);
        }
        else if (cantidadSeleccionadosPorGrupo < factorCuadre) {
            if (cantidadSeleccionadosPorComponente == 0)
                _config.gruposView.showChooseIt(cuvComponente);
            else
                _config.gruposView.showQuantitySelector(cuvComponente, cantidadSeleccionadosPorComponente);
            _config.gruposView.showGroupOptions(codigoGrupo);
            _config.gruposView.hideGroupReady(codigoGrupo);
            _config.gruposView.unblockGroup(codigoGrupo);
        }
        else if (factorCuadre == 1 && cantidadSeleccionadosPorGrupo == factorCuadre) {
            _config.gruposView.showChosen(cuvComponente);
             _config.gruposView.hideGroupOptions(codigoGrupo);
             _config.gruposView.showGroupReady(codigoGrupo);
             _config.gruposView.blockGroup(codigoGrupo,cuvComponente);
             _config.gruposView.removeGroupHighlight(codigoGrupo);
        }
        else if (factorCuadre > 1 && cantidadSeleccionadosPorGrupo == factorCuadre) {
            _config.gruposView.showQuantitySelector(cuvComponente, cantidadSeleccionadosPorComponente);
            _config.gruposView.hideGroupOptions(codigoGrupo);
            _config.gruposView.showGroupReady(codigoGrupo);
            _config.gruposView.blockGroup(codigoGrupo);
            _config.gruposView.removeGroupHighlight(codigoGrupo);
        }
    };

    var _addComponente = function (codigoGrupo, cuvComponente) {
        if (typeof codigoGrupo === "undefined" || codigoGrupo === null) throw "codigoGrupo is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";

        codigoGrupo = $.trim(codigoGrupo);
        cuvComponente = $.trim(cuvComponente);
         
        console.log('analytic_3.2: Elígelo', codigoGrupo, cuvComponente);
        //Analytics ATP Elígelo

        if (!(typeof AnalyticsPortalModule === 'undefined')) {
            var estrategia = JSON.parse($("#data-estrategia").attr("data-estrategia"));
            var codigoubigeoportal = estrategia.CodigoUbigeoPortal + "";
            if (codigoubigeoportal !== "") {
                //var label = $("[data-group-header][data-grupo=" + grupo + "]").find("h3").text();
                AnalyticsPortalModule.MarcaEligeloClickArmaTuPack(codigoubigeoportal, estrategia);
            }
        }
        var model = _packComponents();
        var compSelCounter = model.componentesSeleccionados.length;

        $.each(model.componentes, function (idx, grupo) {
            if (grupo.Grupo == codigoGrupo) {
                $.each(grupo.Hermanos, function (idx, componente) {
                    if (componente.Cuv == cuvComponente && grupo.cantidadSeleccionados < componente.FactorCuadre) {
                        model.componentesSeleccionados.push(componente);
                        model.componentesNoSeleccionados.splice(0, 1);
                        grupo.cantidadSeleccionados++;
                        componente.cantidadSeleccionados++;
                        _updateGroupView(
                            grupo.cantidadSeleccionados,
                            componente.cantidadSeleccionados,
                            grupo.FactorCuadre,
                            codigoGrupo,
                            cuvComponente);
                        return;
                    }
                });
                return;
            }
        });

        if (compSelCounter < model.componentesSeleccionados.length) {
            _packComponents(model);
            _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, model);
        }
    };

    var _deleteComponente = function (codigoGrupo, cuvComponente) {
        if (typeof codigoGrupo === "undefined" || codigoGrupo === null) throw "codigoGrupo is null or undefined";
        if (typeof cuvComponente === "undefined" || cuvComponente === null) throw "cuvComponente is null or undefined";

        var model = _packComponents();
        var componenteSeleccionadoIndex = -1;

        for (var idxComponenteSeleccionado = model.componentesSeleccionados.length - 1; idxComponenteSeleccionado >= 0; idxComponenteSeleccionado--) {
            var componenteSeleccionado = model.componentesSeleccionados[idxComponenteSeleccionado];

            if (componenteSeleccionado.Cuv == cuvComponente) {
                componenteSeleccionadoIndex = idxComponenteSeleccionado;
                break;
            }
        }

        $.each(model.componentes, function (idxGrupo, grupo) {
            if (grupo.Grupo == codigoGrupo) {
                $.each(grupo.Hermanos, function (idxComponente, componente) {
                    if (componente.Cuv == cuvComponente && componente.cantidadSeleccionados > 0) {
                        grupo.cantidadSeleccionados--;
                        componente.cantidadSeleccionados--;
                        _updateGroupView(
                            grupo.cantidadSeleccionados,
                            componente.cantidadSeleccionados,
                            grupo.FactorCuadre,
                            codigoGrupo,
                            cuvComponente);
                        return false;
                    }
                });
                return false;
            }
        });

        if (componenteSeleccionadoIndex != -1) {
            model.componentesSeleccionados.splice(componenteSeleccionadoIndex, 1);
            model.componentesNoSeleccionados.push({ ImagenBulk: "" });
            _packComponents(model);
            _config.armaTuPackDetalleEvents.applyChanges(_config.armaTuPackDetalleEvents.eventName.onSelectedComponentsChanged, model);
        }
    };

    var _onSelectedComponentsChanged = function (packComponents) {
        if (typeof packComponents === "undefined" || packComponents === null) {
            throw "packComponents is null or undefined";
        }

        if (!Array.isArray(packComponents.componentes) || packComponents.componentes.length === 0) {
            throw "packComponents has no components";
        }
        _packComponents(packComponents);

        var model = _packComponents();
        $.each(model.componentes, function (idx, grupo) {
            if (grupo.editado) {
                $.each(grupo.Hermanos, function (idxHx, componente) {
                    if (componente.editado) {
                        _updateGroupView(grupo.cantidadSeleccionados,
                            componente.cantidadSeleccionados,
                            grupo.FactorCuadre,
                            grupo.Grupo,
                            componente.Cuv);
                        grupo.editado = false;
                        componente.editado = false;
                    }
                });
            }
        });
    };

    var _onShowWarnings = function (packComponents) {
        if (typeof packComponents === "undefined" || packComponents === null) {
            throw "packComponents is null or undefined";
        }

        if (!Array.isArray(packComponents.componentes) || packComponents.componentes.length === 0) {
            throw "packComponents has no components";
        }

        _packComponents(packComponents);

        $.each(_packComponents().componentes, function (idxGrupo, grupo) {
            _config.gruposView.uncollapseGroup(grupo.Grupo);
            if (grupo.cantidadSeleccionados < grupo.FactorCuadre)
                _config.gruposView.addGroupHighlight(grupo.Grupo);
            else
                _config.gruposView.removeGroupHighlight(grupo.Grupo);
        });

    };

    return {
        onGruposLoaded: _onGruposLoaded,
        addComponente: _addComponente,
        packComponents: _packComponents,
        deleteComponente: _deleteComponente,
        onSelectedComponentsChanged: _onSelectedComponentsChanged,
        onShowWarnings: _onShowWarnings
    };
};