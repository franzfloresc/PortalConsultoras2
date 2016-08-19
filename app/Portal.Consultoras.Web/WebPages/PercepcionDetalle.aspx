<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PercepcionDetalle.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.PercepcionDetalle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::: Percepciones Detalle :::.</title>
    <link href="~/Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        * {
            font-family: Arial !Important;
        }
    </style>
</head>
<body style="background: none;">
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
    <form id="form1" runat="server">
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="wrap_cab">

            <div class="filtros" style="background: none;">
                <div class="elements_percepcion">
                    <div class="percepciones_left">
                        <h2 class="celeste_texto">
                            <asp:Label ID="lblRazonSocial" runat="server" Text=""></asp:Label></h2>
                        <div class="div-3 spacing_2">
                            <div class="titAuto2">
                                <asp:Label ID="lblDireccion" runat="server" Text=""></asp:Label></div>
                        </div>
                        <div class="div-3 spacing">
                            <div class="titAuto2">Señor(es):</div>
                            <div class="titAuto2">
                                <asp:Label ID="lblNombreAgentePerceptor" runat="server" Text=""></asp:Label></div>
                        </div>
                        <div class="div-3 spacing">
                            <div class="titAuto2">RUC/DNI:</div>
                            <div class="titAuto2">
                                <asp:Label ID="lblRUCAgentePerceptor" runat="server" Text=""></asp:Label></div>
                        </div>
                        <div class="div-3 spacing">
                            <div class="titAuto2">Fecha de Emisión:</div>
                            <div class="titAuto2">
                                <asp:Label ID="lblFechaEmision" runat="server" Text=""></asp:Label></div>
                        </div>
                    </div>
                    <div class="percepciones_right">
                        <div class="div-3 spacing">
                            <div class="titAuto2">RUC:</div>
                            <div class="titAuto2">
                                <asp:Label ID="lblRUC" runat="server" Text=""></asp:Label></div>
                        </div>
                        <h2 class="celeste_texto">Comprobante de Percepciones Venta Interna</h2>
                        <div class="div-3 spacing">
                            <div class="titAuto2">Nro:</div>
                            <div class="titAuto2">
                                <asp:Label ID="lblNumeroComprobanteSerie" runat="server" Text=""></asp:Label></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="wrap">
            <div class="container_percepcion clearfix">
                <div class="border-wrapper">
                    <div id="gvwDetalleCampania" class="tabla">
                        <asp:Literal ID="lTabla" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="sep"></div>
                <div class="div-3">
                    <div class="total">Total: <span class="superindice">
                        <asp:Label ID="lblSimbolo" runat="server" Text=""></asp:Label></span><span class="num"><asp:Label ID="lblImportePercepcion" runat="server" Text=""></asp:Label></span></div>
                    <div style="width: 20px; float: right;">&nbsp</div>
                    <div class="total_white">
                        Son:
                        <asp:Label ID="lblImportePercepcionTexto" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <div class="div-3 spacing">
                    <div class="titAuto2">Nro. autorzación impresión de SUNAT: 2247770011</div>
                </div>
                <div class="div-3 spacing">
                    <div class="titAuto2">Fecha autorización: 27/01/2011</div>
                </div>
                <div class="div-3 spacing">
                    <div class="titAuto2">Serie 001 - del 8000001 hasta - 99999999</div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
