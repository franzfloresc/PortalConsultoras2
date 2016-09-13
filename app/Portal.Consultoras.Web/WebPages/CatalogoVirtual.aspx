<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CatalogoVirtual.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.CatalogoVirtual" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="~/Content/Css/Site/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            if (getParameterByName("DocumentId") != null) {
                var embedObject01 = "<object style='width:770px;height:540px' ><param name='bgcolor' value='#ffffff' /><param name='movie' value='https://secure-static.issuu.com/webembed/viewers/style1/v2/IssuuReader.swf?mode=mini&amp;embedBackground=%23000000&amp;backgroundColor=%23222222&amp;shareMenuEnabled=false&amp;printButtonEnabled=false&amp;shareButtonEnabled=false&amp;searchButtonEnabled=false&amp;documentId=";
                var embedObject02 = "' /><param name='allowfullscreen' value='true'/><param name='menu' value='false'/><param name='wmode' value='transparent'/><embed src='https://secure-static.issuu.com/webembed/viewers/style1/v2/IssuuReader.swf' type='application/x-shockwave-flash' allowfullscreen='true' menu='false' wmode='transparent' style='width:770px;height:540px' flashvars='mode=mini&amp;shareMenuEnabled=false&amp;printButtonEnabled=false&amp;shareButtonEnabled=false&amp;searchButtonEnabled=false&amp;documentId=";
                var query = getParameterByName("DocumentId");
                var marca = query.substring(0, 2);
                var DocId = "";
                if (marca == "LB" || marca == "CY" || marca == "ES" || marca == "FI")
                    DocId = query.substring(2, query.length);
                else
                    DocId = query;
                var DocumentId = DocId + "'";
                var embedObject03 = "/></object>";
                $("#divCatalogo").append(embedObject01 + DocumentId + embedObject02 + DocumentId + embedObject03);
            }
        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(window.location.search);
            if (results == null)
                return "";
            else
                return decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>  
</head>
<body>
    <!--R2469 (CSR) Nueva  Etiquetas de Seguimiento-->
    <!-- Google Tag Manager -->
    <noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-M8QMC8"
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <script>(function (w, d, s, l, i) {
    w[l] = w[l] || []; w[l].push({
        'gtm.start':
        new Date().getTime(), event: 'gtm.js'
    }); var f = d.getElementsByTagName(s)[0],
    j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : ''; j.async = true; j.src =
    '//www.googletagmanager.com/gtm.js?id=' + i + dl; f.parentNode.insertBefore(j, f);
})(window, document, 'script', 'dataLayer', 'GTM-M8QMC8');</script>
    <!-- End Google Tag Manager -->
    <div id="divCatalogo" class="catalogo">
    </div>
</body>
</html>
