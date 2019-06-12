var misReclamos;

$(document).ready((function (cerrarRechazado) {
    return function () {
        'use strict';
        var PortalConsultorasReclamos;
        PortalConsultorasReclamos = function () {
            var me = this;
            me.Variables = {
                IrPaso1: '#IrPaso1',
                btnActualizarSolicitud: "#btnActualizarSolicitud",
                VerDetalleCDR: ".abrir_detallemb",
                cdrweb_id: ".cdrweb_id",
                registro_solicitud_cdr: ".registro_solicitud_cdr",
                cdrweb_pedidoid: ".cdrweb_pedidoid",
                cdrweb_estado: ".cdrweb_estado",
                cdrweb_formatoFechaCulminado: ".cdrweb_formatoFechaCulminado",
                cdrweb_formatocampania: ".cdrweb_formatocampania",
                cdrweb_CantidadAprobados: ".cdrweb_CantidadAprobados",
                cdrweb_CantidadRechazados: ".cdrweb_CantidadRechazados",
                footer_page: ".footer-page",
                OrdenarSolicitudesRegistradasPor: "#OrdenarSolicitudesRegistradasPor"
            };
            me.Eventos = {
                bindEvents: function () {
                    $(me.Variables.footer_page).hide();
                    $(document).on('click', me.Variables.IrPaso1, function () {
                        if (mensajeGestionCdrInhabilitada != '') {
                            $('#popupInformacionSB2Error').find('#mensajeInformacionSB2_Error').html(mensajeGestionCdrInhabilitada);
                            $('#popupInformacionSB2Error').show();
                            return false;
                        }
                        window.location.href = urlReclamo;
                    });

                    $(document).on("click", me.Variables.VerDetalleCDR, function () {
                        var elemento = $(this);
                        var _OrigenDetalle = "1";
                        var _CDRWebID = $(elemento).find(me.Variables.cdrweb_id).val();
                        var _PedidoID = $(elemento).find(me.Variables.cdrweb_pedidoid).val();
                        var _Estado = $(elemento).find(me.Variables.cdrweb_estado).val();
                        var _FechaCulminado = $(elemento).find(me.Variables.cdrweb_formatoFechaCulminado).val();
                        var _Campania = $(elemento).find(me.Variables.cdrweb_formatocampania).val();
                        var _CantidadAprobados = $(elemento).find(me.Variables.cdrweb_CantidadAprobados).val();
                        var _CantidadRechazados = $(elemento).find(me.Variables.cdrweb_CantidadRechazados).val();
                        $("#hdPedidoIdActual").val(_PedidoID);
                        $("#hdCDRWebID").val(_CDRWebID);

                        if (_Estado === "1") {
                            if (mensajeGestionCdrInhabilitada !== "") {
                                messageInfoValidado(mensajeGestionCdrInhabilitada);
                                return false;
                            }
                            window.location.href = urlReclamo + "?p=" + _PedidoID + "&c=" + _CDRWebID;
                        } else {
                            var obj = {
                                OrigenCDRDetalle: _OrigenDetalle,
                                CDRWebID: _CDRWebID,
                                PedidoID: _PedidoID,
                                FormatoFechaCulminado: _FechaCulminado,
                                FormatoCampaniaID: _Campania,
                                CantidadAprobados: _CantidadAprobados,
                                CantidadRechazados: _CantidadRechazados
                            };

                            ShowLoading();
                            $.ajax({
                                type: 'Post',
                                url: urlValidarCargaDetalle,
                                data: JSON.stringify(obj),
                                dataType: 'json',
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    CloseLoading();
                                    if (checkTimeout(data)) {
                                        if (data.success == true)
                                            window.location.href = baseUrl + "Mobile/MisReclamos/Detalle" + "?e=" + _Estado;
                                    }
                                },
                                error: function (data, error) {
                                    CloseLoading();
                                    if (checkTimeout(data))
                                        cerrarRechazado = '0';
                                }
                            });
                        }
                    });
                    $(me.Variables.OrdenarSolicitudesRegistradasPor).on("change", function () {
                        try {
                            var $divMisReclamos = $('#divMisReclamos');
                            $divMisReclamos.empty();
                            ShowLoading();
                            var o = $(this).val();
                            if (o != "" && o != "0")
                                $("#lblTextoSeleccionado").hide();
                            else
                                $("#lblTextoSeleccionado").fadeIn();

                            var url = UrlGetMisReclamos + "?o=" + o;
                            $.when($divMisReclamos.load(url, function () {
                                $(".abrir_detallemb").on("click", function () {
                                    me.Funciones.CargarMisReclamosDetalle(this);
                                });
                            })).done(function () {
                                CloseLoading();
                            });

                        } catch (e) {
                            CloseLoading();
                        }
                    });

                    $(me.Variables.btnActualizarSolicitud).on("click", function () {
                        var pedidoId = $("#hdPedidoIdActual").val();
                        var id = $("#hdCDRWebID").val();
                        var lista = [];
                        var $tagsElements = $("#MiDetalleCDR .cls_cantidad");
                        $.each($tagsElements, function () {
                            var $element = $(this);
                            var $data = $element.data("itemValues");
                            var tipo = $data.item_type;
                            var Id = $data.pedido_detalle_id;
                            var Cuv = $data.codigo_cuv;
                            var Cantidad = $element.val();
                            var Reemplazo = [];
                            var objGrupal = {}
                            if (tipo == "grupal") {
                                objGrupal = {
                                    cuv: Cuv,
                                    cantidad: Cantidad
                                }
                                Reemplazo.push(objGrupal);
                            }
                            arr = $.grep(lista, function (val, i) {
                                if (typeof (val.CDRWebDetalleID) !== "undefined") {
                                    return (val.CDRWebDetalleID == Id);
                                } else {
                                    return [];
                                }
                            });
                            if (arr.length == 0) {
                                var det = tipo == "grupal" ? Reemplazo : [];
                                var a = {
                                    CDRWebDetalleID: Id,
                                    Cantidad: tipo == "grupal" ? 0 : Cantidad,
                                    Reemplazo: det
                                };
                                lista.push(a);
                            } else {
                                var arr = $.grep(lista, function (value, index) {
                                    return (value.CDRWebDetalleID == Id);
                                });

                                if (arr.length > 0) {
                                    arr[0].Reemplazo.push(objGrupal);
                                }
                            }
                        });
                        var actualizado = me.Funciones.ActualizarDetalleObservado(lista);
                        console.log(urlReclamo);
                        if (actualizado) window.location.href = urlReclamo + "?p=" + pedidoId + "&c=" + id;
                    });
                }
            };

            me.Constantes = {
            };

            me.Funciones = {
                NuevaSolicitud: function () {
                    if (mensajeGestionCdrInhabilitada !== "") {
                        messageInfoValidado(mensajeGestionCdrInhabilitada);
                        return false;
                    }
                    var nroSolicitudes = $("#hdNroSolicitudes").val() == "" ? 0 : parseInt($("#hdNroSolicitudes").val());
                    var flagMostrarTab = nroSolicitudes > 0 ? "1" : "0";
                    var url = urlReclamo + "?t=" + flagMostrarTab;
                    window.location.href = url;

                },
                CargarMisReclamosDetalle: function (el) {
                    var elemento = $(el);
                    var _OrigenDetalle = "1";
                    var _CDRWebID = $(elemento).find(me.Variables.cdrweb_id).val();
                    var _PedidoID = $(elemento).find(me.Variables.cdrweb_pedidoid).val();
                    var _Estado = $(elemento).find(me.Variables.cdrweb_estado).val();
                    var _FechaCulminado = $(elemento).find(me.Variables.cdrweb_formatoFechaCulminado).val();
                    var _Campania = $(elemento).find(me.Variables.cdrweb_formatocampania).val();
                    var _CantidadAprobados = $(elemento).find(me.Variables.cdrweb_CantidadAprobados).val();
                    var _CantidadRechazados = $(elemento).find(me.Variables.cdrweb_CantidadRechazados).val();

                    if (_Estado === "1") {
                        if (mensajeGestionCdrInhabilitada !== "") {
                            messageInfoValidado(mensajeGestionCdrInhabilitada);
                            return false;
                        }

                        window.location.href = urlReclamo + "?p=" + _PedidoID + "&c=" + _CDRWebID;
                    } else {
                        var obj = {
                            OrigenCDRDetalle: _OrigenDetalle,
                            CDRWebID: _CDRWebID,
                            PedidoID: _PedidoID,
                            FormatoFechaCulminado: _FechaCulminado,
                            FormatoCampaniaID: _Campania,
                            CantidadAprobados: _CantidadAprobados,
                            CantidadRechazados: _CantidadRechazados
                        };

                        ShowLoading();
                        $.ajax({
                            type: 'Post',
                            url: urlValidarCargaDetalle,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                CloseLoading();
                                if (checkTimeout(data)) {
                                    if (data.success == true)
                                        window.location.href = baseUrl + "Mobile/MisReclamos/Detalle";
                                }
                            },
                            error: function (data, error) {
                                CloseLoading();
                                if (checkTimeout(data))
                                    cerrarRechazado = '0';
                            }
                        });
                    }
                },
                PreEliminarDetalle: function (el) {
                    var pedidodetalleid = $.trim($(el).attr("data-pedidodetalleid"));
                    var grupoid = $.trim($(el).attr("data-detalle-grupoid"));
                    var cuv = $.trim($(el).attr("data-cuv"));
                    var item = {
                        CDRWebDetalleID: pedidodetalleid,
                        GrupoID: grupoid,
                        CUV: cuv
                    };
                    var msg = "";
                    if (grupoid.length > 0) {
                        msg = "Se eliminaran todos los registros relacionados al producto(Sets o Packs). ¿Deseas continuar?";
                    } else {
                        msg = "Se eliminará el registro seleccionado. ¿Deseas continuar ?";
                    }
                    messageConfirmacion("confirmación", msg, function () {
                        me.Funciones.DetalleEliminar(item);
                    });
                },
                DetalleEliminar: function (objItem) {
                    ShowLoading();
                    jQuery.ajax({
                        type: 'POST',
                        url: UrlDetalleEliminar,
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify(objItem),
                        async: true,
                        cache: false,
                        success: function (data) {
                            CloseLoading();
                            if (!checkTimeout(data)) {
                                return false;
                            }

                            if (data.success) {
                                window.location.href = baseUrl + "Mobile/MisReclamos/Detalle";
                            }
                        },
                        error: function (data, error) {
                            CloseLoading();
                        }
                    });
                },
                AgregarODisminuirCantidad: function (event, opcion) {
                    if (opcion === 1) {
                        EstrategiaAgregarModule.AdicionarCantidad(event);
                    }
                    if (opcion === 2) {
                        EstrategiaAgregarModule.DisminuirCantidad(event);
                    }
                    var $this = $(event.target);
                    var $parent = $this.parents(".detalle_tipo_solicitud");
                    var $subParent = $this.parents(".detalle_productos_solicitud_cdr");
                    var $el_input = $this.parents(".acciones_solicitud").find("input[name=cantidad]");
                    var $el_span = $subParent.find("span[name=cantidad]");

                    $el_span.text($el_input.val());
                    $el_input.attr("data-cantidad", $el_input.val());
                    me.Funciones.CalcularTotalPerItem($parent);
                },
                ActualizarCantidad: function (event) {
                    var $this = $(event.target);
                    var $parent = $this.parents(".detalle_tipo_solicitud");
                    var $subParent = $this.parents(".detalle_productos_solicitud_cdr");
                    var $val = $this.val();
                    var $el_span = $subParent.children(".producto_solicitud").find("span[name=cantidad]");
                    $el_span.text($val);
                    $this.attr("data-cantidad", $val);
                    me.Funciones.CalcularTotalPerItem($parent);
                },
                CalcularTotalPerItem: function ($parent) {
                    var $elementsCantPrice = $parent.find(".producto_solicitud");
                    var total = 0;
                    $.each($elementsCantPrice, function () {
                        var $this = $(this);
                        var cant = $this.find("span[name=cantidad]").text();
                        var price = $this.find("span[name=precio]").attr("data-precio");
                        total += parseInt(cant) * parseFloat(price);
                    });
                    $parent.children(".detalle_cdr_solucion").children(".cls_total").find("span[name=total]").text(variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(total))
                },
                ActualizarDetalleObservado: function (lista) {
                    var resultado = false;
                    ShowLoading();

                    jQuery.ajax({
                        type: 'POST',
                        url: UrlDetalleActualizarObservado,
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify(lista),
                        async: false,
                        cache: false,
                        success: function (data) {
                            CloseLoading();
                            if (!checkTimeout(data)) {
                                return false;
                            }
                            if (data.success) {
                                resultado = true;
                            }
                        },
                        error: function (data, error) {
                            CloseLoading();
                        }
                    });
                    return resultado;
                }
            };

            me.Inicializar = function () {
                me.Eventos.bindEvents();
            };
        };

        misReclamos = new PortalConsultorasReclamos();
        misReclamos.Inicializar();

    };
})(cerrarRechazado));
