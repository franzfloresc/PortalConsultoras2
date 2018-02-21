<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/MasterComunidad.Master" AutoEventWireup="true" CodeBehind="IngresoComunidad.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.IngresoComunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/Css/Comunidad/ingreso_comunidad.css" rel="stylesheet" type="text/css" />
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,500' rel='stylesheet' type='text/css' />

    <script type="text/javascript">
        $(document).ready(function () {
            $(".ValidaAlfanumerico").keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : window.event.keyCode;
                if (charCode <= 13) {
                    return true;
                }
                else {
                    var keyChar = String.fromCharCode(charCode);
                    var re = /[a-zA-Z0-9_-]/;
                    return re.test(keyChar);
                }
            });

            $(".btn-tab").click(function (event) {
                var c = $(this).data('target');
                $(".btn-tab").removeClass('active');
                $(this).addClass('active');

                $(".collapse-form").addClass('hidden');
                $("#" + c + " ").removeClass('hidden');
            });
            ActivarPestanha();

            //Remove resize de master
            $(window).off("resize");
            $("#cont_contenido, .container").css({ 'width': '' });
        })

        //Comunes: INICIO
        $(document).keypress(function (e) {
            if (e.which == 13)
                $("#btnIngresoComunidad").click();
        });
        function ActivarPestanha() {
            if (getUrlParameter('register') == 'true') $('.btn-tab[data-target="form-register"]').click();
        }
        function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        }
        function RedirectSB() {
            location.href = $('#hdfSB').val();
        }
        //Comunes: FIN

        //Formulario Ingresar: INICIO
        function ValidarFormularioIngreso() {
            var result = true;

            if ($('#txtUsuario_ingreso').val() == '') {
                $('#ErrorUsuario_ingreso').css({ "display": "block" });
                $('#ES_Usuario_ingreso').css({ "display": "block" });
                $('#ErrorUsuario_ingreso').html("Debe ingresar un usuario.");
                result = false;
            } else {
                $('#ErrorUsuario_ingreso').css({ "display": "none" });
                $('#ES_Usuario_ingreso').css({ "display": "none" });
                $('#ErrorUsuario_ingreso').html('')
            }

            if ($('#txtContrasenia_ingreso').val() == '') {
                $('#ErrorContrasenia_ingreso').css({ "display": "block" });
                $('#ES_Contrasenia_ingreso').css({ "display": "block" });
                $('#ErrorContrasenia_ingreso').html("Debe ingresar una contraseña.");
                result = false;
            } else {
                $('#ErrorContrasenia_ingreso').css({ "display": "none" });
                $('#ES_Contrasenia_ingreso').css({ "display": "none" });
                $('#ErrorContrasenia_ingreso').html('')
            }

            if ($('#ddlPais_ingreso').val() == '0') {
                $('#ErrorPais_ingreso').css({ "display": "block" });
                $('#ES_Pais_ingreso').css({ "display": "block" });
                $('#ErrorPais_ingreso').html("Debe seleccionar su país.");
                result = false;
            } else {
                $('#ErrorPais_ingreso').css({ "display": "none" });
                $('#ES_Pais_ingreso').css({ "display": "none" });
                $('#ErrorPais_ingreso').html('')
            }

            if (result) {
                if ($('#ErrorUsuario_ingreso').html() != '' || $('#ErrorContrasenia_ingreso').html() != '' || $('#ErrorPais_ingreso').html() != '') return;

                $('#hdfContrasenia_ingreso').val($('#txtContrasenia_ingreso').val());
                var item = {
                    CodigoUsuario: $('#txtUsuario_ingreso').val(),
                    Contrasenia: $('#hdfContrasenia_ingreso').val(),
                    PaisId: $('#ddlPais_ingreso').val()
                };

                waitingDialog({});
                ValidarUsuario(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.success == true) {
                        $('#ErrorAutenticacion_ingreso').html('');
                        location.href = result.page;
                    }
                    else {
                        closeWaitingDialog();
                        $('#ErrorAutenticacion_ingreso').css({ "display": "block" });
                        $('#ErrorAutenticacion_ingreso').html(result.message)
                    }

                    LimpiarIngreso();
                    return false;
                });
            }
        }
        function LimpiarIngreso() {
            $('#hdfContrasenia_ingreso').val("");
            $('#txtContrasenia_ingreso').val("")
        }
        //Formulario Ingresar: FIN

        //Formulario Registrar: INICIO
        function ValidarFormularioRegistro() {
            var result = true;

            if (!$('#chkAceptacionCondiciones_registro').prop('checked')) {
                $('#ErrorCondiciones_registro').css({ "display": "block" });
                $('#ES_Condiciones_registro').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorCondiciones_registro').css({ "display": "none" });
                $('#ES_Condiciones_registro').css({ "display": "none" });
            }

            if ($('#txtNombre_registro').val() == '') {
                $('#ErrorNombre_registro').css({ "display": "block" });
                $('#ES_Nombre_registro').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorNombre_registro').css({ "display": "none" });
                $('#ES_Nombre_registro').css({ "display": "none" });
            }

            if ($('#txtApellido_registro').val() == '') {
                $('#ErrorApellido_registro').css({ "display": "block" });
                $('#ES_Apellido_registro').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorApellido_registro').css({ "display": "none" });
                $('#ES_Apellido_registro').css({ "display": "none" });
            }

            if ($('#txtUsuario_registro').val() == '') {
                $('#ErrorUsuario_registro').css({ "display": "block" });
                $('#ES_Usuario_registro').css({ "display": "block" });
                $('#ErrorUsuario_registro').html("Debe ingresar un usuario.");
                result = false;
            }

            if ($('#txtCorreo_registro').val() == 'Correo electrónico') {
                $('#ErrorCorreo_registro').css({ "display": "block" });
                $('#ES_Correo_registro').css({ "display": "block" });
                $('#ErrorCorreo_registro').html("Debe ingresar su correo.");
                result = false;
            }
            else if (!ValidarCorreo($('#txtCorreo_registro').val())) {
                $('#ErrorCorreo_registro').css({ "display": "block" });
                $('#ES_Correo_registro').css({ "display": "block" });
                $('#ErrorCorreo_registro').html("El formato del correo es incorrecto.");
                $('#ErrorCorreo_registro').css({ "color": "#ed1556" });
                result = false;
            }

            if ($('#txtContrasenia_registro').val() == '') {
                $('#ErrorContrasenia_registro').css({ "display": "block" });
                $('#ES_Contrasenia_registro').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorContrasenia_registro').css({ "display": "none" });
                $('#ES_Contrasenia_registro').css({ "display": "none" });
            }

            if ($('#ddlPais_registro').val() == '0') {
                $('#ErrorPais_registro').css({ "display": "block" });
                $('#ES_Pais_registro').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorPais_registro').css({ "display": "none" });
                $('#ES_Pais_registro').css({ "display": "none" });
            }

            if (result) {
                if ($('#ErrorUsuario_registro').html() != 'Usuario Disponible.' || $('#ErrorCorreo_registro').html() != 'Correo Disponible.') return;

                $('#hdfContrasenia_registro').val($('#txtContrasenia_registro').val());
                var item = {
                    CodigoUsuario: $('#txtUsuario_registro').val(),
                    Nombre: $('#txtNombre_registro').val(),
                    Apellido: $('#txtApellido_registro').val(),
                    Contrasenia: $('#hdfContrasenia_registro').val(),
                    Correo: $('#txtCorreo_registro').val(),
                    PaisId: $('#ddlPais_registro').val()
                };

                waitingDialog({});
                RegistrarUsuarioComunidad(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    closeWaitingDialog();
                    if (result.success == true) AbrirAlerta_1();
                    else AbrirAlerta_2();

                    Limpiar();
                    return false;
                });
            }
        }
        function Limpiar() {
            $('#txtUsuario_registro').val('');
            $('#txtNombre_registro').val('');
            $('#txtApellido_registro').val('');
            $('#hdfContrasenia_registro').val('');
            $('#txtContrasenia_registro').val('')
            $('#txtCorreo_registro').val('');
            $('#ddlPais_registro').val('0');

            $('#ErrorCorreo_registro').css({ "display": "none" });
            $('#ES_Correo_registro').css({ "display": "none" });
            $('#ErrorCorreo_registro').html('')

            $('#ErrorUsuario_registro').css({ "display": "none" });
            $('#ES_Usuario_registro').css({ "display": "none" });
            $('#ErrorUsuario_registro').html('')
        }
        function ValidarUsuarioIngresado(usuario) {
            $('#ValUsuario_registro').css({ "display": "block" });
            $('#ErrorUsuario_registro').css({ "display": "none" });
            $.ajax({
                type: "POST",
                url: "IngresoComunidad.aspx/ValidarUsuarioIngresado",
                data: "{'usuario': '" + usuario + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                complete: function () {
                    $('#ValUsuario_registro').css({ "display": "none" });
                    $('#ErrorUsuario_registro').css({ "display": "block" });
                    $('#ES_Usuario_registro').css({ "display": "block" });
                },
                success: function (data) {
                    if (data.d == '1') {
                        $('#ErrorUsuario_registro').html("Este Usuario ya existe.");
                        $('#ErrorUsuario_registro').css({ "color": "#ed1556" });
                    } else {
                        $('#ErrorUsuario_registro').html("Usuario Disponible.");
                        $('#ErrorUsuario_registro').css({ "color": "#35bdb2" });
                    }
                },
                error: function (result) {
                    $('#ErrorUsuario_registro').html("Error al validar.");
                    $('#ErrorUsuario_registro').css({ "color": "#ed1556" });
                }
            });
        }
        function ValidarCorreoIngresado(correo) {
            $('#ValCorreo_registro').css({ "display": "block" });
            $('#ErrorCorreo_registro').css({ "display": "none" });
            $.ajax({
                type: "POST",
                url: "IngresoComunidad.aspx/ValidarCorreoIngresado",
                data: "{'correo': '" + correo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                complete: function () {
                    $('#ValCorreo_registro').css({ "display": "none" });
                    $('#ErrorCorreo_registro').css({ "display": "block" });
                    $('#ES_Correo_registro').css({ "display": "block" });
                },
                success: function (data) {
                    if (data.d == '1') {
                        $('#ErrorCorreo_registro').html("Este correo ya existe.");
                        $('#ErrorCorreo_registro').css({ "color": "#ed1556" });
                    } else {
                        $('#ErrorCorreo_registro').html("Correo Disponible.");
                        $('#ErrorCorreo_registro').css({ "color": "#35bdb2" });
                    }
                },
                error: function (result) {
                    $('#ErrorCorreo_registro').html("Error al validar.");
                    $('#ErrorCorreo_registro').css({ "color": "#ed1556" });
                }
            });
        }
        function Condiciones(tipo) {
            if ($('#ddlPais_registro').val() == '0') {
                alert("Para visualizar las Condiciones del Servicio y/o Políticas de Privacidad de Belcorp debe seleccionar un país. ");
            }
            else {
                if (tipo == 1) window.open('https://www.somosbelcorp.com/WebPages/comunidad/CondicionesServicio_' + $('#ddlPais_registro').val() + '.html', '_blank');
                else window.open('https://www.somosbelcorp.com/WebPages/comunidad/PoliticasPrivacidad_' + $('#ddlPais_registro').val() + '.html', '_blank');
            }
        }

        function ValidarCorreo(correo) {
            expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return expr.test(correo);
        }
        function AbrirAlerta_1() {
            $('#pnlExito').dialog({
                modal: true,
                width: 650,
                title: 'Comunidad SomosBelcorp',
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlExito').dialog("close");
                    }
                }
            });
        }
        function AbrirAlerta_2() {
            $('#pnlError').dialog({
                modal: true,
                width: 350,
                title: 'Comunidad SomosBelcorp',
                closeOnEscape: false,
                resizable: false,
                show: "slide",
                hide: "silde",
                position: "center",
                buttons: {
                    Aceptar: function () {
                        $('#pnlError').dialog("close");
                    }
                }
            });
        }
        //Formulario Registrar: FIN
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdfContrasenia_ingreso" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdfContrasenia_registro" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdfSB" runat="server" ClientIDMode="Static"/>
    
    <div class="wrapMain">
        <div class="grid-3 pl0">
            <h3>Soy Consultora</h3>
            <p class="text-height-title">Inicia sesión en Somos Belcorp para ingresar a la comunidad</p>
        </div>
        <div class="grid-sm pr0">
            <div class="formbtn text-right mt-20 text-center-min">
                <input id="btnConsultora" type="button" class="btnCrear" value="IR A SOMOS BELCORP" onclick="RedirectSB()" />
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="grid-sm line-gris pl0">
            <h3>No soy Consultora</h3>
            <p class="text-height-title">Completa tus datos para ingresar a la comunidad</p>
        </div>
        <div class="grid-forms line-gris pr0 line-xs-hidden">
            <div class="content-grid">
                <div class="content-tab">
                    <button class="btn-tab btn-tab-left active" type="button" data-target="form-login">INICIAR SESIÓN</button>
                    <button class="btn-tab btn-tab-right" type="button" data-target="form-register">REGISTRARME</button>

                    <div id="form-login" class="collapse-form" >
                        <div class="formCont">
                            <br/><br/>

                            <div><label>País</label></div>
                            <div class="formcontrol pais">
                                <asp:DropDownList ID="ddlPais_ingreso" runat="server" ClientIDMode="Static">
                                    <asp:ListItem Value="0" Text="Elige un País"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Bolivia"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Chile"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Colombia"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="Costa Rica"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="Ecuador"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="El Salvador"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="Guatemala"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="México"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="Panamá"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="Perú"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="Puerto Rico"></asp:ListItem>
                                    <asp:ListItem Value="13" Text="República Dominicana"></asp:ListItem>
                                    <asp:ListItem Value="14" Text="Venezuela"></asp:ListItem>
                                </asp:DropDownList>
                                <div id="ErrorPais_ingreso" style="font-size: 11px; color: #ed1556; display: none;">Debe seleccionar su país.</div>
                            </div>
                            <div id="ES_Pais_ingreso" style="height: 10px; display: none;"></div>
                            <br/>

                            <div><label>Usuario</label></div>
                            <div class="formcontrol user">
                                <input id="txtUsuario_ingreso" type="text" class="inputForm ValidaAlfanumerico" maxlength="25" onpaste="return false;" value=""/>
                                <div id="ErrorUsuario_ingreso" style="font-size: 11px; color: #ed1556; display: none;">Debe ingresar un usuario.</div>
                            </div>
                            <div id="ES_Usuario_ingreso" style="height: 10px; display: none;"></div>
                            <br/>

                            <div><label>Contraseña</label></div>
                            <div class="formcontrol pass">
                                <input id="txtContrasenia_ingreso" type="password" class="inputForm" />
                                <div id="ErrorContrasenia_ingreso" style="font-size: 11px; color: #ed1556; display: none;">Debe ingresar una contraseña.</div>
                            </div>
                            <div id="ES_Contrasenia_ingreso" style="height: 10px; display: none;"></div>
                            <br/>                            
                            <div id="ErrorAutenticacion_ingreso" style="height: 20px; font-size: 12px; color: #ed1556; display: none;"></div>

                            <div class="boxform mb-8">
                                <div class="formbtn">
                                    <label for="">
                                        ¿Olvidaste tu contraseña? <a href="RecuperarClaveComunidad.aspx">Recupérala aquí</a>
                                    </label>
                                </div>
                            </div>
                            <div class="formbtn text-center">
                                <input id="btnIngresoComunidad" type="button" class="btnCrear" value="INICIAR SESIÓN" onclick="ValidarFormularioIngreso()"/>
                            </div>
                            <div class="clearfix mb-8"></div>
                        </div>
                    </div>

                    <div id="form-register" class="collapse-form hidden">
                        <div class="formCont">
                        <br/><br/>
                        	<div class="box-left">
                                <div><label>Nombre</label></div>
                                <div class="formcontrol user">
                                    <input id="txtNombre_registro" type="text" class="inputForm" value="" />
                                    <div id="ErrorNombre_registro" style="font-size: 11px; color: #ed1556; display: none;">Debe ingresar su nombre.</div>
                                </div>
                            </div>
                        	<div class="box-right">
                                <div><label>Apellido</label></div>
                                <div class="formcontrol user">
                                    <input id="txtApellido_registro" type="text" class="inputForm" value="" />
                                    <div id="ErrorApellido_registro" style="font-size: 11px; color: #ed1556; display: none;">Debe ingresar su apellido.</div>
                                </div>
                            </div>
                            <div id="ES_Nombre_registro" class="box-left" style="height: 10px; display: none;"></div>
                            <div id="ES_Apellido_registro" class="box-right" style="height: 10px; display: none;"></div>

                            <div class="clear"></div>

                            <div><label>Correo electrónico</label></div>
                            <div class="formcontrol mail mb-8">
                                <input id="txtCorreo_registro" type="text" class="inputForm" value="" onblur="if (this.value != ''){ ValidarCorreoIngresado(this.value); }" />
                                <div id="ErrorCorreo_registro" style="font-size: 11px; color: #ed1556; display: none;"></div>
                                <div id="ValCorreo_registro" style="font-size: 11px; display: none;">
                                    <img src="../Content/Images/loadingCatalogo.gif" width="12" style="vertical-align: middle;" alt="Cargando" />
                                    Validando...
                                </div>
                            </div>
                            <div id="ES_Correo_registro" class="box-left" style="height: 10px; display: none;"></div>

                            <div class="clear"></div>

                        	<div class="box-left">
                                <div><label>Usuario</label></div>
                                <div class="formcontrol user">
                                    <input id="txtUsuario_registro" type="text" class="inputForm ValidaAlfanumerico" maxlength="25" onpaste="return false;" value="" onblur="if (this.value != '') { ValidarUsuarioIngresado(this.value); }" />
                                    <div id="ErrorUsuario_registro" style="font-size: 11px; color: #ed1556; display: none;">Debe ingresar un usuario.</div>
                                    <div id="ValUsuario_registro" style="font-size: 11px; display: none;">
                                        <img src="../Content/Images/loadingCatalogo.gif" width="12" style="vertical-align: middle;" alt="Cargando" />
                                        Validando...
                                    </div>
                                </div>
                            </div>
                        	<div class="box-right">
                                <div><label>Contraseña</label></div>
                                <div class="formcontrol pass">
                                    <input id="txtContrasenia_registro" type="password" class="inputForm" />
                                    <div id="ErrorContrasenia_registro" style="font-size: 11px; color: #ed1556; display: none;">Debe ingresar contraseña.</div>
                                </div>
                            </div>
                            <div id="ES_Usuario_registro" class="box-left" style="height: 10px; display: none;"></div>
                            <div id="ES_Contrasenia_registro" class="box-right" style="height: 10px; display: none;"></div>

                            <div class="clear"></div>

                            <div><label>País</label></div>
                            <div class="formcontrol pais">                                
                                <asp:DropDownList ID="ddlPais_registro" runat="server" ClientIDMode="Static">
                                    <asp:ListItem Value="0" Text="Elige un País"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Bolivia"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Chile"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Colombia"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="Costa Rica"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="Ecuador"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="El Salvador"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="Guatemala"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="México"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="Panamá"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="Perú"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="Puerto Rico"></asp:ListItem>
                                    <asp:ListItem Value="13" Text="República Dominicana"></asp:ListItem>
                                    <asp:ListItem Value="14" Text="Venezuela"></asp:ListItem>
                                </asp:DropDownList>
                                <div id="ErrorPais_registro" style="font-size: 11px; color: #ed1556; display: none;">Debe seleccionar su país.</div>
                            </div>
                            <div id="ES_Pais_registro" class="box-left" style="height: 10px; display: none;"></div>
                            
                            <div class="clearfix"></div>

                            <div class="condiciones">
                                <br/>
                                <div>
                                    <div class="check">
                                        <input id="chkAceptacionCondiciones_registro" type="checkbox" />
                                    </div>
                                    <p>
                                        Acepto las <a href="#" onclick="Condiciones(1)">Condiciones del servicio</a> y la <a href="#" onclick="Condiciones(2)">Política de privacidad</a> de Belcorp.
                                    </p>
                                </div>
                                <div id="ErrorCondiciones_registro" style="font-size: 11px; color: red; display: none; padding-left:42px;">Debe aceptar las condiciones y póliticas.</div>
                            </div>
                            <div id="ES_Condiciones_registro" class="box-left" style="height: 10px; display: none;"></div>
                            
                            <div class="clearfix"></div>
                            
                            <br/>
                            <div class="formbtn text-center">
                                <input id="btnRegistroComunidad" type="button" class="btnCrear" value="CREA TU CUENTA" onclick="ValidarFormularioRegistro()"/>
                            </div>
                            <div class="clearfix mb-8"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div id="pnlExito" style="display: none;">
        <div>
            ¡Gracias por querer ser parte de nuestra comunidad! Para continuar con el proceso, sigue los pasos del correo que te hemos enviado.
        </div>
    </div>
    <div id="pnlError" style="display: none;">
        <div style="text-align: left">
            Error al realizar el proceso de registro. Por favor, volver a intentarlo.
        </div>
    </div>    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <footer class="footer-page">
        <div class="container">
            <img src="../Content/Images/comunidad/logo_foot.png" alt="Belcorp" class="mt-5">
            <div class="pull-right">
                <a href="http://www.lbel.com/" class="links-img-foot" target="_blank"><img src="../Content/Images/comunidad/lbel.png" alt="Belcorp"></a>
                <a href="http://www.esika.biz/" target="_blank" class="links-img-foot"><img src="../Content/Images/comunidad/esika.png" alt="Belcorp"></a>
                <a href="http://www.cyzone.com/" class="links-img-foot" target="_blank"><img src="../Content/Images/comunidad/cyzone.png" alt="Belcorp"></a>
            </div>
            <div class="copy text-right">
                <a href="https://www.facebook.com/SomosBelcorpOficial?fref=ts" target="_blank" class="foot-facebook"><img src="../Content/Images/comunidad/face.png" alt="Belcorp"></a><br/>
                &copy; Belcorp 2016. <span class="hidden-xxs">All Right Reserved.</span>
            </div>
        </div>
    </footer>
</asp:Content>
