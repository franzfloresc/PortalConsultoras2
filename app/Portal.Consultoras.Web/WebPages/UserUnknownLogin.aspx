<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserUnknownLogin.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.UserUnknownLogin" %>

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
