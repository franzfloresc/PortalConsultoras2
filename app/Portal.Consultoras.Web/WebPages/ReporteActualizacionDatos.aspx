﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReporteActualizacionDatos.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.ReporteActualizacionDatos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <title>Belcorp | Portal Consultoras</title>

    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../Content/Css/ui.jqgrid/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        window.history.forward();
        function noBack() { window.history.forward(); }
    </script>
    <script type="text/javascript" src="~/Scripts/maskedinput.js"></script>
    <script type="text/javascript" src="~/Scripts/General.js"></script>

    <!-- HTML5 Shiv -->
    <script type="text/javascript" src="~/Scripts/modernizr.custom.js"></script>
    <!-- jquery library -->

    <!--[if lt IE 9]>
	<script src="~/Scripts/selectivizr-and-extra-selectors.min.js"></script>
	<script src="~/Scripts/IE8.js"></script>
    <![endif]-->
    <script type="text/javascript" src="~/Scripts/jqueryslidemenu.js"></script>

    <script type="text/javascript" src="~/Scripts/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="~/Scripts/jquery.touchSwipe.min.js"></script>
    <script type="text/javascript" src="~/Scripts/jquery.cycle.all.min.js"></script>
    <script type="text/javascript" src="~/Scripts/respond.min.js"></script>
    <script type="text/javascript" src="~/Scripts/trans-banner.js"></script>

    <style type="text/css">
        * {
            font-family: Arial !Important;
        }
    </style>
</head>
<body>
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
        <div class="wrap_cab">
            <!-- ***************** - Header - ***************** -->
            <header id="header">
                <div class="container clearfix">

                    <div class="top_head">
                        <div class="top_head1" id="userWelcome">
                            <asp:Label ID="Usuario" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="top_head2">
                        </div>
                        <div class="top_head3">
                            <div class="top_head3_input">
                                <input type="text" name="search" id="search" />
                            </div>
                            <div class="top_head3_btn">
                                <input type="submit" class="btn_search" id="submit" value="" />
                            </div>
                        </div>
                        <div class="top_head4">
                            <div class="pais">
                                <asp:Image ID="imgBandera" runat="server" />
                                <p>
                                    <asp:Label ID="lblNombrePais" runat="server"></asp:Label>
                                </p>

                            </div>
                        </div>
                    </div>
                    <a href="index.html" id="logo">
                        <img src="../Content/Images/logo_belcorp.png" alt="" /></a>
                </div>
            </header>
            <!--/ #header -->
            <!-- ***************** -/ end Header - ***************** -->
        </div>
        <div class="wrap_cab">
            <div class="filtros">
                <div class="elements">
                    <div class="div-2">
                        <h1>Reporte de <span>Actualización de Datos</span></h1>
                    </div>
                    <div class="div-3">
                        <div class="titG">Pais:</div>
                        <div class="selectA borde_redondeado">
                            <asp:DropDownList ID="ddlPais" runat="server"></asp:DropDownList>
                        </div>
                        <div class="titG">Fecha:</div>
                        <div class="calendar_filtros borde_redondeado">
                            <asp:TextBox ID="txtFechaSolicitud" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="div-3">
                        <div class="titG">Zona:</div>
                        <div class="selectA borde_redondeado">
                            <asp:DropDownList ID="ddlZonas" runat="server"></asp:DropDownList>
                        </div>
                        <div class="titG">Sección:</div>
                        <div class="selectA borde_redondeado">
                            <asp:TextBox ID="txtSeccion" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="div-3">
                        <div class="titG">Código Consultora:</div>
                        <div class="selectA borde_redondeado">
                            <asp:TextBox ID="txtDocumento" runat="server"></asp:TextBox>
                        </div>
                        <div class="titG">Estado:</div>
                        <div class="selectA borde_redondeado">
                            <asp:DropDownList ID="ddlEstadoSolicitud" runat="server">
                                <asp:ListItem Text="-- Todos --" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Enviado" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Pendiente" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="div-3">
                        <div class="titG"></div>
                        <div class="input_search">
                            <input id="btnBuscar" value="Buscar" type="button" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="wrap">
            <div class="container clearfix">
                <div class="border-wrapper">
                    <div class="tabla">
                        <asp:Literal ID="lTabla" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="div-3">
                    <div class="titAuto">
                        <div class="input_horizontal">
                            <input id="btnImprimir" type="button" value="Imprimir" />
                            <input id="btnExcel" type="button" value="Excel" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="wrap">
            <div class="container clearfix">
                <div class="b_responde">
                    <div class="logos">
                        <img src="../Content/Images/ban-5.png" />
                        <img src="../Content/Images/ban-6.png" />
                        <img src="../Content/Images/ban-7.png" />
                    </div>
                    <div class="responde">
                        <asp:Image runat="server" ID="imgLogoResponde" />
                    </div>
                </div>
            </div>
            <!--/ .container -->

            <footer id="footer">
                <div class="container clearfix">
                    <div class="foot_list">
                    </div>
                    <div class="foot_social">
                        <label>Síguenos</label>
                        <p>
                            <img src="../Content/Images/ico_facebook.png" />
                        </p>
                        <p>
                            <img src="../Content/Images/ico_twitter.png" />
                        </p>
                    </div>
                    <div class="foot_belcorp">
                        <p>
                            <img src="../Content/Images/logo_foot.png">
                        </p>
                        <p><strong>Av. República de Panamá 3664 - San Isidro</strong></p>
                        <p><strong>Central Telefónica: 519 20 00</strong></p>
                        <p>Copyright Belcorp 2012. All rights reserved</p>
                    </div>
                </div>
            </footer>
            <!--/ #footer -->
        </div>
    </form>
</body>
</html>

