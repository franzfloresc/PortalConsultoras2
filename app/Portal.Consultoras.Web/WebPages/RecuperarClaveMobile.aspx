<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarClaveMobile.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RecuperarClaveMobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <script src="../Scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/General.js" type="text/javascript"></script>
    <link href="../Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" />
    <link href="../Content/Css/Site/Site.css" rel="stylesheet" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" />

     <!--Inicio GR-1390 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="../Scripts/bootstrap.min.js"></script>
     <link href="../Content/Css/Mobile/theme.min.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/icomon.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/menu.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/style.css" rel="stylesheet" />

    <link href="../Content/Css/Site/CambiarContrasena.css" rel="stylesheet" />

    <!--Fín GR-1390 -->

     <title>Recuperar Clave</title>
</head>

    <script>

      
        jQuery(document).ready(function () {

            //GR-1390 - Inicio Mobile

            $("#ddlPaisMobile").change(function () {

                if (this.selectedIndex == 5) {
                    $('#divSiTienesA').hide();
                    $('.ingresatucorreo').html("Ingrese su Num de Cédula:");
                }
                else {
                    $('#divSiTienesA').show();
                    $('.ingresatucorreo').html("Ingresa tu correo electrónico");
                }
                $("#txtEmailMobile").val("");
                $("#txtEmailMobile").focus();
            });
            // 1985 - Fin
            $("#btnRecordarMobile").click(function () {
                RecordarClaveMobile();
            });

            $("#txtEmailMobile").on("keypress", function (evt) {

                if (evt.keyCode === 13) {
                    RecordarClaveMobile();
                }

            });

            $("#txtEmailMobile").keypress(function (evt) {

                var charCode = (evt.which) ? evt.which : window.event.keyCode;
                if (charCode <= 13) {
                    return true;
                }
                else {
                    var keyChar = String.fromCharCode(charCode);
                    var re = /[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ_.@@-]/;
                    return re.test(keyChar);
                }
            });

            //GR-1390 - Fín Mobile

        });

        //GR-1390 - Inicio Mobile

        function RecordarClaveMobile() {

            var titulo = "Error";
            var vMessage = "";
            if (jQuery.trim($('#ddlPaisMobile').val()) == "0") {
                vMessage += "Debe seleccionar país.\n";
                $('#txtEmailMobile').focus();

                $('#iderror').html(vMessage);//GR-1390
                AbrirAlertaMobile_3(titulo);//GR-1390

                return false;

            } // 1985 - Inicio
            if (jQuery.trim($('#txtEmailMobile').val()) == "") {
                if (jQuery.trim($('#ddlPaisMobile').val()) == "4") {
                    vMessage += "Debe ingresar el Número de Cédula.\n";
                } else {
                    vMessage += "Debe ingresar EMail.\n";
                }
                $('#txtEmailMobile').focus();

                $('#iderror').html(vMessage); //GR-1390
                AbrirAlertaMobile_3(titulo); //GR-1390

                return false;

            } // 1985 - Fin
            if (jQuery.trim($('#txtEmailMobile').val()) != "4") {
                if (!validateEmail(jQuery.trim($('#txtEmailMobile').val()))) {
                    vMessage += "El formato del correo electrónico ingresado no es correcto.\n";
                    $('#txtEmailMobile').focus();

                    $('#iderror').html(vMessage); //GR-1390
                    AbrirAlertaMobile_3(titulo); //GR-1390

                    return false;
                }
            }

            if (jQuery.trim($('#ddlPaisMobile').val()) == "4") {
                if (validateEmail(jQuery.trim($('#txtEmailMobile').val()))) {
                    vMessage += "Debe ingresar el Número de Cédula.\n";

                    $('#iderror').html(vMessage); //GR-1390
                    AbrirAlertaMobile_3(titulo); //GR-1390

                    $('#txtEmailMobile').val("");
                    $('#txtEmailMobile').focus();

                    return false;
                }
            }

            var IdPais = $('#ddlPaisMobile').val();
            var Correo = $('#txtEmailMobile').val();
            var item = {
                IdPais: IdPais,
                Correo: Correo
            };

            waitingDialog({});

            RecuperarClaveCSMobile(JSON.stringify(item), function (output, context) {
                var result = JSON.parse(output);
                if (result.succes == true) {
                    closeWaitingDialog();

                    if (result.pais == 4) {

                        $("#pnlExitoMobile .color_black").html(result.mensaje);
                    }

                    location.href = result.url; // GR-1390
                }
                else {
                    if (result.pais == 4) {
                        closeWaitingDialog();
                        $("#pnlErrorMobile .color_black").html(result.mensaje);
                        AbrirAlertaMobile_3(titulo);
                        return false;
                    } else {
                        if (result.estado == "2") {
                            closeWaitingDialog();
                            $('#lblNroTelefonoMobile').html(result.numero)
                            AbrirAlertaMobile_2();
                            return false;
                        }
                        else {
                            closeWaitingDialog();
                            $("#pnlErrorMobile .color_black").html("Error al realizar proceso, inténtelo mas tarde.");
                            AbrirAlertaMobile_3(titulo);
                            return false;
                        }
                    }
                }
                LimpiarMobile();
                return false;
            });
        }
        function LimpiarMobile() {
            $('#ddlPaisMobile').val("0");
            $('#txtEmailMobile').val("");
        }
        function AbrirAlertaMobile_1() {
            $('#pnlExitoMobile').dialog({
                modal: true,
                width: 320,
                title: 'Recuperación de clave',
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                responsive: true,
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlExitoMobile').dialog("close");
                    }
                }
            });
        }
        function AbrirAlertaMobile_2() {
            $('#pnlNoEncontradoMobile').dialog({
                modal: true,
                width: 320,
                title: 'Correo no Identificado',
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlNoEncontradoMobile').dialog("close");
                    }
                }
            });
        }
        function AbrirAlertaMobile_3(titulo) {
            $('#pnlErrorMobile').dialog({
                modal: true,
                width: 320,
                title: titulo,
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlErrorMobile').dialog("close");
                    }
                }
            });
        }

        //GR-1390 - Fín Mobile

