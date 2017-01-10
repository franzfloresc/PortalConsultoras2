<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pdto.aspx.cs" Inherits="Portal.Consultoras.Web.Pdto" %>

<!DOCTYPE html>

<%--<html xmlns="http://www.w3.org/1999/xhtml">--%>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,300,700,900" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body {
                text-align: center;
                font-family: 'Lato';
            }
         img {
             width: 100%;
         }
        @media (min-width: 720px) {            
            img {
                width: 50%;
            }
        }
    </style>
</head>
<body>
    <%--<form id="form1" runat="server">
    <div>
    
    </div>
    </form>--%>
    <img src="" id="imgCuvProducto" alt="imagen" runat="server"/>
    <p id="pMarcaProducto" runat="server"></p>
    <p id="pNombreProducto" runat="server" style="font-weight: bold;"></p>    
    <p id="pVolumenProducto" runat="server" style="font-weight: bold;"></p>  
    <p id="pDescripcionProducto" runat="server" style="font-weight: bold;"></p>  
    <%--<p id="pSubtituloProducto" runat="server"></p>--%>
    
</body>
</html>
