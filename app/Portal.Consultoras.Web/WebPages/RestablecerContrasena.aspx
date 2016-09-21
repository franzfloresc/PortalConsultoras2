<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestablecerContrasena.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RestablecerContrasena" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

     <!-- GR-1390 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="../Scripts/bootstrap.min.js"></script>
     <link href="../Content/Css/Mobile/theme.min.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/icomon.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/menu.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/style.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/General.js" type="text/javascript"></script>
    <link href="../Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" />

    <link href="../Content/Css/Site/Site.css" rel="stylesheet" />
    <link href="../Content/Css/Site/CambiarContrasena.css" rel="stylesheet" />
   

    <title>Restablecer Contraseña</title>

    <script>

        jQuery(document).ready(function () {

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

                        location.href = result.url;

                    }
                    else {

                        closeWaitingDialog();
                        var mensaje = "Error al realizar proceso, inténtelo más tarde.";
                      
                        AbrirAlerta(titulo, mensaje);

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
    
    <div id="loadingScreen"></div>
    <table style="width:100%;">
        <tr>
        <td style='width:100%; height: 56px; background:#F2F3F7;'><img class="imagencentrado" src="../Content/Images/logo_foot.png" alt="" /></td>
        </tr>
    </table>
    <form id="frmrestablecercontrasena" runat="server" class="frmrecuperaclave">

        <div id="idcontenedor" class="ws-campana text-center">
        
                <div class="ws-campana">
                    <p class="cambiarcontrasena">&nbsp;CAMBIAR CONTRASEÑA</p>
                </div>
                <div class="ocultar_hide">
                    <asp:TextBox ID="txtpaisid" runat="server" CssClass="txttexto"></asp:TextBox>
                    <asp:TextBox ID="txtcorreo" runat="server" CssClass="txttexto"></asp:TextBox>
                    <asp:TextBox ID="txtpaisiso" runat="server" CssClass="txttexto"></asp:TextBox>
                    <asp:TextBox ID="txtcodigousuario" runat="server" CssClass="txttexto"></asp:TextBox>
                    <asp:TextBox ID="txtcontrasenaanterior" runat="server" CssClass="txttexto"></asp:TextBox>
                </div>
                <div class="ws-campana">
                    <p id="idingresepais" class="ingresatunuevacontrasena">Ingresa tu nueva contraseña:</p>
                </div>
                <div class="ws-campana text-center">
                    <asp:TextBox ID="txtcontrasenanueva1" runat="server" CssClass="txttexto" TextMode="Password"></asp:TextBox>
                </div>
                <div class="ws-campana">
                    <p id="idingresatucorreo" class="ingresatunuevacontrasena">&nbsp;&nbsp;Confirma tu nueva contraseña:</p>
                </div>
                <div class="ws-campana text-center">
                    <asp:TextBox ID="txtcontrasenanueva2" runat="server" CssClass="txttexto" TextMode="Password"></asp:TextBox>
                </div>
           
                <div class="ws-campana text-center">
                    <div>
                        <input id="btncambiar" class="botonenviar" type="button" value="MODIFICAR CONTRASEÑA" />
                    </div>
                </div>
           
            </div>
        
    </form>

</body>
</html>

<div id="pnlError" style="display: none;" class="ws-campana text-center">
    <div id="iderror" class="color_black letrajustificada">
           
    </div>
</div>

<div id="pnlErrorPopup" style="display: none;" class="ws-campana text-center">
    <div id="iderrorpopup" class="color_black" style="text-align:justify; font-size:16px;">
           
    </div>
</div>
