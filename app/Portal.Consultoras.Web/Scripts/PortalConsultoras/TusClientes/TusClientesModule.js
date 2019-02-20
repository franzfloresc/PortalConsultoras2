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

        _config.tusClientesProvider
            .consultarPromise(nombreCliente)
            .done(function (result) {
                SetHandlebars(_elements.hbsClientes, result, _elements.divClientes);
            })
            .fail(function (data, error) {
                throw "Error al invocar tusClienteProvider.consultarPromise";
            });

        return false;
    };

    var _setNombreCliente = function (nombreCliente) {
        $(_elements.txtNombreCliente).val(nombreCliente);
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

    var _eliminarCliente = function () {
        var clientId = parseInt($(_elements.divConfirmarEliminarCliente).data("clienteId"));
        _config
            .tusClientesProvider
            .eliminarClientePromise(clientId)
            .done(function (data) {
                alert(data.message);
                _ocultarConfirmarEliminarCliente();
                _buscarClientes();
                
            })
            .fail(function (data, error) {

            });
    };

    var _mostarConfirmarEliminarCliente = function (clienteId) {
        $(_elements.divConfirmarEliminarCliente).show();
        $(_elements.divConfirmarEliminarCliente).data("clienteId", clienteId);
    };

    var _ocultarConfirmarEliminarCliente = function () {
        $(_elements.divConfirmarEliminarCliente).hide();
        $(_elements.divConfirmarEliminarCliente).data("clienteId", "");
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
        console.log((hT - wH), wS);
        if (wS > (hT + hH - wH)) {
            $("#content_boton_agregar").addClass("content_boton_agregar_ancla");
            //$("#content_boton_agregar").fadeIn();
        } else {
            //$("#content_boton_agregar").removeAttr('style');
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