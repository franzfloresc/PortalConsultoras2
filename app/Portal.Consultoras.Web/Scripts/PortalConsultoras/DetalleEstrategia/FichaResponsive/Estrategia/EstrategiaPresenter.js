/// <reference path="../../../shared/constantesmodule.js" />

var EstrategiaPresenter = function (config) {
    if (typeof config === "undefined" || config === null) throw "config is null or undefined";
    if (typeof config.estrategiaView === "undefined" || config.estrategiaView === null) throw "config.estrategiaView is null or undefined";
    if (typeof config.generalModule === "undefined" || config.generalModule === null) throw "config.generalModule is null or undefined";
    if (typeof config.fichaResponsiveEvents === "undefined" || config.fichaResponsiveEvents === null) throw "config.fichaResponsiveEvents is null or undefined";

    var _config = {
        estrategiaView: config.estrategiaView,
        //armaTuPackProvider: config.armaTuPackProvider,
        generalModule: config.generalModule,
        fichaResponsiveEvents: config.fichaResponsiveEvents
    };
    var _elements = {
        //divMensajeBloqueada: "#divMensajeBloqueada",
        //divHVMensajeBloqueada: "#divHVMensajeBloqueada",
        //divVistaPrevia: "#divVistaPrevia",
        //hdErrorInsertarProducto: "#hdErrorInsertarProducto",
        hdCampaniaCodigo: "#hdCampaniaCodigo",
        EstrategiaHdMarcaID: "#Estrategia_hd_MarcaID",
        EstrategiaHdPrecioCatalogo: "#Estrategia_hd_PrecioCatalogo",
        Estrategia_hd_Digitable: "#Estrategia_hd_Digitable",
        Estrategia_hd_Grupo: "#Estrategia_hd_Grupo",
        OfertaTipoNuevo: "#OfertaTipoNuevo"
    };
    var dataProperties = {
        dataItem: "[data-item]",
        //dataContenedorCantidad: "[data-cantidad-contenedor]",
        dataInputCantidad: "[data-input='cantidad']",
        //dataEstrategia: "[data-estrategia]",
        dataOrigenPedidoWeb: "[data-OrigenPedidoWeb]",
        dataBloqueada: "data-bloqueada",
        //dataItemTagBody: "[data-item-tag=\"body\"]",
        //dataItemTagAgregar: "[data-item-tag=\"agregar\"]",
        //dataItemTagFondo: "[data-item-tag=\"fotofondo\"]",
        //dataItemTagVerDetalle: "[data-item-tag=\"verdetalle\"]",
        //dataItemAccionVerDetalle: "[data-item-accion=\"verdetalle\"]",
        //dataItemTagContenido: "[data-item-tag=\"contenido\"]",
        dataTono: "[data-tono]",
        dataTonoSelect: "[data-tono-select]",
        dataItemHtml: "[data-item-html]",
        tooltip: "[data-agregado=\"tooltip\"]",
        tooltipMensaje1: "[data-agregado=\"mensaje1\"]",
        tooltipMensaje2: "[data-agregado=\"mensaje2\"]",
    };
    var _OrigenPedido = {
        MobileContenedorArmaTuPack: ConstantesModule.OrigenPedidoWeb.MobileArmaTuPackFicha,
        DesktopContenedorArmaTuPack: ConstantesModule.OrigenPedidoWeb.DesktopArmaTuPackFicha
    }
    // TODO: validar solo se usa en EstrategiaAgregar
    var elementosPopPup = {
        popupClose: "#popup-close"
    };

    var _estrategiaInstance = null;
    var _estrategiaModel = function (value) {
        if (typeof value === "undefined") {
            return _estrategiaInstance;
        } else if (value !== null) {
            value.isMobile = isMobile();

            _estrategiaInstance = value;
        }
    };

    var _onEstrategiaModelLoaded = function (estrategiaModel) {
        if (typeof estrategiaModel === "undefined" || estrategiaModel === null) throw "estrategiaModel is null or undefined";

        _estrategiaModel(estrategiaModel);

        var model = _estrategiaModel();

        if (!_config.estrategiaView.renderBreadcrumbs(model) ||
            !_config.estrategiaView.renderEstrategia(model)) throw "estrategiaView do not render model";

        if (model.CodigoEstrategia == ConstantesModule.TipoEstrategia.Lanzamiento &&
            !_config.estrategiaView.renderBackgroundAndStamp(model)) 
            throw "estrategiaView do not render background and stamp";

        if (model.TieneReloj &&
            !_config.estrategiaView.renderReloj(model)) throw "estrategiaView don't render reloj.";

        if (model.TieneReloj &&
            !_config.estrategiaView.renderRelojStyle(model)) throw "estrategiaView don't render style of reloj.";

        if (!_config.estrategiaView.renderAgregar(model)) throw "estrategiaView don't render agregar.";

        if (!_config.estrategiaView.showTitleAgregado(model)) throw "estrategiaView don't show title Agregado.";

        return true;
    };

    //#region TODO: Refactorizar, metodo vieje de EstrategiaAgregar.js
    var estrategiaObtenerObjHtmlLanding = function ($btnAgregar) {
        var itemClone = $btnAgregar.parents(dataProperties.dataItem);
        var cuvClone = $.trim(itemClone.attr("data-clone-item"));

        if (cuvClone != "") {
            // TODO: consultar donde aplica, se revisa y solo muestra CampaniaID
            itemClone = $("body").find("[data-content-item='" + $.trim(itemClone.attr("data-clone-content")) + "']")
                .find("[data-item='" + cuvClone + "']");
        }
        if (itemClone.length === 0 && cuvClone != "") {
            // TODO: [data-item] tambien se muestra en los carruseles ¿?
            itemClone = $("body").find("[data-item='" + cuvClone + "']");
        }
        if (itemClone.length > 1) {
            itemClone = $(itemClone.get(0));
        }

        return itemClone;
    };
    var getOrigenPedidoWeb = function ($btnAgregar, esUrl) {
        var origenPedidoWeb = (esUrl) ? $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidoweb") : ($btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidowebagregar") || $btnAgregar.parents(dataProperties.dataOrigenPedidoWeb).data("origenpedidoweb"));
        origenPedidoWeb = origenPedidoWeb || 0;
        return origenPedidoWeb.toString();
    };
    var estrategiaEstaBloqueada = function ($btnAgregar, campaniaId) {
        if ($btnAgregar.attr(dataProperties.dataBloqueada) === "") return false;
        if (campaniaId === parseInt(_config.CampaniaCodigo)) return false;

        return true;
    };
    var DivMsgBloqueadoBuilder = function ($btnAgregar, estrategia) {
        var $btnAgregarTmp = $btnAgregar;
        var $divMsgProductoBloqueado = null;
        var dataItemHtml = null;
        //var estrategiaTmp = estrategia;
        return {
            getDivMsgProductoBloqueado: function () {
                $divMsgProductoBloqueado = $(elementosDiv.divMensajeBloqueada);

                return this;
            },
            getHtmlProductoBloqueado: function () {
                var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregarTmp);
                dataItemHtml = $divMsgProductoBloqueado.find(dataProperties.dataItemHtml);

                if (!_config.esFicha)
                    dataItemHtml.html(itemClone.html());

                return this;
            },
            formatDivMsgProductoBloqueado: function () {
                dataItemHtml.find(dataProperties.dataItemTagBody).removeAttr("data-estrategia");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("min-height", "auto");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("float", "none");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("margin", "0 auto");
                dataItemHtml.find(dataProperties.dataItemTagBody).css("background-color", "#fff");
                dataItemHtml.find(dataProperties.dataItemTagBody).attr("class", "");
                dataItemHtml.find(dataProperties.dataItemTagAgregar).remove();
                dataItemHtml.find(dataProperties.dataItemTagFondo).remove();
                dataItemHtml.find(dataProperties.dataItemTagVerDetalle).remove();
                dataItemHtml.find(dataProperties.dataItemAccionVerDetalle).remove();
                dataItemHtml.find(dataProperties.dataItemTagContenido).removeAttr("onclick");
                dataItemHtml.find(dataProperties.dataItemTagContenido).css("position", "initial");
                dataItemHtml.find(dataProperties.dataItemTagContenido).attr("class", "");

                return this;
            },
            build: function () {
                return $divMsgProductoBloqueado;
            }
        };
    };
    var getDivMsgBloqueado = function ($btnAgregar, estrategia) {
        var divMsgBloqueadoBuilder = new DivMsgBloqueadoBuilder($btnAgregar, estrategia);
        return divMsgBloqueadoBuilder
            .getDivMsgProductoBloqueado()
            .getHtmlProductoBloqueado()
            .formatDivMsgProductoBloqueado()
            .build();
    };
    var sendAnalyticAgregarProductoDeshabilitado = function (estrategia, isPopup) {
        try {
            isPopup = isPopup || false;
            if (typeof popup != "undefined") {
                isPopup = popup;
            }

            var name = $.trim(estrategia.DescripcionResumen + " " + estrategia.DescripcionCortada);
            rdAnalyticsModule.AgregarProductoDeshabilitado(
                estrategia.OrigenPedidoWebEstrategia,
                estrategia.CampaniaID,
                name,
                isPopup);
        } catch (e) {
            console.log(e);
        }
    };
    var _ValidarSeleccionTono = function (objInput, esFicha) {
        var attrClass = $.trim($(objInput).attr("class"));
        if ((" " + attrClass + " ").indexOf(" btn_desactivado_general ") >= 0) {

            var $SelectTonos = $(objInput).parents("[data-item]").find("[data-opciones-seleccionadas='0']").find("[data-tono-change='1']");
            var $SeleccionTonoToolTip = $("[data-selecciontono='tooltip']");

            if (isMobile()) {
                if (esFicha) {
                    if ($SelectTonos.length > 0) {
                        var $PrimerElemento = $SelectTonos[0];
                        var Altura = $($PrimerElemento).offset().top - 200;
                        window.scrollTo(0, Altura);
                    }
                }
            }

            if (esFicha) {
                $SeleccionTonoToolTip.show();
                setTimeout(function () { $SeleccionTonoToolTip.hide(); }, 2000);
            }

            $SelectTonos.removeClass("texto_sin_tono").addClass("variedad_sin_seleccionar");
            setTimeout(
                function () {
                    $SelectTonos.removeClass("variedad_sin_seleccionar").addClass("texto_sin_tono");
                }, 1000);
            return true;
        }
        return false;
    }
    var abrirMensajeEstrategia = function (txt, esFicha) {
        var tipoOrigenEstrategiaAux = 0;
        if (typeof tipoOrigenEstrategia != "undefined") {
            tipoOrigenEstrategiaAux = tipoOrigenEstrategia;
        }

        if (tipoOrigenEstrategiaAux == 1) {
            alert_msg_pedido(txt);
        } else if (tipoOrigenEstrategiaAux == 11 || tipoOrigenEstrategiaAux == 17 || tipoOrigenEstrategiaAux == 172) {
            alert_msg(txt);
        } else if (tipoOrigenEstrategiaAux == 2 || tipoOrigenEstrategiaAux == 21 || tipoOrigenEstrategiaAux == 262) {
            // TODO: revisar codigo no existe metodo
            messageInfo(txt);
        } else if (txt.indexOf("cantidad limite") > 0) {
            if (esFicha) {
                var $limitePedidoToolTip = $('[data-limitepedido="tooltip"]');
                if ($limitePedidoToolTip.length > 0) {
                    $limitePedidoToolTip.show();
                    setTimeout(function () { $limitePedidoToolTip.hide(); }, 2000);
                }
            } else {
                if (isMobile()) {
                    messageInfo(txt);
                } else {
                    alert_msg(txt);
                }
            }
        } else if (isMobile()) {
            messageInfo(txt);
        } else {
            alert_msg(txt);
        }
    };
    var _getClienteIdSelected = function () {
        var clientId = 0;

        var $divFichaReumida = $('#DivPopupFichaResumida');
        if (typeof $divFichaReumida !== "undefined" || $divFichaReumida !== null) {
            if ($divFichaReumida.find("#hfClienteId").length > 0) {
                clientId = $($divFichaReumida.find("#hfClienteId")[0]).val();
            }
        }

        return clientId;
    }
    //#endregion

    var _onEstrategiaModelClick = function (event, popup, limite, esFicha, esEditable) {
        // TODO: validar el porque el codigo de variante es diferente en la ficha regular y responsive @victor.vilela

        popup = popup || false;
        limite = limite || 0;
        esEditable = esEditable || false;
        _config.esFicha = esFicha || _config.esFicha;
        _config.CampaniaCodigo = $(_elements.hdCampaniaCodigo).val() || _config.CampaniaCodigo;

        var $btnAgregar = $(event.target);

        var origenPedidoWebEstrategia = getOrigenPedidoWeb($btnAgregar);

        //#region Analytics
        if (AnalyticsPortalModule != 'undefined') {
            var estrategiaAnalytics;
            if (typeof (fichaModule) != "undefined") {
                if (typeof (fichaModule.GetEstrategia) != "undefined") {
                    estrategiaAnalytics = fichaModule.GetEstrategia();
                    var objChangeFicha = fichaModule.GetChangeFichaAnalytics();
                    AnalyticsPortalModule.MarcaFichaResumidaClickModificar(estrategiaAnalytics.CodigoUbigeoPortal, objChangeFicha.isChangeTono, objChangeFicha.isChangeCantidad, objChangeFicha.isChangeCliente);
                }
            }

            // TODO: se implementa con tipos y tonos
            //if (typeof (seleccionadosPresenter) !== 'undefined') {
            //    if (seleccionadosPresenter.packComponents() !== 'undefined') {
            //        var seleccionados = seleccionadosPresenter.packComponents().componentesSeleccionados;
            //        estrategiaAnalytics = _estrategiaInstance;
            //        var codigoubigeoportal = estrategiaAnalytics.CodigoUbigeoPortal;

            //        if (codigoubigeoportal !== "") {
            //            AnalyticsPortalModule.MarcarAddCarArmaTuPack(codigoubigeoportal, seleccionados);
            //            AnalyticsPortalModule.MarcaClickAgregarArmaTuPack(codigoubigeoportal, "Agregar", "Click Botón");
            //        }
            //    }
            //}
        }
        //#endregion

        // TODO: por validar con EstrategiaUrls, alan lo esta pasando modular
        if (typeof getOrigenPedidoWebDetalle !== 'undefined') {
            var origenDetalle = getOrigenPedidoWebDetalle(_estrategiaInstance);
            if (origenDetalle) {
                origenPedidoWebEstrategia = origenDetalle;
            }
        }

        // TODO: revisar logica
        if (estrategiaEstaBloqueada($btnAgregar, _estrategiaInstance.CampaniaID)) {
            _estrategiaInstance.OrigenPedidoWebEstrategia = origenPedidoWebEstrategia;

            //console.log(_estrategiaInstance.OrigenPedidoWebEstrategia);
            //getDivMsgBloqueado($btnAgregar, _estrategiaInstance).show();
            //sendAnalyticAgregarProductoDeshabilitado(_estrategiaInstance, popup);
            return false;
        }

        // TODO: revisar logica
        if (_ValidarSeleccionTono($btnAgregar, _config.esFicha)) {
            return false;
        }

        var cantidad = (limite > 0) ? limite : ($btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val());

        if (!$.isNumeric(cantidad)) {
            abrirMensajeEstrategia("Ingrese un valor numérico.", _config.esFicha);
            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");
            CerrarLoad();
            return false;
        }
        if (parseInt(cantidad) <= 0) {
            abrirMensajeEstrategia("La cantidad debe ser mayor a cero.", _config.esFicha);
            $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");
            CerrarLoad();
            return false;
        }

        _estrategiaInstance.Cantidad = cantidad;

        if (!isMobile()) {
            _estrategiaInstance.FlagNueva = _estrategiaInstance.FlagNueva == "1" ? _estrategiaInstance.FlagNueva : "";

            // TODO: elemento no existe, solo en Pedido\Index.cshtml, validar con @alan.aurora
            $(_elements.OfertaTipoNuevo).val(_estrategiaInstance.FlagNueva);
        }

        // TODO: @renzo.aguilar revisa la experiencia del cargando
        AbrirLoad();

        var itemClone = estrategiaObtenerObjHtmlLanding($btnAgregar);

        // TODO: revisar con @alan
        if (isPagina("ofertas") && !isMobile()) {
            var estratediaId = itemClone.data("item");
            if (estratediaId != "") {
                itemClone = itemClone.parent().find("[data-item=" + estratediaId + "]");
            }
        }

        // TODO: validar para que sirve, (referencia a OPT, template-producto-landings)
        var divAgregado = $(itemClone).find(".agregado.product-add");

        var cuvs = "";
        var codigoVariante = _estrategiaInstance.CodigoVariante;

        // TODO: revisar cuando componentes este implementado
        if ((ConstantesModule.CodigoVariedad.IndividualVariable == codigoVariante || ConstantesModule.CodigoVariedad.CompuestaVariable == codigoVariante)) {
            var listaCuvs = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataTono.concat(dataProperties.dataTonoSelect));
            if (listaCuvs.length > 0) {
                $.each(listaCuvs, function (i, item) {
                    var cuv = $(item).attr("data-tono-select");
                    if (cuv != "") {
                        cuvs = cuvs + (cuvs == "" ? "" : "|") + cuv;

                        cuvs = cuvs + ";" + $(item).find(_elements.EstrategiaHdMarcaID).val();
                        cuvs = cuvs + ";" + $(item).find(_elements.EstrategiaHdPrecioCatalogo).val();
                        cuvs = cuvs + ";" + "";
                        cuvs = cuvs + ";" + $(item).find(_elements.Estrategia_hd_Digitable).val();
                        cuvs = cuvs + ";" + $(item).find(_elements.Estrategia_hd_Grupo).val();
                    }
                });
            }
        }

        // TODO: consultar con @kevin.chiguan, arroja indefinido, se revisa el atributo y este solo se implementa en los carruseles no en la ficha.
        var tipoEstrategiaImagen = $btnAgregar.parents(dataProperties.dataItem).attr("data-tipoestrategiaimagenmostrar");

        var params = {
            CuvTonos: $.trim(cuvs),
            CUV: $.trim(_estrategiaInstance.CUV2),
            Cantidad: $.trim(cantidad),
            TipoEstrategiaID: _estrategiaInstance.TipoEstrategiaID,
            EstrategiaID: $.trim(_estrategiaInstance.EstrategiaID),
            OrigenPedidoWeb: $.trim(origenPedidoWebEstrategia),
            TipoEstrategiaImagen: tipoEstrategiaImagen || 0,
            FlagNueva: $.trim(_estrategiaInstance.FlagNueva),
            EsEditable: _estrategiaInstance.EsEditable,
            SetId: _estrategiaInstance.SetId || 0,
            ClienteID: _getClienteIdSelected()
        };

        console.log(params);
        console.log(_estrategiaInstance);

        EstrategiaAgregarProvider
            .pedidoAgregarProductoPromise(params)
            .done(function (data) {
                //#region TODO: quitar linea de codigo
                params.EsEditable = true;
                data.success = true;
                //#endregion

                if (!checkTimeout(data)) {
                    CerrarLoad();
                    return false;
                }
                if (data.success === false) {
                    if (!IsNullOrEmpty(data.mensajeAviso)) {
                        AbrirMensaje(data.mensajeAviso, data.tituloMensaje);
                    } else {
                        var msjBloq = validarpopupBloqueada(data.message);
                        if (msjBloq != "") alert_msg_bloqueadas(msjBloq);
                        else abrirMensajeEstrategia(data.message, _config.esFicha);
                    }

                    CerrarLoad();
                    return false;
                }

                var cuv = _estrategiaInstance.CUV2;

                if (cuv.substring(0, 3) == '999') {
                    sessionStorage.setItem('cuvPack', cuv);
                }

                //#region Analytics
                try {
                    if (!(typeof AnalyticsPortalModule === 'undefined')) {
                        AnalyticsPortalModule.MarcaAnadirCarritoGenerico(event, origenPedidoWebEstrategia, _estrategiaInstance);
                    }
                    TrackingJetloreAdd(cantidad, $(_elements.hdCampaniaCodigo).val(), cuv);
                } catch (e) {
                    console.log(e);
                }
                //#endregion

                $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataInputCantidad).val("1");

                // TODO: validar, con referencia a linea superior
                if (divAgregado != null) {
                    if (typeof divAgregado.length != "undefined" && divAgregado.length > 0) {
                        divAgregado.each(function (index, element) {
                            $(element).show();
                        });
                    }

                    $(divAgregado).show();

                    if ($btnAgregar[0]) {
                        var contenedorAgregado = $($btnAgregar).parent().find('#ContenedorAgregado')[0];

                        if (!contenedorAgregado) {
                            contenedorAgregado = $($btnAgregar).parent().parent().find('.contenedor_agregado');
                        }


                        if (contenedorAgregado) {
                            $(contenedorAgregado).show();
                        }
                    }
                }

                // TODO: validar FlagNueva de la estrategia, devuelve vacia
                //#region Muestra Tooltip, refirecciona a ofertas y/o arma tu pack, valida origen pedido
                var esFichaT = ((_estrategiaInstance.FlagNueva == 1 ? true : false) && IsNullOrEmpty(data.mensajeAviso)) || _config.esFicha;

                if (esFichaT) {
                    try {
                        var $AgregadoTooltip = $(dataProperties.tooltip);

                        if (params.EsEditable) {
                            $AgregadoTooltip.find(dataProperties.tooltipMensaje1).html("¡Listo! ");
                            $AgregadoTooltip.find(dataProperties.tooltipMensaje2).html(" Modificaste tu pedido juanjo");
                        }

                        $AgregadoTooltip.show();

                        setTimeout(function () {
                            $AgregadoTooltip.hide();

                            if (typeof esAppMobile == 'undefined') {
                                if (origenPedidoWebEstrategia === _OrigenPedido.DesktopContenedorArmaTuPack) {
                                    window.location = "/ofertas";
                                } else if (origenPedidoWebEstrategia === _OrigenPedido.MobileContenedorArmaTuPack) {
                                    window.location = "/mobile/ofertas";

                                }
                            } else {
                                if (_estrategiaInstance.CodigoEstrategia === ConstantesModule.TipoEstrategia.ArmaTuPack) {
                                    window.location = "/ArmaTuPack/AgregarATPApp";
                                }
                            }
                        }, ConstantesModule.Tiempo.ToolTip);

                        if (!(origenPedidoWebEstrategia === _OrigenPedido.DesktopContenedorArmaTuPack || origenPedidoWebEstrategia === _OrigenPedido.MobileContenedorArmaTuPack)) {
                            if (typeof ResumenOpcionesModule != 'undefined') {
                                // TODO: validar metodo, hace referencia a pagina de pedido
                                ResumenOpcionesModule.LimpiarOpciones();
                            }
                        }
                        else {
                            return;
                        }
                    } catch (e) {
                        console.error(e);
                    }
                }
                //#endregion

                //#region MostrarBarra solo para: 1=bienvenido , 2=pedido
                var barraJsLoaded = typeof MostrarBarra === 'function';

                if (barraJsLoaded) {
                    var destino = isPagina('pedido') ? '2' : '1';
                    var prevTotal = mtoLogroBarra || 0;
                    var issetPopupPremio = $("#popupPremio").length > 0;

                    if ($("#divBarra").length > 0) {
                        MostrarBarra(data, destino);

                        if (issetPopupPremio) {
                            showPopupNivelSuperado(data.DataBarra, prevTotal);
                        } else {
                            addPremioDefaultSuperado(data.DataBarra, prevTotal);
                        }
                    } else {
                        ActualizarGanancia(data.DataBarra);
                        calcMtoLogro(data, destino);
                        addPremioDefaultSuperado(data.DataBarra, prevTotal);
                    }
                }
                //#endregion

                //#region TODO: validar metodos estos se encuentran solo en el layout principal no responsive
                if (isMobile()) {
                    CargarCantidadProductosPedidos(true);
                    microefectoPedidoGuardado();
                } else {
                    CargarResumenCampaniaHeader(true);
                }
                //#endregion

                //#region TODO: validar "tipoOrigenEstrategia", estos se declaran en pedido, bienvenida y etc
                var tipoOrigenEstrategiaAux = 0;
                if (typeof tipoOrigenEstrategia != "undefined") {
                    tipoOrigenEstrategiaAux = tipoOrigenEstrategia || 0;
                }

                if (tipoOrigenEstrategiaAux == 1)
                {
                    if (typeof MostrarBarra != constantes.undefined()) {
                        MostrarBarra(data, "1");
                    }

                    if (_estrategiaInstance.CodigoEstrategia == ConstantesModule.TipoEstrategia.PackNuevas) {
                        if (typeof CargarCarouselEstrategias != constantes.undefined())
                            CargarCarouselEstrategias();
                    }

                    if (typeof tieneMasVendidos != constantes.undefined()) {
                        if (tieneMasVendidos === 1) {
                            if (typeof CargarCarouselMasVendidos != constantes.undefined())
                                CargarCarouselMasVendidos("desktop");
                        }
                    }
                }
                else if (tipoOrigenEstrategiaAux == 11)
                {

                    $(elementosDiv.hdErrorInsertarProducto).val(data.errorInsertarProducto);

                    cierreCarouselEstrategias();
                    if (_estrategiaInstance.CodigoEstrategia == ConstantesModule.TipoEstrategia.PackNuevas) {
                        if (typeof CargarCarouselEstrategias != constantes.undefined())
                            CargarCarouselEstrategias();
                    }
                    HideDialog(elementosDiv.divVistaPrevia.substring(1));
                    CargarDetallePedido();
                    var previousTotal = mtoLogroBarra || 0;
                    MostrarBarra(data);
                    showPopupNivelSuperado(data.DataBarra, previousTotal);
                }
                else if (tipoOrigenEstrategiaAux == 2 ||
                    tipoOrigenEstrategiaAux == 21 ||
                    tipoOrigenEstrategiaAux == 22 ||
                    tipoOrigenEstrategiaAux == 27 ||
                    tipoOrigenEstrategiaAux == 262 ||
                    tipoOrigenEstrategiaAux == 272)
                {

                    if (isPagina('mobile/pedido/detalle')) CargarPedido(false);

                    if (tipoOrigenEstrategiaAux == 262) {

                        var origenRetornoAux = $.trim(origenRetorno);
                        if (origenRetornoAux != "") {
                            setTimeout(function () {
                                window.location = origenRetornoAux;
                            },
                                3700);

                        }
                    } else if (tipoOrigenEstrategiaAux != 272) {
                        if (_estrategiaInstance.CodigoEstrategia == ConstantesModule.TipoEstrategia.PackNuevas) {
                            CargarCarouselEstrategias();
                        }

                        if (typeof tieneMasVendidos !== "undefined" && tieneMasVendidos === 1) {
                            CargarCarouselMasVendidos("mobile");
                        }
                    }
                }
                //#endregion

                // TODO: validar con tipos y tonos de @victor.vilela
                if (data.listCuvEliminar != null) {
                    $.each(data.listCuvEliminar, function (i, cuvElem) {
                        itemClone.parent().find('[data-item-cuv=' + cuvElem + '] .agregado.product-add').hide();
                        ActualizarLocalStoragePalancas(cuvElem, false);
                    })
                }

                // TODO: validar campo CodigoPalanca, llega vacio para ficha regular y responsive
                var localStorageModule = new LocalStorageModule();
                localStorageModule.ActualizarCheckAgregado($.trim(_estrategiaInstance.EstrategiaID), _estrategiaInstance.CampaniaID, _estrategiaInstance.CodigoPalanca, true);

                CerrarLoad();

                if (popup)
                {
                    // TODO: validar popupDetalleCarouselLanzamiento y popupDetalleCarouselPackNuevas, no existe en el proyecto
                    CerrarPopup(elementosPopPup.popupDetalleCarouselLanzamiento);
                    $(elementosPopPup.popupDetalleCarouselPackNuevas).hide();
                }
                else
                {
                    if (_config.esFicha)
                    {
                        // TODO: validar con tipos y tonos de @victor.vilela
                        if (params.CuvTonos != "")
                        {
                            var listaCuvs = $btnAgregar.parents(dataProperties.dataItem).find(dataProperties.dataTono.concat(dataProperties.dataTonoSelect));

                            if (listaCuvs.length > 0) {
                                $(".texto_sin_tono").find(".tono_seleccionado").hide();
                                var $ContentTonoDetalle = $(".content_tono_detalle");
                                if ($ContentTonoDetalle.length > 0) {
                                    $ContentTonoDetalle.removeClass("borde_seleccion_tono");
                                }
                                $btnAgregar.addClass("btn_desactivado_general");

                                $.each(listaCuvs,
                                    function (i, item) {
                                        if (!(item.hasAttribute('data-tono-digitable')))
                                            $(item).attr("data-tono-select", "");
                                    });
                            }

                        }
                    }
                }
                if (!IsNullOrEmpty(data.mensajeAviso)) AbrirMensaje(data.mensajeAviso, data.tituloMensaje);
                if (_estrategiaInstance.TipoAccionNavegar == ConstantesModule.TipoAccionNavegar.Volver) {
                    FichaPartialModule.ShowDivFichaResumida(false);
                }

                return false;
            })
            .fail(function (data, error) {
                CerrarLoad();
            });

        return false;
    };

    return {
        onEstrategiaModelLoaded: _onEstrategiaModelLoaded,
        onEstrategiaModelClick: _onEstrategiaModelClick
    };
};