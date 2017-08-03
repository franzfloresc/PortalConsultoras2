/// <reference path="../../jquery-1.11.2.js" />

//var matrizCampaniaModule = (function () {
//    "use strict"

//    var initializer = function (parameters) {
//        //setting.listarCampaniasUrl = parameters.listarCampaniasUrl;
//        //setting.listarProductoComentarioUrl = parameters.listarProductoComentarioUrl;
//        //setting.imagenEnableUrl = parameters.imagenEnableUrl;
//        //setting.imagenDisableUrl = parameters.imagenDisableUrl;
//        //setting.actualizarEstadoProductoComentarioUrl = parameters.actualizarEstadoProductoComentarioUrl;
//        //
//        _bindEvents();
//    };

//    return {
//        ini: function (parameters) {
//            initializer(parameters);
//        }
//    };
//})();

jQuery(document).ready(function () {

    $('#txtPrecioNuevo').keypress(function (e) {
        var theEvent = e || window.event;
        var key = theEvent.keyCode || theEvent.which;
        var character = (key != 8 ? String.fromCharCode(key) : "")
        var newValue = this.value + character;
        if (isNaN(newValue) || hasDecimalPlace(newValue, 3)) {
            return false;
        }
    });

    $('#txtFactorRepeticionNuevo').keyup(function (evt) {
        var theEvent = evt || window.event;
        var key = theEvent.keyCode || theEvent.which;
        key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false;
            if (theEvent.preventDefault) theEvent.preventDefault();
        }
    });

    $('#txtFactorRepeticionNuevo').keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $("#btnBuscar").click(function () { PreBuscar(); });
    $("#btnGrabar").click(function () {
        var vMessage = "";
        if (jQuery.trim($('#txtDescripcion').val()) == "") {
            vMessage += "- Debe ingresar descripción el producto.\n";
            $('#btnBuscar').focus();
            alert(vMessage);
            return false;
        }
        if ($('#btnBuscar')[0].value == "Buscar") {
            vMessage += "- Debe realizar la busqueda de la descripción primero.\n";
            $('#btnBuscar').focus();
            alert(vMessage);
            return false;
        }

        Grabar();
    });
    $("#txtCodVenta").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            PreBuscar();
        }
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[0-9]/;
            return re.test(keyChar);
        }
    });
    $("#txtDescripcion").keypress(function (evt) {
        var charCode = (evt.which) ? evt.which : window.event.keyCode;
        if (charCode <= 13) {
            return false;
        }
        else {
            var keyChar = String.fromCharCode(charCode);
            var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]/;
            return re.test(keyChar);
        }
    });
    $('#ddlPais').change(function () {
        var Id = $(this).val();
        if (Id != null) {
            waitingDialog({});
            $.ajaxSetup({ cache: false });
            $.getJSON(baseUrl + 'MatrizCampania/CargarCampania', { paisId: Id == "" ? 0 : Id }, function (data) {
                if (checkTimeout(data)) {
                    LimpiarDependencias(Id);
                    if (Id != "") {
                        var ddlCampania = $('#ddlCampania');
                        if (data.DropDownListCampania.length > 0) {
                            for (var item in data.DropDownListCampania) {
                                if (data.DropDownListCampania[item].CampaniaID) {
                                    ddlCampania.append($('<option/>', {
                                        value: data.DropDownListCampania[item].CampaniaID,
                                        text: data.DropDownListCampania[item].Codigo
                                    }));
                                }
                            }
                        }
                    }
                    closeWaitingDialog();
                }
            });
        }
    });

    function PreBuscar() {
        if ($('#btnBuscar')[0].value == "Buscar") {
            var vMessage = "";
            if (jQuery.trim($('#ddlPais').val()) == "") {
                vMessage += "- Debe seleccionar el país.\n";
                $('#ddlPais').focus();
                alert(vMessage);
                return false;
            }
            if (jQuery.trim($('#ddlCampania').val()) == "") {
                vMessage += "- Debe seleccionar la campaña.\n";
                $('#ddlCampania').focus();
                alert(vMessage);
                return false;
            }
            else {
                if (jQuery.trim($('#txtCodVenta').val()) == "") {
                    vMessage += "- Debe ingresar código único de venta.\n";
                    alert(vMessage);
                    $('#txtCodVenta').focus();
                    return false;
                }
                else {
                    Buscar();
                    return false;
                }
            }
        }
        else {
            $('#btnBuscar')[0].value = "Buscar";
            $('#ddlPais')[0].disabled = false;
            $('#ddlCampania')[0].disabled = false;
            $('#txtCodVenta')[0].disabled = false;
            limpiarFormulario();
            return false;
        }
        return false;
    }

    $(document).keydown(function (e) {
        if (e.keyCode == 8 && e.target.tagName != 'INPUT' && e.target.tagName != 'TEXTAREA') {
            e.preventDefault();
        }
    })


});

