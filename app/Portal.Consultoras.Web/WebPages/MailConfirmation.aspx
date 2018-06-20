<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailConfirmation.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.MailConfirmation" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700italic,300,700,900" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-migrate-1.2.1.min.js"></script>
    <script src="../Scripts/jquery.validate.min.js"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.min.js"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.min.js"></script>
    <script src="../Scripts/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="../Scripts/HojaInscripcion/validations.js"></script>

    <script src="../Scripts/General.js" type="text/javascript"></script>
    
    <link href="../Content/Css/Site/Esika/reset.css" rel="stylesheet" data-id="cssResetEsika"/>
    <link href="../Content/Css/Site/Esika/style.css" rel="stylesheet" data-id="cssStyleEsika"/>
    <link href="../Content/Css/Site/Esika/mi-perfil.css" rel="stylesheet" data-id="cssStyleEsika"/>
    <link href="../Content/Css/Site/Esika/styleDefault.css" rel="stylesheet" data-id="cssStyleEsika"/>
    <link href="../Content/Css/ui.jquery/Esika/jquery-ui.css" rel="stylesheet" data-id="cssJqueryEsika"/>
    <link href="../Content/Css/Site/Lbel/reset.css" rel="stylesheet" data-id="cssResetLbel"/>
    <link href="../Content/Css/Site/Lbel/style.css" rel="stylesheet" data-id="cssStyleLbel"/>
    <link href="../Content/Css/Site/Lbel/mi-perfil.css" rel="stylesheet" data-id="cssStyleLbel"/>
    <link href="../Content/Css/Site/Lbel/styleDefault.css" rel="stylesheet" data-id="cssStyleLbel"/>
    <link href="../Content/Css/ui.jquery/Lbel/jquery-ui.css" rel="stylesheet" data-id="cssJqueryLbel"/>
    <link href="../Content/Css/Site/calc.css" rel="stylesheet" />

    <style type="text/css">

        .MensajeAlertaMobile {
            position: fixed;
            z-index: 2010;
            width: 100%;
            height: 100%;
            padding: 15px;
            top: 0;
            background: rgba(0,0,0,0.5);
        }

        .content_mensajeAlerta {
            width: 100%;
            height: 100%;
            /* height: 0; */
            margin: 0 auto;
            position: relative;
            background: white;
            padding: 20px;
            overflow-y: auto;
        }

        .icono_alerta {
            width: 50px;
            height: 50px;
            margin: 0 auto;
            margin-top: 30px;
        }
        
        .icono_alerta img {
            width: 100%;
        }

        .mensaje_alerta {
            font-family: 'Lato';
            font-size: 14px;
            text-align: center;
            margin-top: 13px;
            margin-bottom: 17px;
            color: black;
        }

        .btn_ok_mobile {
            margin: 0 auto;
            width: 139px;
            height: 45px;
            line-height: 45px;
            color: white;
            text-align: center;
            display: block;
            background-color: #e81c36;
            margin-bottom: 20px;
        }

        .cerrar_popMobile {
            float: right;
        }

        .exclamacion_icono_mobile {
            background: url("../../Content/Images/Esika/icono_exclamacion_esika.svg") no-repeat;
            background-size: cover;
        }

        .btn_ok_mobile > * {
            color: white;
            text-decoration: none;
        }
    </style>

    <title>Activación de correo</title>

    <script>
        $(document).ready(function () {
            //Asignar hojas de estilo
            if ($('#txtmarca').val() == 'lbel') {
                $("body").css("visibility", "hidden");
                $("link[data-id='cssResetLbel']").removeAttr('disabled');
                $("link[data-id='cssStyleLbel']").removeAttr('disabled');
                $("link[data-id='cssJqueryLbel']").removeAttr('disabled');
                $("link[data-id='cssResetEsika']").attr('disabled', 'disabled');
                $("link[data-id='cssStyleEsika']").attr('disabled', 'disabled');
                $("link[data-id='cssJqueryEsika']").attr('disabled', 'disabled');
                window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
            } else {
                $("body").css("visibility", "hidden");
                $("link[data-id='cssResetEsika']").removeAttr('disabled');
                $("link[data-id='cssStyleEsika']").removeAttr('disabled');
                $("link[data-id='cssJqueryEsika']").removeAttr('disabled');
                $("link[data-id='cssResetLbel']").attr('disabled', 'disabled');
                $("link[data-id='cssStyleLbel']").attr('disabled', 'disabled');
                $("link[data-id='cssJqueryLbel']").attr('disabled', 'disabled');
                window.setTimeout(function () { $("body").css("visibility", "visible"); }, 100);
            }

            //document.getElementById('linkregresarasomosbelcorp').href = result.url;
           

        });

        function mostrarMensaje(message) {
            if ($('#txtmarca').val() == 'lbel') {
                $(".btn_ok_mobile").css("background", "#642f80");
                $(".exclamacion_icono_mobile").css("background", "url('../../Content/Images/Lbel/icono_exclamacion_lbel.svg') no-repeat").css("background-size", "cover");
            }                

            $('#mensajeInformacionEliminar').html(message);
            $("#popup-eliminar-mensaje").show();
        }

        
    </script>
</head>

<body id="bodyrestablece" class="bodyrecuperaclave">
    <div class="fondo_f9f9f9 fondoDesktop w-100-mobile mt-50 mt-0-mobile fondoMobile">
        <div class="content_belcorp">
            <div class="fondo_negro_lateral"></div>
            <div class="pestana_lbel pestania_lbel_mi_perfil ml-87"></div>
            <div class="titulo_interiores titulo_interiores_mi_perfil quitarBackgroundImageMobile pl-20-mobile quitarPaddingDerechoMobile"><span>CORREO</span> ACTUALIZADO</div>
        </div>
        <hr class="clear" />
        <div class="linea_separadora mt-9" style="margin-top:-1px"></div>
    </div>
    <section class="vista_actualizar_correo altoAutomatico vista_actualizar_correo_paddingMobile">
        <div class="wrapper_content_actualizar_correo w-100-mobile">
            <form style="display: none;" runat="server">
                <asp:TextBox ID="txtmarca" runat="server" CssClass="txttexto"></asp:TextBox>
            </form>
            <div style="display:none;">
                <asp:HyperLink ID="linkregresarasomosbelcorp" runat="server" CssClass="btnCambiarContrasenia" style="text-align: center;">IR A SOMOS BELCORP</asp:HyperLink>
            </div>
            <div class="correo_actualizado text-center correo_actualizado_paddingMobile">
                <div class="icono_actualizacion_correo_exitoso"></div>
                <h1 class="titulo_correo_actualizado text-uppercase">
                    ¡Actualizaste <span class="text-bold">tu correo</span>!
                </h1>
                <p class="mensaje_correo_actualizado">
                    <asp:Label ID="lblConfirmacion" runat="server"></asp:Label>
                </p>
                <a href="@Url.Action("Index")" class="btn_acept text-uppercase text-bold default-background-color">Ok</a>
            </div>
        </div>
    </section>
</body>
</html>
