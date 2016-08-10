<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/MasterComunidad.Master" AutoEventWireup="true" CodeBehind="RegistroComunidad.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.RegistroComunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            Jqueryplaceholder("txtContrasenia");
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
        })


        function Jqueryplaceholder(Control) {
            var placeholder = $('#' + Control).attr('placeholder');
            $('#' + Control).val(placeholder);
            $('#' + Control).focus(function () {
                var placeholdertext = $(this).attr('placeholder');
                var pass = $('<input id="' + Control + '" class="inputForm" type="password" placeholder="' + placeholdertext + '">');
                $(this).replaceWith(pass);
                $('#' + Control).focus();
                $('#' + Control).blur(function () {
                    if ($(this).val().length == 0) {
                        var placeholdertext = $(this).attr('placeholder');
                        var pass = $('<input id="' + Control + '" class="inputForm" type="text" value="' + placeholdertext + '" placeholder="' + placeholdertext + '">');
                        $(this).replaceWith(pass);
                        Jqueryplaceholder(Control);
                    }
                })
            });
        }

        function ValidarUsuarioIngresado(usuario) {
            $('#ValUsuario').css({ "display": "block" });
            $('#ErrorUsuario').css({ "display": "none" });
            $.ajax({
                type: "POST",
                url: "RegistroComunidad.aspx/ValidarUsuarioIngresado",
                data: "{'usuario': '" + usuario + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#ValUsuario').css({ "display": "none" });
                    $('#ErrorUsuario').css({ "display": "block" });
                    $('#ES_Usuario').css({ "display": "block" });
                    if (data.d == '1') {
                        $('#ErrorUsuario').html("Este Usuario ya existe.");
                        $('#ErrorUsuario').css({ "color": "red" });
                    } else {
                        $('#ErrorUsuario').html("Usuario Disponible.");
                        $('#ErrorUsuario').css({ "color": "green" });
                    }
                },
                error: function (result) {
                    alert('Ocurrió un error al intentar validar el usuario. Por favor, volver a intentar.');
                }
            });
        }

        function ValidarCorreoIngresado(correo) {
            $('#ValCorreo').css({ "display": "block" });
            $('#ErrorCorreo').css({ "display": "none" });
            $.ajax({
                type: "POST",
                url: "RegistroComunidad.aspx/ValidarCorreoIngresado",
                data: "{'correo': '" + correo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#ValCorreo').css({ "display": "none" });
                    $('#ErrorCorreo').css({ "display": "block" });
                    $('#ES_Correo').css({ "display": "block" });
                    if (data.d == '1') {
                        $('#ErrorCorreo').html("Este correo ya existe.");
                        $('#ErrorCorreo').css({ "color": "red" });
                    } else {
                        $('#ErrorCorreo').html("Correo Disponible.");
                        $('#ErrorCorreo').css({ "color": "green" });
                    }
                },
                error: function (result) {
                    alert('Ocurrió un error al intentar validar el correo. Por favor, volver a intentar.');
                }
            });
        }

        function ValidarFormulario() {
            var result = true;

            if (!$('#chkAceptacionCondiciones').prop('checked'))
            {
                $('#ErrorCondiciones').css({ "display": "block" });
                $('#ES_Condiciones').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorCondiciones').css({ "display": "none" });
                $('#ES_Condiciones').css({ "display": "none" });
            }

            if ($('#txtNombre').val() == 'Nombre') {
                $('#ErrorNombre').css({ "display": "block" });
                $('#ES_Nombre').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorNombre').css({ "display": "none" });
                $('#ES_Nombre').css({ "display": "none" });
            }

            if ($('#txtApellido').val() == 'Apellido') {
                $('#ErrorApellido').css({ "display": "block" });
                $('#ES_Apellido').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorApellido').css({ "display": "none" });
                $('#ES_Apellido').css({ "display": "none" });
            }

            if ($('#txtUsuario').val() == 'Usuario') {
                $('#ErrorUsuario').css({ "display": "block" });
                $('#ES_Usuario').css({ "display": "block" });
                $('#ErrorUsuario').html("Debe ingresar un usuario.");
                result = false;
            }
            else {
                if ($('#ErrorUsuario').html() != "Este Usuario ya existe.") {
                    //$('#ErrorUsuario').css({ "display": "none" });
                    //$('#ES_Usuario').css({ "display": "none" });
                    //$('#ErrorUsuario').html('')
                }
            }

            if ($('#txtCorreo').val() == 'Correo electrónico') {
                $('#ErrorCorreo').css({ "display": "block" });
                $('#ES_Correo').css({ "display": "block" });
                $('#ErrorCorreo').html("Debe ingresar su correo.");
                result = false;
            }
            else {
                if (!ValidarCorreo($('#txtCorreo').val())) {
                    $('#ErrorCorreo').css({ "display": "block" });
                    $('#ES_Correo').css({ "display": "block" });
                    $('#ErrorCorreo').html("El formato del correo es incorrecto.");
                    $('#ErrorCorreo').css({ "color": "red" });
                    result = false;
                }
                else {
                    if ($('#ErrorCorreo').html() != "Este correo ya existe.") {
                        //$('#ErrorCorreo').css({ "display": "none" });
                        //$('#ES_Correo').css({ "display": "none" });
                        //$('#ErrorCorreo').html('')
                    }
                }
            }

            if ($('#txtContrasenia').val() == 'Contraseña') {
                $('#ErrorContrasenia').css({ "display": "block" });
                $('#ES_Contrasenia').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorContrasenia').css({ "display": "none" });
                $('#ES_Contrasenia').css({ "display": "none" });
            }

            if ($('#ddlPais').val() == '0') {
                $('#ErrorPais').css({ "display": "block" });
                $('#ES_Pais').css({ "display": "block" });
                result = false;
            }
            else {
                $('#ErrorPais').css({ "display": "none" });
                $('#ES_Pais').css({ "display": "none" });
            }

            if (result) {
                if ($('#ErrorUsuario').html() != 'Usuario Disponible.' || $('#ErrorCorreo').html() != 'Correo Disponible.')
                    return;

                $('#hdfContrasenia').val($('#txtContrasenia').val());

                var item = {
                    CodigoUsuario: $('#txtUsuario').val(),
                    Nombre: $('#txtNombre').val(),
                    Apellido: $('#txtApellido').val(),
                    Contrasenia: $('#hdfContrasenia').val(),
                    Correo: $('#txtCorreo').val(),
                    PaisId: $('#ddlPais').val()
                };

                waitingDialog({});

                RegistrarUsuarioComunidad(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.success == true) {
                        closeWaitingDialog();
                        AbrirAlerta_1();
                    }
                    else {
                        closeWaitingDialog();
                        AbrirAlerta_2();
                    }

                    Limpiar();
                    return false;
                });
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

        function Limpiar() {
            $('#txtUsuario').val("Usuario");
            $('#txtNombre').val("Nombre");
            $('#txtApellido').val("Apellido");
            $('#hdfContrasenia').val("");
            $('#txtContrasenia').val("")
            $('#txtCorreo').val('Correo electrónico');
            $('#ddlPais').val('0');

            $('#ErrorCorreo').css({ "display": "none" });
            $('#ES_Correo').css({ "display": "none" });
            $('#ErrorCorreo').html('')

            $('#ErrorUsuario').css({ "display": "none" });
            $('#ES_Usuario').css({ "display": "none" });
            $('#ErrorUsuario').html('')
        }

        $(document).keypress(function (e) {
            if (e.which == 13)
                $("#btnIngresoComunidad").click();
        });

        function RedirectSB() {
            location.href = $('#hdfSB').val();
        }

        function Condiciones(tipo)
        {
            if ($('#ddlPais').val() == '0') {
                alert("Para visualizar las Condiciones del Servicio y/o Políticas de Privacidad de Belcorp debe seleccionar un país. ");
            }
            else {
                if (tipo == 1) {
                    window.open('comunidad/CondicionesServicio_' + $('#ddlPais').val() + '.html', '_blank');
                }
                else {
                    window.open('comunidad/PoliticasPrivacidad_' + $('#ddlPais').val() + '.html', '_blank');
                }
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdfContrasenia" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfSB" runat="server" ClientIDMode="Static" />
    <div class="wrapMain">
        <div class="webForm">
            <div class="title">
                Soy consultora Belcorp
            </div>
            <div class="formCont">
                <div class="formMen">
                    <p>Inicia sesión en Somos Belcorp para ingresar</p>
                    <p>a la comunidad.</p>
                </div>
                <div class="formbtn">
                    <input id="btnConsultora" type="button" class="btnCrear" value="IR A SOMOS BELCORP" onclick="RedirectSB()">
                </div>
            </div>
        </div>
        <div class="webFormDiv">
        </div>
        <div class="webForm">
            <div class="title">
                No soy consultora Belcorp
            </div>
            <div class="formCont">
                <div class="formMen">
                    <p>Ingresa tus datos para ser parte de la</p>
                    <p>Comunidad Somos Belcorp</p>
                </div>
                <div class="formcontrol user">
                    <input id="txtNombre" type="text" class="inputForm" value="Nombre" onfocus="if (this.value == 'Nombre') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Nombre';}">
                    <div id="ErrorNombre" style="font-size: 11px; color: red; display: none;">Debe ingresar su nombre.</div>
                </div>
                <div id="ES_Nombre" style="height: 10px; display: none;"></div>
                <div class="formcontrol user">
                    <input id="txtApellido" type="text" class="inputForm" value="Apellido" onfocus="if (this.value == 'Apellido') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Apellido';}">
                    <div id="ErrorApellido" style="font-size: 11px; color: red; display: none;">Debe ingresar su apellido.</div>
                </div>
                <div id="ES_Apellido" style="height: 10px; display: none;"></div>
                <div class="formcontrol user">
                    <input id="txtUsuario" type="text" class="inputForm ValidaAlfanumerico" maxlength="25" onpaste="return false;" value="Usuario" onfocus="if (this.value == 'Usuario') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Usuario';}else{if (this.value != 'Usuario') {ValidarUsuarioIngresado(this.value);}}">
                    <div id="ErrorUsuario" style="font-size: 11px; color: red; display: none;">Debe ingresar un usuario.</div>
                    <div id="ValUsuario" style="font-size: 11px; display: none;">
                        <img src="../Content/Images/loadingCatalogo.gif" width="12" style="vertical-align: middle;" alt="Cargando" />
                        Validando...
                    </div>
                </div>
                <div id="ES_Usuario" style="height: 10px; display: none;"></div>
                <div class="formcontrol mail">
                    <input id="txtCorreo" type="text" class="inputForm" value="Correo electrónico" onfocus="if (this.value == 'Correo electrónico') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Correo electrónico';}else{if (this.value != 'Correo electrónico') {ValidarCorreoIngresado(this.value);}}">
                    <div id="ErrorCorreo" style="font-size: 11px; color: red; display: none;"></div>
                    <div id="ValCorreo" style="font-size: 11px; display: none;">
                        <img src="../Content/Images/loadingCatalogo.gif" width="12" style="vertical-align: middle;" alt="Cargando" />
                        Validando...
                    </div>
                </div>
                <div id="ES_Correo" style="height: 10px; display: none;"></div>
                <div class="formcontrol pass">
                    <input id="txtContrasenia" type="text" class="inputForm" placeholder="Contraseña">
                    <div id="ErrorContrasenia" style="font-size: 11px; color: red; display: none;">Debe ingresar una contraseña.</div>
                </div>
                <div id="ES_Contrasenia" style="height: 10px; display: none;"></div>
                <div class="formcontrol pais">
                    <asp:DropDownList ID="ddlPais" runat="server" ClientIDMode="Static">
                        <asp:ListItem Value="0" Text="País"></asp:ListItem>
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
                    <div id="ErrorPais" style="font-size: 11px; color: red; display: none;">Debe seleccionar su país.</div>
                </div>
                <div id="ES_Pais" style="height: 10px; display: none;"></div>
                <div style="height:42px;">
                    <div>
                        <div style="float:left; padding-left:15px; padding-top:5px; width:9%;">
                            <input id="chkAceptacionCondiciones" type="checkbox" />
                        </div>
                        <div style="float:left; width:80%;">
                            Acepto las <a href="#" onclick="Condiciones(1)" style="color: #993399">Condiciones del servicio</a> y la <a href="#" onclick="Condiciones(2)" style="color: #993399">Política de privacidad</a> de Belcorp.
                        </div>
                    </div>
                    <div id="ErrorCondiciones" style="font-size: 11px; color: red; display: none; padding-left:42px;">Debe aceptar las condiciones y póliticas.</div>
                </div>
                <div style="height: 10px;"></div>
                <div id="ES_Condiciones" style="height: 10px; display: none;"></div>
                <div class="formbtn">
                    <input id="btnIngresoComunidad" type="button" class="btnCrear" value="CREA TU CUENTA" onclick="ValidarFormulario()">
                </div>
                <div style="height: 10px;"></div>
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
            Error al realizar el proceso de registro. Por favor, volver a intertarlo.
        </div>
    </div>
</asp:Content>
