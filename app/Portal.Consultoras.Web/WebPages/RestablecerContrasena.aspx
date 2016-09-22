<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestablecerContrasena.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RestablecerContrasena" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,300,700,900" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-migrate-1.2.1.min.js"></script>
    <script src="../Scripts/jquery.validate.min.js"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.min.js"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="../Scripts/HojaInscripcion/validations.js"></script>

    <script src="../Scripts/General.js" type="text/javascript"></script>
    <link href="../Content/Css/Site/Esika/reset.css" rel="stylesheet" />
    <link href="../Content/Css/Site/Esika/style.css" rel="stylesheet" />
    <link href="../Content/Css/ui.jquery/Esika/jquery-ui.css" rel="stylesheet" />
    <title>Restablecer Contraseña</title>

    <script>
        $(document).ready(function () {
            $("#btncambiar").click(function () {
                ModificarClave();
            });
            $("#txtcontrasenanueva2").on("keypress", function (evt) {
                if (evt.keyCode === 13) {
                    ModificarClave();
                }
            });

        });

        function ModificarClave() {
            var newPassword1 = jQuery.trim($('#txtcontrasenanueva1').val());
            var newPassword2 = jQuery.trim($('#txtcontrasenanueva2').val());
            var vMessage = "";
            var titulo = "Error";

            if (newPassword1 == "")
                vMessage += "Debe ingresar la Nueva Contraseña.<br>";

            if (newPassword2 == "")
                vMessage += "Debe repetir la Nueva Contraseña.<br>";

            if (newPassword1.length <= 3)
                vMessage += "La Nueva Contraseña debe de tener más de 6 caracteres.\n";

            if (newPassword1 != "" && newPassword2 != "") {
                if (newPassword1 != newPassword2)
                    vMessage += "Los campos de la nueva contraseña deben ser iguales, verifique.\n";
            }

            if (vMessage != "") {
                AbrirAlerta(titulo, vMessage);
                return false;
            }
            else {
                var newPassword = jQuery.trim($('#txtcontrasenanueva1').val());

                var item = {
                    newPassword: newPassword
                };

                waitingDialog({});

                ModificaClaveCS(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.succes == true) {
                        closeWaitingDialog();
                        $('#divFormularioActualizacion').hide();
                        $('#divActualizacionCorrecta').hide();
                    }
                    else {
                        closeWaitingDialog();
                        return false;
                    }
                    Limpiar();
                });
            }
        }

        function Limpiar() {
            $('#txtpaisid').val("");
            $('#txtcorreo').val("");
            $('#txtpaisiso').val("");
            $('#txtcodigousuario').val("");
            $('#txtcontrasenaanterior').val("");
            $('#txtcontrasenanueva1').val("");
            $('#txtcontrasenanueva2').val("");
        }

        function AbrirAlerta(titulo, mensaje) {
            $('#pnlError').dialog({
                modal: true,
                width: 320,
                title: titulo,
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                responsive: true,
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlError').dialog("close");
                    }
                }
            });

            $('#iderror').html(mensaje);

        }

        function AbrirAlertaPopup(titulo, mensaje) {
            $('#pnlErrorPopup').dialog({
                modal: true,
                width: 320,
                title: titulo,
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                responsive: true,
                position: "center",
                dialogClass: "no-cerrar"
            });
            $('#iderrorpopup').html(mensaje);
        }
    </script>
</head>

<body id="bodyrestablece" class="bodyrecuperaclave">
    <header>
        <div class="wrapper_header">
            <div class="fondo_oscuro"></div>
            <div class="logo_esika logoEsikaActualizarContrasenia">
                <a href="#"></a>
            </div>
        </div>
        <div class="clear"></div>
    </header>
    <div id="loadingScreen"></div>
    <div class="ubicacion_web ubicacionWebActualizarContrasenia">
        <span><a href="/Bienvenida">Home</a></span> <span>| Cambio de Contraseña</span>
    </div>
    <div class="content">
        <div class="fondo_f9f9f9">
            <div class="content_belcorp">
                <div class="fondo_negro_lateral"></div>
                <div class="titulo_interiores tituloCambioContrasenia"><span>CAMBIO DE CONTRASEÑA</span></div>
            </div>
            <hr class="clear" />
            <div class="linea_separadora" style="margin-top: -1px"></div>
        </div>

        <div class="content_belcorp">
            <div class="pestana_lbel pestanaLbelActualizarContrasenia"></div>
            <!--PESTAÑA PARA DARLE ESTILO CON LBEL-->
            <div class="contenedor_actualizarContraseniaForm" id="divFormularioActualizacion">
                <div class="campos_actualizacionContrasenia">
                    <div class="saludoConsultora">¡Hola <span><asp:Label runat="server" ID="lblNombre"></asp:Label>!</span></div>
                    <span class="cambiarContraseniaTexto">Cambia tu contraseña aquí:</span>
                    <form id="frmrestablecercontrasena" runat="server" class="formulario_actualizarContrasenia">
                        <div style="display: none;">
                            <asp:TextBox ID="txtpaisid" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtcorreo" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtpaisiso" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtcodigousuario" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtcontrasenaanterior" runat="server" CssClass="txttexto"></asp:TextBox>
                        </div>
                        <asp:TextBox ID="txtcontrasenanueva1" runat="server" CssClass="campoContrasenia" placeholder="Nueva contraseña" TextMode="Password"></asp:TextBox>
                        <asp:TextBox ID="txtcontrasenanueva2" runat="server" CssClass="campoContrasenia" placeholder="Confirmar contraseña" TextMode="Password"></asp:TextBox>
                        <input id="btncambiar" class="btnCambiarContrasenia" type="button" value="CAMBIAR" />
                    </form>
                </div>
                <div class="campos_actualizacionContrasenia" id="divActualizacionCorrecta" style="display:none;">
                    <div class="saludoConsultora">¡Tu contraseña fue actualizada correctamente!</div>
                    <span class="cambiarContraseniaTexto"></span>
                    <div class="formulario_actualizarContrasenia">
                        <asp:HyperLink ID="linkregresarasomosbelcorp" runat="server" CssClass="btnCambiarContrasenia" style="text-align: center;">IR A SOMOS BELCORP</asp:HyperLink>
                        <%--<input id="btngotologin" class="" type="button" value="IR A SOMOS BELCORP" />--%>
                    </div>
                </div>
            </div>
        </div>
        <hr class="clear">
    </div>

</body>
</html>
