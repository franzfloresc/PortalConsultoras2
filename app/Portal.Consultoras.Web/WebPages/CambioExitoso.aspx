<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambioExitoso.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.CambioExitoso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

       <!-- GR-1390 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../Content/Css/Mobile/theme.min.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/icomon.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/menu.css" rel="stylesheet" />
    <link href="../Content/Css/Mobile/style.css" rel="stylesheet" />

    <script src="../Scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/General.js" type="text/javascript"></script>
    <link href="../Content/Css/ui.jquery/jquery-ui.css" rel="stylesheet" />
    <link href="../Content/Css/Site/style.css" rel="stylesheet" />

    <link href="../Content/Css/Site/Site.css" rel="stylesheet" />
    <link href="../Content/Css/Site/CambiarContrasena.css" rel="stylesheet" />

    <title>Cambio Exitoso</title>

</head>
<body class="bodyrecuperaclave">
     <div id="loadingScreen"></div>
    <table style="width:100%;">
        <tr>
        <td style='width:100%; height: 56px; background:#F2F3F7;'><img class="imagencentrado" src="../Content/Images/logo_foot.png" alt="" /></td>
        </tr>
    </table>

    <form id="form1" runat="server">
        
        <div class="container">
    
	        <section>
		        <p>
			        <b>CAMBIAR CONTRASEÑA</b>
		        </p>
 
		        <p>
			        Tu contraseña se ha restablecido con éxito. <br /><br />
                    <asp:HyperLink ID="idlinkingresamicuenta" runat="server" CssClass="textoingresalo">Ingresar a mi cuenta</asp:HyperLink>
		        </p>
		
	        </section>
	
        </div>

    </form>
</body>
</html>
