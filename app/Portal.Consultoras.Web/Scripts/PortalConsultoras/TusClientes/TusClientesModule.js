/// <reference path="tusclientesprovider.js" />
/// <reference path="../../General.js" />


var TusClientesModule = function (config) {
    "use strict";

    var _config = {
        tusClientesProvider: config.tusClientesProvider /*|| TusClientesProvider()*/,
        checkTimeout: checkTimeout
    };

    var _elements = {
        txtNombreCliente: "#txtNombreCliente",
        btnExportarClientes: "#btnExportarClientes",
        divClientes: "#divClientes",
        hbsClientes: "#hbsClientes",
        //
        divPopupEditarCliente: "#divPopupEditarCliente",
        //
        divConfirmarEliminarCliente: "#divConfirmarEliminarCliente",
        btnConfirmarEliminarCliente: "#btnConfirmarEliminarCliente",
        btnCancelarEliminarCliente: "#btnCancelarEliminarCliente",
    };

    var _panelMantenerCliente = null;

    var _buscarClientes = function () {
        var nombreCliente = $.trim($(_elements.txtNombreCliente).val());
        //$(_elements.btnExportarClientes).hide();

        if (!checkTimeout()) return false;
        _config.tusClientesProvider
            .consultarPromise(nombreCliente)
            .done(function (result) {
                //if (result.miData.length > 0) $(_elements.btnExportarClientes).show();
                SetHandlebars(_elements.hbsClientes, result, _elements.divClientes);
            })
            .fail(function (data, error) {
                throw "Error al invocar tusClienteProvider.consultarPromise";
            });

        return false;
    };

    var _setNombreCliente = function (nombreCliente) {
        $(_elements.txtNombreCliente).val(nombreCliente);
        _buscarClientes();
    };

    var _ocultarEditarCliente = function () {
        
        $(_elements.divPopupEditarCliente).removeClass("show_PopupEditarCliente");
        setTimeout(function () {
            $(_elements.divPopupEditarCliente).hide();
            $("body").css("overflow", "auto");
            $("#modal-fondo-form").hide();
        }, 450);
    };

    var _editarCliente = function (cliente) {
        _panelMantenerCliente.setCliente(cliente)
        $("body").css("overflow", "hidden");
        $(_elements.divPopupEditarCliente).show();
        $(_elements.divPopupEditarCliente).addClass("show_PopupEditarCliente");

        $('.ImputForm-item input').each(function () {
            if ($(this).val().length !== 0) {
                $(this).addClass('ActiveLabel');
                $(this).addClass('bar-imputActive');
            }
            else {
                $(this).removeClass('ActiveLabel');
                $(this).removeClass('bar-imputActive');
            }
        });

        $("#modal-fondo-form").show();
    };

    var _eliminarCliente = function (clienteId) {
        AbrirLoad();
        _config
            .tusClientesProvider
            .eliminarClientePromise(clienteId)
            .done(function (data) {
                AbrirMensaje(data.message)
                _ocultarConfirmarEliminarCliente(clienteId);
                _buscarClientes();
            })
            .fail(function (data, error) {

            })
            .then(function () {
                CerrarLoad();
            });
    };

    var _mostarConfirmarEliminarCliente = function (clienteId) {
        $(_elements.divConfirmarEliminarCliente + "-" + clienteId).show();
    };

    var _ocultarConfirmarEliminarCliente = function (clienteId) {
        $(_elements.divConfirmarEliminarCliente + "-" + clienteId).hide();
    };

    var _init = function () {
        _panelMantenerCliente = PanelMantenerModule({
            tusClientesProvider: _config.tusClientesProvider,
            setNombreClienteCallback: _setNombreCliente,
            mostrarTusClientesCallback: _buscarClientes,
            panelRegistroHideCallback: _ocultarEditarCliente,
            seleccionarClienteDespuesEditar: false
        });

        _panelMantenerCliente.init();

        _buscarClientes();

        $(_elements.txtNombreCliente).keypress(function (e) {
            if (e.which == 13 && _config.checkTimeout()) {
                _buscarClientes();
            }
        });

        $(_elements.btnExportarClientes).click(function (e) {
            //if (!checkTimeout()) {
            //    return false;
            //}

            var content = "/TusClientes/ExportarExcelMisClientes";
            var iframe_ = document.createElement("iframe");
            iframe_.style.display = "none";
            iframe_.setAttribute("src", content);

            if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {
                iframe_.onreadystatechange = function () {
                    switch (this.readyState) {
                        case "loading":
                            waitingDialog({});
                            break;
                        case "complete":
                        case "interactive":
                        case "uninitialized":
                            closeWaitingDialog();
                            break;
                        default:
                            closeWaitingDialog();
                            break;
                    }
                };
            }
            else {
                // Si es Firefox o Chrome
                $(iframe_).ready(function () {
                    closeWaitingDialog();
                });
            }
            document.body.appendChild(iframe_);
        });

        _ocultarEditarCliente();

        $(window).scroll(function () {
            var scrollTop = $(this).scrollTop();

            if (scrollTop > 230) {
                $("#fitros_fixed").addClass("fitros_fixed");
                $("#fitros_fixed").fadeIn();
            }
            else {
                $("#fitros_fixed").removeClass("fitros_fixed");
                $("#fitros_fixed").removeAttr('style');
            }
        });

        $(window).scroll(function () {
            var hT = $('#content_boton_agregar_ancla').offset().top,
                hH = $('#content_boton_agregar_ancla').outerHeight(),
                wH = $(window).height(),
                wS = $(this).scrollTop();

            if (wS > (hT + hH - wH)) {
                $("#content_boton_agregar").addClass("content_boton_agregar_ancla");
            } else {
                $("#content_boton_agregar").removeClass("content_boton_agregar_ancla");
            }
        });
    };

    return {
        init: _init,
        ocultarEditarCliente: _ocultarEditarCliente,
        editarCliente: _editarCliente,
        eliminarCliente: _eliminarCliente,
        mostarConfirmarEliminarCliente: _mostarConfirmarEliminarCliente,
        ocultarConfirmarEliminarCliente: _ocultarConfirmarEliminarCliente
    };
};