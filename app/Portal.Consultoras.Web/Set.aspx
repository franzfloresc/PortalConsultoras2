<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Set.aspx.cs" Inherits="Portal.Consultoras.Web.Set" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W2QJJ5J');</script>
<!-- End Google Tag Manager -->
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
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-W2QJJ5J"
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->  
    <p id="pNombreProducto" runat="server" style="font-weight: bold;"></p>    
    <p id="pSubtituloProducto" runat="server"></p>
    <img src="" id="imgCuvProducto" alt="imagen" runat="server"/>
</body>
</html>
