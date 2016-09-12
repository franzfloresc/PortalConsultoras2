<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NavidadConsultora.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.NavidadConsultora" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta property="og:title" content="Guía de regalos" />
    <meta property="og:description" content=" Aprovecha la Campaña navideña y consigue más pedidos compartiendo catálogos por Facebook con tus clientes y amigos." />
    <meta property="og:site_name" content=" Somos Belcorp" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
    <link href="../Content/Css/Site/NavidadConsultora.css" rel="stylesheet" type="text/css" />
</head>
<script>
    function MetaImg() {
        var metas = document.getElementsByTagName('meta');

        for (i = 0; i < metas.length; i++) {
            if (metas[i].getAttribute("property") == "og:image") {
                document.getElementById('imgComparte').src = metas[i].getAttribute("content");
                return true;
            }
        }
    };
</script>
<body onload="MetaImg()">
    <div class="wrap_cab">
        <header id="header">
            <div class="container clearfix">
                <div class="top_head"></div>
                <a href="/Bienvenida" id="logo" rel="logo" title="Belcorp">
                    <img src="../Content/Images/logo_belcorp.png" alt="" id="imgLogo">
                </a>
            </div>
        </header>

    </div>
    <div class="wrap_cab">
        <div class="filtros">
            <div class="elements">
                <div class="productos_fixed">
                    <div class="productos_fixed_main">
                        <div class="div-2">
                            <h1>Guía de regalos <span></span></h1>
                            <div>
                                <div>Aprovecha la Campaña navideña y consigue más pedidos compartiendo catálogos por Facebook con tus clientes y amigos.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrap">
        <div class="container clearfix">
            <div class="centrar">
                <img id="imgComparte"/>
            </div>
        </div>
    </div>
    </body>
</html>
