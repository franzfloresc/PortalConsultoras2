﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailConfirmation.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.MailConfirmation" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Activación de correo</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,300,700,900" rel="stylesheet" type="text/css" />
    <link href="../Content/Css/Site/MailConfirmacion/style.css" rel="stylesheet" type="text/css"  />    
    <script src="../Scripts/PortalConsultoras/MailConfirmacion/Index.js"></script>
</head>
<body id="bodyrestablece" class="bodyrecuperaclave">
    <div class="fondo_f9f9f9 fondoDesktop w-100-mobile mt-50 mt-12-lbel mt-0-mobile fondoMobile">
        <div class="content_belcorp">
            <div class="fondo_negro_lateral"></div> 
            <div class="titulo_interiores titulo_interiores_mi_perfil quitarBackgroundImageMobile pl-20-mobile quitarPaddingDerechoMobile"><span>CORREO</span> ACTUALIZADO</div>
        </div>
        <hr class="clear" />
        <div class="linea_separadora mt-9" style="margin-top:-1px"></div>
    </div>
    <div class="content_belcorp">
        <div class="pestana_lbel pestana_lbel_mi_perfil"></div>
    </div>
    <section class="vista_actualizar_correo altoAutomatico vista_actualizar_correo_paddingMobile">
        <div class="wrapper_content_actualizar_correo w-100-mobile">
            <div class="correo_actualizado text-center correo_actualizado_paddingMobile">
                <div runat="server" id="divHeadSuccess">
                    <div style="margin-bottom:8px;">
                        <img src="../Content/Images/mobile/img-emoticons/1f64c.png"  />
                    </div>
                    <h1 class="titulo_correo_actualizado text-uppercase">
                        ¡Actualizaste <span class="text-bold" style="display: inline-block;" >tu correo</span>!
                    </h1>
                </div>
                <div runat="server" id="divHeadError">
                    <div class="_icono_actualizacion_correo_erroneo">
                        <asp:Image ID="imgError" runat="server" ImageUrl="~/Content/Images/mobile/img-icon/icon_bolsita_triste.png" Height="64" />
                    </div>
                    <h1 class="titulo_correo_actualizado text-uppercase" style="min-width:80%; margin-top:10px;" >
                        <asp:Label ID="lblTituloError" runat="server" Text="Lo sentimos" CssClass="text-bold" />
                    </h1>
                </div>
                <p class="mensaje_correo_actualizado">
                    <asp:Label ID="lblConfirmacion" runat="server"></asp:Label>
                </p>
                <div runat="server" id="divFootSuccess" >
                    <div class="noShowPhone" >                
                        <asp:HyperLink ID="linkMainPage" runat="server" CssClass="btn_acept text-uppercase text-bold multimarca-background-color">IR A SOMOS BELCORP</asp:HyperLink>
                        <p class="mensaje_app_esika_conmigo" >Tambien te recomendamos descargar el <asp:HyperLink ID="linkAppEsikaConmigo" CssClass="altLink" runat="server"></asp:HyperLink></p>
                    </div>
                    <div class="showPhone" >
                        <asp:HyperLink ID="btnAppEsikaConmigo" runat="server" CssClass="btn_acept text-uppercase text-bold multimarca-background-color"></asp:HyperLink>
                        <p class="mensaje_app_esika_conmigo" >O puedes ingresar a la <asp:HyperLink ID="linkSomosBelcorp" CssClass="altLink" runat="server">versión web aquí</asp:HyperLink></p>
                    </div>
                </div>
                <div runat="server" id="divFootCall" visible="false" >                    
                    <asp:Label ID="lblComunicate" runat="server" CssClass="mensaje_app_esika_conmigo" ></asp:Label>
                </div>
            </div>
        </div>
    </section>
</body>
</html>