</script>

<body class="bodyrecuperaclave">
    <!--R2469 (CSR) Nueva  Etiquetas de Seguimiento-->
    <!-- Google Tag Manager -->
    <noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-M8QMC8"
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <script>(function (w, d, s, l, i) {
    w[l] = w[l] || []; w[l].push({
        'gtm.start':
        new Date().getTime(), event: 'gtm.js'
    }); var f = d.getElementsByTagName(s)[0],
    j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : ''; j.async = true; j.src =
    '//www.googletagmanager.com/gtm.js?id=' + i + dl; f.parentNode.insertBefore(j, f);
})(window, document, 'script', 'dataLayer', 'GTM-M8QMC8');</script>
    <!-- End Google Tag Manager -->
    <div id="loadingScreen"></div>
    <!--Inicio GR-1390 -->
    <div id="tblMobile" style="width:100%;background:#F2F3F7;">
        <img class="imagencentrado" src="../Content/Images/logo_foot.png" alt="" />
    </div>
    <!--Fín GR-1390 -->
    <form id="form1" runat="server">
        <!--Inicio GR-1390 - Mobile -->

         <div id="idcontenedor" class="ws-campana text-center">
        
                <div class="ws-campana">
                    <p class="cambiarcontrasena">CAMBIAR CONTRASEÑA</p>
                </div>
                <div class="ws-campana">
                    <p id="idingresepais" class="ingresetupais">Ingrese tu país</p>
                </div>
                <div id="idpais" class="ws-campana text-center combopais">
                    <asp:DropDownList ID="ddlPaisMobile" runat="server"></asp:DropDownList>
                </div>
                <div class="ws-campana">
                    <p id="idingresatucorreo" class="ingresatucorreo">Ingresa tu correo electrónico</p>
                </div>
                <div class="ws-campana text-center">
                    <asp:TextBox ID="txtEmailMobile" AutoComplete="off" runat="server" CssClass="txttexto"></asp:TextBox>
                </div>
           
                <div class="ws-campana text-center">
                    <div>
                        <input id="btnRecordarMobile" class="botonenviar" type="button" value="Enviar" />
                    </div>
                </div>
           
            </div>

         <!--Fín GR-1390 - Mobile -->
    </form>

    <!--GR-1390 Incio Mobile-->

    <div id="pnlExitoMobile" style="display: none;" class="ws-campana text-center">
        <div class="color_black letrajustificada">
            Te hemos enviado una nueva clave a tu correo electrónico.
        </div>
    </div>
    <div id="pnlErrorMobile" style="display: none;" class="ws-campana text-center">
        <div id="iderror" class="color_black letrajustificada">
            Error al realizar proceso, inténtelo mas tarde.
        </div>
    </div>
    <div id="pnlNoEncontradoMobile" style="display: none;" class="ws-campana text-center">
        <div class="color_black letrajustificada">
            NO HEMOS IDENTIFICADO TU CORREO ELECTRONICO POR FAVOR COMUNICATE CON <b><a href="http://belcorpresponde.somosbelcorp.com" target="_blank">BELCORP RESPONDE</a></b>
            <asp:Label ID="lblNroTelefonoMobile" runat="server" Text="Label" Visible="false"></asp:Label>
        </div>
    </div>

    <!--GR-1390 Fín Mobile-->


</body>
</html>
