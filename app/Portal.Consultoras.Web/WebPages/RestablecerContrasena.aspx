<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestablecerContrasena.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RestablecerContrasena" %>

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
    <link href="../Content/Css/ui.jquery/Esika/jquery-ui.css" rel="stylesheet" data-id="cssJqueryEsika"/>
    <link href="../Content/Css/Site/Lbel/reset.css" rel="stylesheet" data-id="cssResetLbel"/>
    <link href="../Content/Css/Site/Lbel/style.css" rel="stylesheet" data-id="cssStyleLbel"/>
    <link href="../Content/Css/ui.jquery/Lbel/jquery-ui.css" rel="stylesheet" data-id="cssJqueryLbel"/>
    <link href="../Content/Css/Site/Menu/MenuPrincipal.css" rel="stylesheet"/>
    <link href="../Content/Css/Site/calc.css" rel="stylesheet" />

    <style type="text/css">

        body, .fondo_f9f9f9{
            background:#FFF!important;
        }

        header{
            box-shadow:none;
            position:relative;
        }

        .ubicacion_web{
            display:none;
        }

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

    <title>Restablecer Contraseña</title>

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

            $("#btncambiar").click(function () {
                ModificarClave();
            });
            $("#txtcontrasenanueva2").on("keypress", function (evt) {
                if (evt.keyCode === 13) {
                    ModificarClave();
                }
            });

        });

        function mostrarMensaje(message) {
            if ($('#txtmarca').val() == 'lbel') {
                $(".btn_ok_mobile").css("background", "#642f80");
                $(".exclamacion_icono_mobile").css("background", "url('../../Content/Images/Lbel/icono_exclamacion_lbel.svg') no-repeat").css("background-size", "cover");
            }                

            $('#mensajeInformacionEliminar').html(message);
            $("#popup-eliminar-mensaje").show();
        }

        function ModificarClave() {
            var newPassword1 = $.trim($('#txtcontrasenanueva1').val());
            var newPassword2 = $.trim($('#txtcontrasenanueva2').val());
            var vMessage = ArmarMensaje(newPassword1, newPassword2);

            if (vMessage != "") {
                mostrarMensaje(vMessage);
                return false;
            }
            else {
                var newPassword = jQuery.trim($('#txtcontrasenanueva1').val());

                var item = {
                    newPassword: newPassword
                };

                waitingDialog({});

                ModificaClaveCS(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.success == true) {
                        closeWaitingDialog();
                        $('#divFormulario').hide();
                        $('#divActualizacionCorrecta').show();
                        document.getElementById('linkregresarasomosbelcorp').href = result.url;
                    }
                    else {
                        closeWaitingDialog();
                        return false;
                    }
                    Limpiar();
                });
            }
        }

        function ArmarMensaje(password1, password2) {
            if (password1 == "" || password2 == "")
                return "Ingresa ambos campos de contraseña.";
                //return "Datos incorrectos. Por favor, volver a ingresar";

            if (password1.length <= 6)
                return "La nueva contraseña debe de tener como mínimo 7 caracteres.";
                //return "Datos incorrectos. Por favor, volver a ingresar";

            if (password1 != password2)
                return "Los campos de la nueva contraseña deben ser iguales, verifique.";
                //return "Datos incorrectos. Por favor, volver a ingresar";

            return "";
        }

        function Limpiar() {
            $('#txtpaisid').val("");
            $('#txtcorreo').val("");
            $('#txtpaisiso').val("");
            $('#txtcodigousuario').val("");
            $('#txtcontrasenaanterior').val("");
            $('#txtcontrasenanueva1').val("");
            $('#txtcontrasenanueva2').val("");
        }

        function MostrarSesionExpirada(titulo, mensaje) {
            if ($('#txtmarca').val() == 'lbel')
                $(".btn_ok_mobile").css("background", "#642f80");

            $('#divFormulario').empty().hide();

            $('#divActualizacionCorrecta > .saludoConsultora').html(titulo);
            $('#divActualizacionCorrecta > .cambiarContraseniaTexto').html(mensaje)
            $('#divActualizacionCorrecta').show();
        }
    </script>
