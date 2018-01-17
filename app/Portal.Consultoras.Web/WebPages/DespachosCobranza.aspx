<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DespachosCobranza.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.DespachosCobranza" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

    <title>Información de Despachos de Cobranzas</title>

    <style type="text/css">
        .content_despacho {
            width: 520px;
            margin: 0px auto;
            text-align: left;
            padding: 2px 0px 10px 0px;
            font-size: 18px;
            line-height: 20px;
            color: #6C207F;
        }

        .content_despacho_informacion {
            width: 100%;
            margin: 0px auto;
            text-align: left;
            padding: 2px 0px 10px 0px;
            font-size: 18px;
            line-height: 20px;
            color: #6C207F;
        }
            .content_despacho_informacion hr { border-bottom-color: black; }

        .titulo {
            color: #00A2E8;
            font-size: 22px;
            padding: 0px 0px 0px 0px;
        }

        .columna1
        {
            width: 400px;
            float: left;
            padding-left: 150px;
        }

        .columna2
        {
            width: 400px;
            float: left;
            padding-left: 150px;
        }

        .columna3
        {
            width: 400px;
            float: left;
            padding-left: 150px;
        }

        .texto1 {
            width: 300px;
            height: auto;
            color: #702789;
            font-size: 12px;
            text-align: left;
            padding-top: 20px;
            font-weight: bold;
        }

        .texto2 {
            color: #555;
            font-size: 12px;
            text-align: left;
        }

        .separador {
            color: #555;
            font-size: 15px;
            text-align: center;
            padding-top: 80px;
        }

        .tituloBoton {
            color: #702789;
            font-size: 13px;
            text-align: left;
            font-weight: bold;   
            /*position:absolute;*/
            /*padding-left:670px;*/
            /*padding-top:80px;*/
            /*width: 110px;*/     
            
            width: 125px;
            float: right;
            text-align: left;    
            padding-left: 30px;
            padding-top: 15px;
        }

        .botonera {
            /*display: inline-flex;*/
            position:absolute;
            /*padding-left:380px;
            padding-top:80px;*/     
            width: 100%;
            
        }

        .boton {
            width: 60px;
            float: right;
            text-align: center;
            padding-right: 45px;
            padding-top: 15px;
        }

        .boton input {
                width: 55px;
                height: 37px;
                line-height: 34px;
                padding: 0;
                background: url('../Content/Images/zona_.png') 0 0 no-repeat;
                color: #fff;
                font-size: 14px;
                text-align: center;
                border: 0;
                margin-bottom: 10px;
        }

        .cabeceraDC {
            height: 25px;
            /*float: left;*/
            background-color:#6C207F;
        }

        .subCabeceraDC {
            height: 35px;
            /*float: left;*/
            background-color:white;
        }

        .cuerpoDC {
            height: 100%;
            width: 100%;
            float: left;
            background-color:#E7E7E7;
        }

        .pieDC {
            height: 20px;
            /*float: left;*/
            background-color:white;
            clear:both;
        }
    </style>

    <script>
        $(document).ready(function () {
            function LogoCenter() {
                var bodyWidth = $('body').width();
                var logoWidth = $('a#logo').width();
                var logoLeft = (bodyWidth - logoWidth) / 2;
                $('a#logo').css('left', logoLeft + 'px');
            }
            function LinkEvents() { $(window).resize(LogoCenter); }
            function Init() {
                LinkEvents();
                LogoCenter();
            }

            Init();
        });
    </script>
</head>
 
<body >
    <%-- <body class="bg_modal">--%>

    <div id="divCuerpo" runat="server" class="cuerpoDC">                                             
        <form id="form1" runat="server">        
            <asp:HiddenField  ID="hdidProveedor" runat="server"/>
            <asp:HiddenField  ID="hdtotalIdProveedor" runat="server"/>

            <div class="logo_modal" style="width: 100%; position:static;">
                <div id="divCabecera" runat="server" class="cabeceraDC"></div>
                <div id="divSubCabecera" runat="server" class="subCabeceraDC"></div>

                <a href="#" id="logo" style="left:790px;">
                    <img src="../Content/Images/logo_belcorp.png" alt="" />
                </a>

                <div class="botonera">
                    <div class="boton">
                        <asp:Button id="btnProveedorSiguiente" runat="server" Text=">" OnClick="btnProveedorSiguiente_Click"/>
                    </div>
                    <div class="tituloBoton">VER SIGUIENTE PROVEEDOR</div>
                    
                    <div class="boton">
                        <asp:Button id="btnProveedorAnterior" Text="<" runat="server" OnClick="btnProveedorAnterior_Click"/>
                    </div>
                    <div class="tituloBoton">VER PROVEEDOR ANTERIOR</div>
                </div>
            </div>
            <div class="content_despacho">
                <div class="titulo">Información de Despachos de Cobranza</div>
            </div>
            <div class="content_despacho_informacion">
                <div class="columna1">
                    <div class="texto1">Nombre Comercial o Denominación Social</div>
                    <div class="texto2">
                        <asp:Label ID="lblNombreComercial" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="columna2">
                    <div class="texto1">Razón Social</div>
                    <div class="texto2">
                        <asp:Label ID="lblRazonSocial" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="columna3">
                    <div class="texto1">RFC</div>
                    <div class="texto2">
                        <asp:Label ID="lblRFC" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Nombres de los Socios</div>
                    <div class="texto2">
                        <asp:Label ID="lblNombresSocios" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="columna2">
                    <div class="texto1">Representantes Legales</div>
                    <div class="texto2">
                        <asp:Label ID="lblRepresentantesLegales" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Domicilio Fiscal</div>
                    <div class="texto2">
                        <asp:Label ID="lblDomicilioFiscal" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Dirección donde se efectúa la gestión</div>
                    <div class="texto2">
                        <asp:Label ID="lblDireccion" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Números telefónicos utilizados para realizar las gestiones</div>
                    <div class="texto2">
                        <asp:Label ID="LblNumerosTelefonicos" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Correos electrónicos</div>
                    <div class="texto2">
                        <asp:Label ID="lblCorreosElectronicos" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Página electrónica</div>
                    <div class="texto2">
                        <asp:Label ID="lblPaginaElectronica" runat="server"></asp:Label>
                    </div>
                </div>

                <hr/>
                <div class="columna1">
                    <div class="texto1">Nombres de ejecutivos que realizan la gestión</div>
                    <div class="texto2">
                        <asp:Label ID="lblNombresEjecutivos" runat="server"></asp:Label>
                    </div>                    
                </div>
            </div>
        </form>                    
    </div>
    <div id="divPie" runat="server" class="pieDC"></div>
</body>
</html>