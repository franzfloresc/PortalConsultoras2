<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioBloqueado.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.UsuarioBloqueado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Belcorp | Portal Consultoras</title>
    <link href="~/Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg_modal">
    <form id="form1" runat="server">
        <div class="logo_modal">
            <a href="#" id="logo">
                <img src="../../Content/Images/logo_belcorp.png" alt="" />
            </a>
        </div>
        <div class="wrap_modal">
            <div class="image_modal">
                <img src="../../Content/Images/usuario_bloqueado.png" alt="" />
            </div>
        </div>
        <div class="texto_modal">
            SU CUENTA DE ACCESO A SOMOS BELCORP SE ENCUENTRA BLOQUEADA
        </div>
        <asp:Panel ID="DivMensajeGenerico" runat="server" CssClass="texto_modal2" Visible="false">
            Comuníquese con nosotros a través de BelcorpResponde (<a href="https://www2.somosbelcorp.com/belcorpresponde/belcorp-responde.asp">www.belcorpresponde.com</a>) o de su Gerente de Zona
        </asp:Panel>
        <asp:Panel ID="DivMensajeCO" runat="server" CssClass="texto_modal2" Visible="false">
            Por favor comuníquese con su Gerente de Zona.
        </asp:Panel>
        <div class="boton_modal">
            <div class="input_search">
                <asp:Button ID="btnRegresar" runat="server" OnClick="btnRegresar_Click" Text="Regresar" />
            </div>
        </div>
    </form>
</body>
</html>
