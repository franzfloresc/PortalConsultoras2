
var object = {};
var URL_GUARDAR_RECEPCIONPEDIDO = baseUrl + "Pedido/GuardarRecepcionPedidoRequest"
var PopupRecepcionPedido = (function () {

    var _elementos = {
        camposPopupRecepcionPedido: '.text__field__sb'
    };
    var _funciones = {
        InicializarEventos: function () {
            $(document).on("blur", _elementos.camposPopupRecepcionPedido, _eventos.CampoConDatos);
        },
    };
    var _eventos = {
        CampoConDatos: function (e) {
            var campoDatos = $(this).val();
            if (campoDatos) {
                $(this).addClass('text__field__sb--withContent');
            } else {
                $(this).removeClass('text__field__sb--withContent');
            }
        }
    }

    //Public functions
    function Inicializar() {
        _funciones.InicializarEventos();
    }
    function LimpiarCampos() {
        _funciones.LimpiarCamposRecepcionPoput();
    }

    return {
        Inicializar: Inicializar,
        LimpiarCampos: LimpiarCampos
    };

})();

$(document).ready(function () {
    PopupRecepcionPedido.Inicializar();
    /*HD-4288 - Switch Consultora 100% */
    $("#PopupRecepcionPedido input:text").change(function (event) {

        
        var id = event.target.id;
        var valor = event.target.value;

        if (id == "txtNombreYApellido") {
            if (valor.length > 0) {
                object.nombreYApellido = valor;
                document.getElementsByClassName("form__group__fields--nombreApellido")[0].children[2].textContent = "";
            } else {
                object.nombreYApellido = "";
                document.getElementsByClassName("form__group__fields--nombreApellido")[0].children[2].textContent = "Ingresar nombres y apellidos";
                $(".btn__sb__primary--multimarca").addClass("btn__sb--disabled");
            }

        }
        if (id == "txtNumeroDocumento") {

            if (valor.length > 0) {
                if (valor.length != 8) {
                    object.numeroDocumento = "";
                    document.getElementsByClassName("form__group__fields--numeroDocumento")[0].children[2].textContent = "Ingresar un DNI válido";
                    $(".btn__sb__primary--multimarca").addClass("btn__sb--disabled");
                    return;
                } else {
                    document.getElementsByClassName("form__group__fields--numeroDocumento")[0].children[2].textContent = "";
                    object.numeroDocumento = valor;
                }
            } else {
                object.numeroDocumento = "";
                document.getElementsByClassName("form__group__fields--numeroDocumento")[0].children[2].textContent = "";
                $(".btn__sb__primary--multimarca").addClass("btn__sb--disabled");
            }


        }
        if (object.nombreYApellido.length > 0 && object.numeroDocumento.length) {
            $(".btn__sb__primary--multimarca").removeClass("btn__sb--disabled");
        }

    });
    /*HD-4288 - FIN*/
    $(".btn__sb__primary--multimarca").click(function () {
        
        $.ajax({
            type: "POST",
            url: URL_GUARDAR_RECEPCIONPEDIDO,
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(object),
            dataType: "json",
            cache: false,
            success: function (data) {
                
                if (checkTimeout(data)) {
                    if (data > 0) {
                        $('#PopupRecepcionPedido').fadeOut(100);
                        $(".info_recepcion_pedido").css("display", "block");
                        cargarDatosrecepcion(object);
                    }
                }
            },
            error: function (x, xh, xhr) {
                if (checkTimeout(x)) {
                    closeWaitingDialog();
                }
            }
        });
    });



});

