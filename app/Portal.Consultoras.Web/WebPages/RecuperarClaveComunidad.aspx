<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/MasterComunidad.Master" AutoEventWireup="true" CodeBehind="RecuperarClaveComunidad.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RecuperarClaveComunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function ValidarCorreo(correo) {
            expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return expr.test(correo);
        }

        function ValidarFormulario() {
            var result = true;

            if ($('#txtCorreo').val() == 'Correo electrónico') {
                $('#ErrorCorreo').css({ "display": "block" });
                $('#ES_Correo').css({ "display": "block" });
                $('#ErrorCorreo').html("Debe ingresar su correo.");
                result = false;
            }
            else {
                if (!ValidarCorreo($('#txtCorreo').val())) {
                    $('#ErrorCorreo').css({ "display": "block" });
                    $('#ES_Correo').css({ "display": "block" });
                    $('#ErrorCorreo').html("El formato del correo es incorrecto.");
                    $('#ErrorCorreo').css({ "color": "red" });
                    result = false;
                }
                else {
                        $('#ErrorCorreo').css({ "display": "none" });
                        $('#ES_Correo').css({ "display": "none" });
                        $('#ErrorCorreo').html('')
                }
            }

            if (result) {

                var item = {
                    Correo: $('#txtCorreo').val()
                };

                waitingDialog({});

                RecuperarClaveUsuarioComunidad(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.success == true) {
                        closeWaitingDialog();
                        AbrirAlerta_1();
                    }
                    else {
                        closeWaitingDialog();
                        AbrirAlerta_2();
                    }

                    Limpiar();
                    return false;
                });
            }
        }

        $(document).keypress(function (e) {
            if (e.which == 13)
                $("#btnEnviar").click();
        });

        function AbrirAlerta_1() {
            $('#pnlExito').dialog({
                modal: true,
                width: 650,
                title: 'Comunidad SomosBelcorp',
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlExito').dialog("close");
                    }
                }
            });
        }

        function AbrirAlerta_2() {
            $('#pnlError').dialog({
                modal: true,
                width: 500,
                title: 'Comunidad SomosBelcorp',
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlError').dialog("close");
                    }
                }
            });
        }

        function Limpiar() {
            $('#txtCorreo').val('Correo electrónico');
            $('#ddlPais').val('0');

            $('#ErrorCorreo').css({ "display": "none" });
            $('#ES_Correo').css({ "display": "none" });
            $('#ErrorCorreo').html('')
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapMain">
        <div class="webForm">
            <div class="title">
                Recupera tu contraseña
            </div>
            <div class="formCont">
                <div class="formMen">
                    <p>Ingresa tu correo electrónico y te enviaremos</p>
                    <p>un enlace para crear una nueva contraseña.</p>
                </div>
                <div class="formcontrol mail">
                    <input id="txtCorreo" type="text" class="inputForm" value="Correo electrónico" onfocus="if (this.value == 'Correo electrónico') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Correo electrónico';}else{if (this.value != 'Correo electrónico') {ValidarCorreoIngresado(this.value);}}">
                    <div id="ErrorCorreo" style="font-size: 11px; color: red; display: none;"></div>
                </div>
                <div id="ES_Correo" style="height: 10px; display: none;"></div>
                <div style="height: 20px;"></div>
                <div class="formbtn2">
                    <input id="btnEnviar" type="button" class="btnCrear" value="ENVIAR" onclick="ValidarFormulario()">
                </div>
                <div class="formbtn3">
                    <a href="IngresoComunidad.aspx">Cancelar</a>
                </div>
            </div>
        </div>
    </div>
        <div id="pnlExito" style="display: none;">
        <div>
            Para continuar con el proceso de recuperación de contraseña, sigue los pasos del correo que te hemos enviado.
        </div>
    </div>
    <div id="pnlError" style="display: none;">
        <div style="text-align: left">
            El correo ingresado no es válido. Por favor, ingrese el correo con el que te registraste en la comunidad.
        </div>
    </div>
</asp:Content>
