<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailConfirmation2.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.MailConfirmation2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg_modal">
    <form id="form1" runat="server">
        <div class="logo_modal">
            <a href="www.belcorp.biz" id="logo">
                <img src="../Content/Images/logo_belcorp.png" alt="" />
            </a>
        </div>
        <div class="texto_modal">
            <div>
                <asp:Label ID="lblConfirmacion" runat="server"></asp:Label>
            </div>
        </div>

    </form>
</body>
</html>
