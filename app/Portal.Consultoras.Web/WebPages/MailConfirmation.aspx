<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailConfirmation.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.MailConfirmation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
    <script src="<%=ResolveUrl("~/Scripts/jquery-1.11.2.min.js")%>"></script>
</head>
<body class="bg_modal">
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
})(window, document, 'script', 'dataLayer', 'GTM-M8QMC8');
    </script>
    <!-- End Google Tag Manager -->

    <form id="form1" runat="server">
        <div class="logo_modal">
            <a href="#" id="logo">
                <img src="../Content/Images/logo_belcorp.png" alt="" />
            </a>
        </div>
        <div class="texto_modal">
            <div>
                <asp:Label ID="lblConfirmacion" runat="server"></asp:Label>
            </div>
        </div>

        <div id="img" style="text-align:left">

         <asp:HyperLink id="lnkClienteCC" runat="server" ImageUrl="../Content/Images/afiliacion/banner01_ccc.jpg"
            ImageWidth="750" ImageHeight="170" NavigateUrl="~/ClienteContactaConsultora"   />
        </div>

    </form>

</body>
</html>

<script type="text/javascript">
    $(document).ready(function () {

        dataLayer.push({ 'event': 'virtualEvent', 'category': 'CCC', 'action': 'Confirmar correo', 'label': 'Satisfactorio' });

    });
</script>


