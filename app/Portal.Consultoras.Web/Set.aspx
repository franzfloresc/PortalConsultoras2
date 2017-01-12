<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Set.aspx.cs" Inherits="Portal.Consultoras.Web.Set" %>

<!DOCTYPE html>

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
    <p id="pNombreProducto" runat="server" style="font-weight: bold;"></p>    
    <p id="pSubtituloProducto" runat="server"></p>
    <img src="" id="imgCuvProducto" alt="imagen" runat="server"/>
</body>
</html>