function limpiarFormulario() {
    $('#txtDescripcion').val("");
    $('#txtCodVenta').val("");
    $('#txtPrecio').val("");
    $('#txtFactorRepeticion').val("");
    $('#txtDescripcionNueva').val("");
    $('#txtPrecioNuevo').val("");
    $('#txtFactorRepeticionNuevo').val("");
}

function Buscar() {

    waitingDialog({});
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MatrizCampania/ConsultarDescripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ CUV: $("#txtCodVenta").val(), IDCampania: $("#ddlCampania").val(), paisID: $('#ddlPais').val() }),
        async: true,
        cache: false,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {

                    if (data.lstProducto.length == 1) {

                        $("#txtDescripcion").val(data.lstProducto[0].Descripcion);
                        $("#txtPrecio").val(data.lstProducto[0].PrecioProducto);
                        $("#txtFactorRepeticion").val(data.lstProducto[0].FactorRepeticion);

                    } else {
                        $("#txtDescripcion").val(data.lstProducto[0].Descripcion);
                        $("#txtPrecio").val(data.lstProducto[0].PrecioProducto);
                        $("#txtFactorRepeticion").val(data.lstProducto[0].FactorRepeticion);

                        $("#txtDescripcionNueva").val(data.lstProducto[1].Descripcion);
                        $("#txtPrecioNuevo").val(data.lstProducto[1].PrecioProducto);
                        $("#txtFactorRepeticionNuevo").val(data.lstProducto[1].FactorRepeticion);

                    }

                    $('#btnBuscar')[0].value = "Buscar Otro";
                    $('#ddlPais')[0].disabled = true;
                    $('#ddlCampania')[0].disabled = true;
                    $('#txtCodVenta')[0].disabled = true;
                }
                else {
                    alert(data.message);
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("ERROR");
            }
        }
    });
}

function Grabar() {
    var msj = "";

    if ($('#txtDescripcionNueva').val() == "")
        msj += "- Debe ingresar la nueva Descripción del Producto \n";

    if ($('#txtPrecioNuevo').val() == "")
        msj += "- Debe ingresar el Nuevo Precio del Producto \n";

    if ($('#txtFactorRepeticionNuevo').val() == "")
        msj += "- Debe ingresar el Nuevo Factor Repetición del Producto \n";

    if (msj != "") {
        alert(msj);
        return false;
    }

    waitingDialog({});
    var item = {
        CUV: jQuery('#txtCodVenta').val(),
        CampaniaID: jQuery('#ddlCampania').val(),
        Descripcion: jQuery('#txtDescripcionNueva').val(),
        PaisID: jQuery('#ddlPais').val(),
        PrecioProducto: jQuery('#txtPrecioNuevo').val(),
        FactorRepeticion: jQuery('#txtFactorRepeticionNuevo').val()
    };
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MatrizCampania/InsertarProductoDescripcion',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(item),
        async: true,
        success: function (data) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                if (data.success == true) {
                    limpiarFormulario();
                    $('#btnBuscar')[0].value = "Buscar";
                    $('#ddlPais')[0].disabled = false;
                    $('#ddlCampania')[0].disabled = false;
                    $('#txtCodVenta')[0].disabled = false;
                    alert(data.message);
                }
                else
                    alert(data.message);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                closeWaitingDialog();
                alert("ERROR");
            }
        }
    });
}

function LimpiarDependencias(Id) {
    var ddlCampania = $('#ddlCampania');
    ddlCampania.empty();

    ddlCampania.append($('<option/>', {
        value: "",
        text: "-- Seleccionar --"
    }));
}

function hasDecimalPlace(value, x) {
    var pointIndex = value.indexOf('.');
    return pointIndex >= 0 && pointIndex < value.length - x;
}