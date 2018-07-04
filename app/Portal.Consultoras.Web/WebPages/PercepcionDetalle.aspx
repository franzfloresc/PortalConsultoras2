<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PercepcionDetalle.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.PercepcionDetalle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::: Percepciones Detalle :::.</title>
    <link href="../Content/Css/Site/Esika/reset.css" rel="stylesheet" />    
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,300,700,900" rel="stylesheet" type="text/css" />

    <link href="../Content/Css/Site/Esika/style.css" rel="stylesheet" />
    <link href="../Content/Css/Site/calc.css" rel="stylesheet" />
    <link href="../Content/Css/ui.jquery/Esika/jquery-ui.css" rel="stylesheet" />
</head>
<body style="background-color: white;">
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
    <div class="contenedor_popup_percepciones" style="display: block!important; background: none!important;">
        <div class="popup_Percepcion" style="width: 100%!important;">
            <div class="content_popUp">
                <div class="contenedor_bloque_datos">
                    <div class="datos_cliente">
                        <h2>
                            <asp:Label ID="lblRazonSocial" runat="server" Text=""></asp:Label></h2>
                        <div class="direccion_cliente">
                            <asp:Label ID="lblDireccion" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="bloque_datos">
                            <div class="nombre_cliente">
                                <span>Señor(es):</span>
                            </div>
                            <div class="documento_cliente">
                                <span>RUC/DNI:</span>
                            </div>
                            <div class="fecha_emision">
                                <span>Fecha de Emisión:</span>
                            </div>
                        </div>
                        <div class="bloque_datos margen-izquierdo">
                            <div class="nombre_cliente">
                                <span>
                                    <asp:Label ID="lblNombreAgentePerceptor" runat="server" Text=""></asp:Label></span>
                            </div>
                            <div class="documento_cliente">
                                <span>
                                    <asp:Label ID="lblRUCAgentePerceptor" runat="server" Text=""></asp:Label></span>
                            </div>
                            <div class="fecha_emision">
                                <span>
                                    <asp:Label ID="lblFechaEmision" runat="server" Text=""></asp:Label></span>
                            </div>
                        </div>
                    </div>
                    <div class="datos_empresa">
                        <div class="ruc_cliente">
                            <span>RUC:</span>
                            <span>&nbsp;<asp:Label ID="lblRUC" runat="server" Text=""></asp:Label></span>
                        </div>
                        <div class="comprobante_percepciones">
                            <span>COMPROBANTE DE PERCEPCIONES VENTA INTERNA</span>
                        </div>
                        <div class="numero_comprobante">
                            <span>Nro:</span>
                            <span>&nbsp;<asp:Label ID="lblNumeroComprobanteSerie" runat="server" Text=""></asp:Label></span>
                        </div>
                    </div>
                </div>
                <div class="linea_separadora" style="height: 2px;"></div>
                <div class="content_datos_percepciones">
                    <div class="tipo texto_gris_popup padding_tabla_percepcion">Tipo</div>
                    <div class="serie texto_gris_popup padding_tabla_percepcion">Serie</div>
                    <div class="correlativo texto_gris_popup padding_tabla_percepcion">Correlativo</div>
                    <div class="fechaEmision texto_gris_popup padding_tabla_percepcion">Fecha Emisión Documento</div>
                    <div class="precioVenta texto_gris_popup padding_tabla_percepcion">Precio de Venta (S/.)</div>
                    <div class="porcentajePercepcion texto_gris_popup padding_tabla_percepcion">Porcentaje de Percepción</div>
                    <div class="importePercepcion texto_gris_popup padding_tabla_percepcion">Importante Percepciones (S/.)</div>
                    <div class="montoTotalPercepcion texto_gris_popup padding_tabla_percepcion">Monto Total (S/.)</div>
                </div>
                <div class="linea_separadora" style="margin-top: -1px"></div>
                <!--CONTENIDO DE TABLAS PERCEPCIÓN-->
                <div style="max-height: 419px; overflow: auto;">
                    <asp:Literal ID="lTabla" runat="server"></asp:Literal>
                </div>
                <div class="linea_separadora_roja" style="height: 2px;"></div>
                <div class="content_datos_percepciones">
                    <div class="totalTexto texto_bold">TOTAL:</div>
                    <div class="totalNumero texto_bold">
                        <asp:Label ID="lblSimbolo" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblImportePercepcion" runat="server" Text=""></asp:Label>
                    </div>
                </div>
                <!--FIN CONTENIDO TABLAS PERCEPCIÓN-->
                <div class="linea_separadora" style="height: 1px;"></div>
                <div class="datos_impresion">
                    <div class="numeroAutorizacion">
                        <span>Nro. autorización impresión de SUNAT:&nbsp;&nbsp;</span><span>2247770011</span>
                    </div>
                    <div class="fechaAutorizacion">
                        <span>Fecha autorización:&nbsp;&nbsp;</span><span>27/01/2011</span>
                    </div>
                    <div class="numeroSerieImpresion">
                        <span>Serie:&nbsp;&nbsp;</span><span>001</span>&nbsp;-&nbsp;del&nbsp;<span>8000001</span>&nbsp;hasta&nbsp;-&nbsp;<span>999999999</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
</html>
