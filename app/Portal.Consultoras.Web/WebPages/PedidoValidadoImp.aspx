<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PedidoValidadoImp.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.PedidoValidadoImp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <title>Belcorp | Portal Consultoras</title>

    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../Content/Css/ui.jqgrid/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" type="text/css" />

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
            	<div class="top_head1" id="userWelcome"><asp:Label ID="lblUsuario" runat="server"></asp:Label></div>
            	<div class="top_head2">
                  	<ul>
                    	<li>Mis Datos</li>
                    	<li>Ayuda</li>
                    	<li>Cerrar Sesión</li>
                    </ul>
                </div>
            	<div class="top_head3">
				
                </div>
            	<div class="top_head4">
                	<div class="pais">
                    <asp:Image ID="imgBandera" runat="server" />
                    <p><asp:Label ID="lblNombrePais" runat="server"></asp:Label></p>
                    </div>
                </div>
            </div>
            
			<a href="#" id="logo">
                <img src="../Content/Images/logo_belcorp.png" alt="" id="imgLogo" />
			</a>
                
                  <a class="toggleMenu" href="#">Menu</a>
                  <div class="menu_responsive">
                      
                  </div>
		</div>

	</header>
        </div>
        <div class="wrap_cab">
            <div class="filtros">
                <div class="elements">
                    <div class="div-1">
                    </div>
                    <div class="div-2">
                        <h1>Pedido validado con éxito</h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="wrap">
            <div class="container clearfix">

                <div class="top_tabla">
                    <div class="email" onclick="EnviarCorreo()" style="cursor: pointer;">E-mail</div>
                    <div class="imprimir" onclick="Imprimir()" style="cursor: pointer;">Imprimir</div>
                </div>

                <div class="border-wrapper">
                    <div id="divListadoPedido" class="tabla">
                        <asp:Literal ID="lTabla" runat="server"></asp:Literal>
                    </div>
                </div>

                <%--<div class="sep"></div>
                <div class="elements2">
                    <div class="div-3">
                        <div class="input_modifica">
                            <input type="submit" name="" id="btnModificarPedido" value="Modifica tu Pedido" />
                        </div>
                        <div class="total">
                            Monto Total: <span id="sSimbolo" class="superindice">
                                <asp:Label ID="lblSimbolo" runat="server"></asp:Label></span><span id="sTotal" class="num"><asp:Label ID="lblTotal" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </div>--%>

                <div class="sep"></div>
                <div class="div-3">
                    <div class="input_modifica_pedido" style="width:10px; float: left;">
                        <div class="tooltip_left">
                            <input type="button" name="" id="btnModificarPedido" value="Modifica tu Pedido" />
                        </div>
                    </div>
                    
                    <asp:Literal ID="lDescuentoCuv" runat="server"></asp:Literal>
                    <div class="total">
                        Monto Total: <span class="superindice"><asp:Label ID="lblSimbolo" runat="server"></asp:Label></span>
                        <span id="sTotal" class="num"><asp:Label ID="lblTotal" runat="server"></asp:Label></span>
                    </div>
                </div>
                
                <div class="sep"></div>
                <div class="banner-wrapper">
                    <div class="one-fourth" style="display: none">
                        <img src="~/Content/Images/ban-1.png" class="ajust" />
                    </div>
                    <!--/ .one-fourth-->

                    <div class="one-fourth">
                        <img src="../Content/Images/banner_productos_exclusivos.jpg" class="ajust" />
                    </div>
                    <!--/ .one-fourth-->

                    <div class="one-fourth" style="display: none">
                        <img src="~/Content/Images/ban-3.png" class="ajust" />
                    </div>
                    <!--/ .one-fourth-->

                    <div class="one-fourth last">
                        <img src="../Content/Images/banner_producto agotado.jpg" class="ajust" />
                    </div>
                    <!--/ .one-fourth-->
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
                        <img src="../Content/Images/ban-logo.png" />
                    </div>
                    <div class="responde">
                        <asp:Image ID="imgLogoResponde" runat="server" />
                    </div>
                </div>

            </div>
            <footer id="footer">
		
		<div class="container clearfix">
			<div class="foot_list">
                <label>Links</label>
                <ol>
                <li>Ingresa tu Pedido</li>
                <li>Catálogo Virtual</li>
                <li>Estado de Cuenta</li>
                <li>Productos agotados</li>
                <li>CAPEDEVI</li>
                <li>Clientes</li>
                <li>Superate</li>
                <li>Mis Datos</li>
                <li>Ayuda</li>
                <li>Términos y Condiciones</li>
                </ol>
            </div>
			<div class="foot_social">
            	<label>Síguenos</label>
				<p><img src="../Content/Images/ico_facebook.png" /></p>
			</div>
			<div class="foot_belcorp">
                <p><img src="../Content/Images/logo_foot.png"></p>
				<p>Copyright Belcorp 2012. All rights reserved</p>
			</div>
		</div>
	</footer>
        </div>
        <script type="text/javascript" src="~/Scripts/jqueryslidemenu.js"></script>
        <script type="text/javascript" src="~/Scripts/jquery.easing.1.3.js"></script>
        <script type="text/javascript" src="~/Scripts/trans-banner.js"></script>
        <script type="text/javascript" src="~/Scripts/jquery.touchSwipe.min.js"></script>
        <script type="text/javascript" src="~/Scripts/custom.js"></script>
    </form>
</body>
</html>
