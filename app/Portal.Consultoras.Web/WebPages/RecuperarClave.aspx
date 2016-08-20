<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarClave.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RecuperarClave" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <script src="../Scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/General.js" type="text/javascript"></script>
    <link href="../Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" />
    <link href="../Content/Css/Site/Site.css" rel="stylesheet" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" />
    <title>Recuperar Clave</title>
</head>

<script>

    var _gaq = _gaq || [];
    //_gaq.push(['_setAccount', 'UA-38299403-1']);
    //_gaq.push(['_setDomainName', 'none']);
    //_gaq.push(['_setAllowLinker', true]);
    //_gaq.push(['_trackPageview']);

    //(function () {
    //    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    //    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    //    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    //})();

    jQuery(document).ready(function () {

        $('#divSiTienesA').show();
        // 1985 - Inicio
        $("#ddlPais").change(function () {
            if (this.selectedIndex == 5) {
                $('#divSiTienesA').hide();
                $('.titJ_2').html("2. Ingrese su Num de Cédula:");
            }
            else {
                $('#divSiTienesA').show();
                $('.titJ_2').html("2. Ingresa el correo electrónico que registraste:");
            }
            $("#txtEmail").val("");
            $("#txtEmail").focus();
        });
        // 1985 - Fin
        $("#btnRecordar").click(function () {
            RecordarClave();
        });

        $("#txtEmail").keypress(function (evt) {
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
    });

    function RecordarClave() {
        var vMessage = "";
        if (jQuery.trim($('#ddlPais').val()) == "0") {
            vMessage += "- Debe seleccionar país.\n";
            $('#txtEmail').focus();
            alert(vMessage);
            return false;
        } // 1985 - Inicio
        if (jQuery.trim($('#txtEmail').val()) == "") {
            if (jQuery.trim($('#ddlPais').val()) == "4") {
                vMessage += "- Debe ingresar el Número de Cédula.\n";
            } else {
                vMessage += "- Debe ingresar EMail.\n";
            }
            $('#txtEmail').focus();
            alert(vMessage);
            return false;
        } // 1985 - Fin
        if (jQuery.trim($('#ddlPais').val()) != "4") {
            if (!validateEmail(jQuery.trim($('#txtEmail').val()))) {
                vMessage += "- El formato del correo electrónico ingresado no es correcto.\n";
                $('#txtEmail').focus();
                alert(vMessage);
                return false;
            }
        }

        var IdPais = $('#ddlPais').val();
        var Correo = $('#txtEmail').val();
        var item = {
            IdPais: IdPais,
            Correo: Correo
        };

        waitingDialog({});

        RecuperarClaveCS(JSON.stringify(item), function (output, context) {
            var result = JSON.parse(output);
            if (result.succes == true) {
                closeWaitingDialog();
                $("#pnlExito .color_red").html("Te hemos enviado una nueva clave a tu correo electrónico.");
                if (result.pais == 4) {
                    $("#pnlExito .color_red").html(result.mensaje);
                }
                AbrirAlerta_1();
                return false;
            }
            else {
                if (result.pais == 4) {
                    closeWaitingDialog();
                    $("#pnlError .color_red").html(result.mensaje);
                    AbrirAlerta_3();
                    return false;
                } else {
                    if (result.estado == "2") {
                        closeWaitingDialog();
                        $('#lblNroTelefono').html(result.numero)
                        AbrirAlerta_2();
                        return false;
                    }
                    else {
                        closeWaitingDialog();
                        $("#pnlError .color_red").html("Error al realizar proceso, inténtelo mas tarde.");
                        AbrirAlerta_3();
                        return false;
                    }
                }
            }
            Limpiar();
            return false;
        });
    }
    function Limpiar() {
        $('#ddlPais').val("0");
        $('#txtEmail').val("");
    }
    function AbrirAlerta_1() {
        $('#pnlExito').dialog({
            modal: true,
            width: 650,
            title: 'Recuperación de clave',
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
        $('#pnlNoEncontrado').dialog({
            modal: true,
            width: 350,
            title: 'Correo no Identificado',
            closeOnEscape: false,
            resizable: false,
            show: "slide",
            hide: "silde",
            position: "center",
            buttons: {
                Aceptar: function () {
                    $('#pnlNoEncontrado').dialog("close");
                }
            }
        });
    }
    function AbrirAlerta_3() {
        $('#pnlError').dialog({
            modal: true,
            width: 500,
            title: 'Recuperación de Clave',
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
</script>
<body class="bg_modal">
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
    <form id="form1" runat="server">
        <div class="logo_modal">
            <a href="#" id="logo">
                <img src="../Content/Images/logo_belcorp.png" alt="" />
            </a>
        </div>
        <div class="content_password">
            <div class="content_password_text_1">¿Olvidaste tu clave secreta?</div>
            <div class="content_password_text_2">Te enviaremos una nueva clave a tu correo electrónico. Sigue los siguientes pasos:</div>
            <div class="div-3">
                <div class="titJ">1. Selecciona tu país:</div>
                <div class="selectLogin borde_redondeado">
                    <asp:DropDownList ID="ddlPais" runat="server"></asp:DropDownList>
                </div>
            </div>
            <div class="div-3">
                <div class="titJ_2">2. Ingresa el correo electrónico que registraste:</div>
                <div class="selectLogin borde_redondeado">
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="div-3">
                <div class="titJ">3. Haz click en [Enviar clave]</div>
                <div class="btn_ingresar">
                    <input id="btnRecordar" type="button" value="Enviar clave" />
                </div>
            </div>

            <div id="divSiTienesA" style="display:none">
                <div class="content_password_text_2  ">
                    Si tienes algún problema por favor comunícate a <a href="http://belcorpresponde.somosbelcorp.com/" target="_blank">BELCORP RESPONDE</a>
                </div>
            </div>
        </div>
    </form>
    <div id="pnlExito" style="display: none;">
        <div class="color_red">
            Te hemos enviado una nueva clave a tu correo electrónico.
        </div>
    </div>
    <div id="pnlError" style="display: none;">
        <div class="color_red" style="text-align:left">
            Error al realizar proceso, inténtelo mas tarde.
        </div>
    </div>
    <div id="pnlNoEncontrado" style="display: none;">
        <div class="color_red">
            NO HEMOS IDENTIFICADO TU CORREO ELECTRONICO POR FAVOR COMUNICATE CON <a href="https://www2.somosbelcorp.com/belcorpresponde/belcorp-responde.asp" target="_blank">BELCORP RESPONDE</a>
            <asp:Label ID="lblNroTelefono" runat="server" Text="Label" Visible="false"></asp:Label>
        </div>
    </div>
</body>
</html>