</head>

<body id="bodyrestablece" class="bodyrecuperaclave">
    <header>
        <div class="wrapper_header">
            <div class="fondo_oscuro"></div>
            <div class="logo_esika logoEsikaActualizarContrasenia">
                <a href="#"></a>
            </div>
        </div>
        <div class="clear"></div>
    </header>
    <div id="loadingScreen"></div>
    <div class="ubicacion_web ubicacionWebActualizarContrasenia">
        <span><a href="#">Home</a></span> <span>| Cambio de Contraseña</span>
    </div>
    <div class="content">
        <div class="fondo_f9f9f9">
            <div class="content_belcorp">
                <div class="fondo_negro_lateral"></div>
                <div class="titulo_interiores tituloCambioContrasenia">
                    <span>CAMBIO DE&nbsp;</span><span class="texto_bold">CONTRASEÑA</span>
                </div>                
            </div>
            <hr class="clear" />
            <div class="linea_separadora hideOnMobile"></div>
        </div>

        <div class="content_belcorp" id="divCambiarClave" runat="server" visible="true">
            <div class="pestana_lbel pestanaLbelActualizarContrasenia"></div>
            <!--PESTAÑA PARA DARLE ESTILO CON LBEL-->
            <div class="contenedor_actualizarContraseniaForm" id="divFormularioActualizacion">
                <div class="campos_actualizacionContrasenia" id="divFormulario">
                    <div class="saludoConsultora">¡Hola <span><asp:Label runat="server" ID="lblNombre"></asp:Label>!</span></div>
                    <span class="cambiarContraseniaTexto">Cambia tu contraseña aquí:</span>
                    <form id="frmrestablecercontrasena" runat="server" class="formulario_actualizarContrasenia">
                        <div style="display: none;">
                            <asp:TextBox ID="txtpaisid" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtcorreo" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtpaisiso" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtcodigousuario" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtcontrasenaanterior" runat="server" CssClass="txttexto"></asp:TextBox>
                            <asp:TextBox ID="txtmarca" runat="server" CssClass="txttexto"></asp:TextBox>
                        </div>
                        <asp:TextBox ID="txtcontrasenanueva1" runat="server" CssClass="campoContrasenia borde_inferior_campo" placeholder="Nueva contraseña" TextMode="Password"></asp:TextBox>
                        <asp:TextBox ID="txtcontrasenanueva2" runat="server" CssClass="campoContrasenia borde_inferior_campo" placeholder="Confirmar contraseña" TextMode="Password"></asp:TextBox>
                        <input id="btncambiar" class="btnCambiarContrasenia mt-34" type="button" value="CAMBIAR CONTRASEÑA" />
                    </form>
                </div>
                <div class="campos_actualizacionContrasenia" id="divActualizacionCorrecta" style="display:none;">
                    <div class="icono_check_felicitaciones"></div>
                    <div class="mensaje_felicitaciones">
                        <span>¡FELICIDADES!</span>
                        <span>Tu contraseña fue actualizada</span>
                        <div class="formulario_actualizarContrasenia">
                            <asp:HyperLink ID="linkregresarasomosbelcorp" runat="server" CssClass="btnCambiarContrasenia" style="text-align: center;">IR A SOMOS BELCORP</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr class="clear">
    </div>
    <div id="popup-eliminar-mensaje" class="MensajeAlertaMobile" style="display: none;">
        <div class="content_mensajeAlerta">
            <a class="cerrar_popMobile" href="javascript:;" onclick="javascript: $('#popup-eliminar-mensaje').hide();">
                <img src="/Content/Images/mobile/Esika/cerrar_04.png" alt="-">
            </a>
            <hr class="clear">
            <div class="icono_alerta exclamacion_icono_mobile"></div>
            <div class="titulo_compartir"><b>ERROR</b></div>
            <div class="mensaje_alerta" id="mensajeInformacionEliminar"></div>
            <a href="javascript:;" onclick="$('#popup-eliminar-mensaje').hide();" class="btn_ok_mobile"><b>OK</b></a>
        </div>
    </div>
</body>
</html>
