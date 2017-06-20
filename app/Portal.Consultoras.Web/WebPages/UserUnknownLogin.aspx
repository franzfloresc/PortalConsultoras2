<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserUnknownLogin.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.UserUnknownLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W2QJJ5J');</script>
<!-- End Google Tag Manager -->
    <title>Belcorp | Portal Consultoras</title>
    <link href="~/Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg_modal">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-W2QJJ5J"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
    <form id="form1" runat="server">
        <div class="logo_modal">
            <a href="#" id="logo">
                <img src="../Content/Images/logo_belcorp.png" alt="" />
            </a>
        </div>
        <div class="wrap_modal">
            <div class="image_modal">
                <img src="../Content/Images/error_icono.png" alt="" />
            </div>
        </div>
        <div class="texto_modal">
            Lo sentimos, usted no es usuario del Portal
        </div>
        <div class="boton_modal">
            <div class="input_search">
                <asp:Button ID="btnRegresar" runat="server" OnClick="btnRegresar_Click" Text="Regresar" />
            </div>
        </div>
    </form>
</body>
</html>
