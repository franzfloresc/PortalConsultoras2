<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/MasterComunidad.Master" AutoEventWireup="true" CodeBehind="CambiarClaveComunidad.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.CambiarClaveComunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            Jqueryplaceholder("txtContrasenia");
            Jqueryplaceholder("txtContraseniaConf");
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
        function ValidarFormulario() {
            var result = true;

            if ($('#txtContrasenia').val() == 'Nueva contraseña') {
                $('#ErrorContrasenia').css({ "display": "block" });
                $('#ES_Contrasenia').css({ "display": "block" });
                $('#ErrorContrasenia').html("Debe ingresar una contraseña");
                result = false;
            }
            else {
                $('#ErrorContrasenia').css({ "display": "none" });
                $('#ES_Contrasenia').css({ "display": "none" });
                $('#ErrorContrasenia').html("");
            }

            if ($('#txtContraseniaConf').val() == 'Confirmar nueva contraseña') {
                $('#ErrorContrasenia').css({ "display": "block" });
                $('#ES_Contrasenia').css({ "display": "block" });
                $('#ErrorContrasenia').html("Debe confirmar su contraseña");
                result = false;
            }
            else {
                $('#ErrorContrasenia').css({ "display": "none" });
                $('#ES_Contrasenia').css({ "display": "none" });
                $('#ErrorContrasenia').html("");
            }
            
            if ($('#txtContrasenia').val() != $('#txtContraseniaConf').val()) {
                $('#ErrorContrasenia').css({ "display": "block" });
                $('#ES_Contrasenia').css({ "display": "block" });
                $('#ErrorContrasenia').html("Las contraseñas ingresadas no son iguales");
                result = false;
            }
            else {
                $('#ErrorContrasenia').css({ "display": "none" });
                $('#ES_Contrasenia').css({ "display": "none" });
                $('#ErrorContrasenia').html("");
            }

            if (result) {
                $('#hdfContrasenia').val($('#txtContrasenia').val());

                var item = {
                    Contrasenia: $('#hdfContrasenia').val(),
                    UsuarioId: $('#hdfUsuarioId').val()
                };

                waitingDialog({});

                CambiarClaveUsuarioComunidad(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.success == true) {
                        closeWaitingDialog();
                        $("#Mensaje").html(result.message);
                        AbrirAlerta_1(1);
                    }
                    else {
                        closeWaitingDialog();
                        $("#Mensaje").html(result.message);
                        AbrirAlerta_1(0);
                    }

                    return false;
                });
            }
        }
        $(document).keypress(function (e) {
            if (e.which == 13)
                $("#btnCambiarContrasenia").click();
        });
        function AbrirAlerta_1(tipo) {
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
                        if (tipo = 1)
                        {
                            location.href = "IngresoComunidad.aspx";
                        }
                    }
                }
            });
        }
        function Limpiar() {
            $('#hdfContrasenia').val("");
            $('#txtContrasenia').val("")
            $('#txtContraseniaConf').val("")
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdfUsuarioId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfContrasenia" runat="server" ClientIDMode="Static" />
    <div class="wrapMain">
        <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
            <div class="webFormMessage">
            </div>
            <div class="webFormMessage" style="font-size: 16px;">
                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            </div>
            <div class="webFormMessage">
                <div class="formbtn">
                    <asp:Button ID="btnRegresar" Text="REGRESAR" CssClass="btnCrear" runat="server" OnClick="btnRegresar_Click" />
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlCambio" runat="server" Visible="false">
            <div class="webForm">
                <div class="title">
                    Cambia tu contraseña
                </div>
                <div class="formCont">
                    <div class="formcontrol pass">
                        <input id="txtContrasenia" type="text" class="inputForm" placeholder="Nueva contraseña">
                    </div>
                    <div class="formcontrol pass">
                        <input id="txtContraseniaConf" type="text" class="inputForm" placeholder="Confirmar nueva contraseña">
                        <div id="ErrorContrasenia" style="font-size: 11px; color: red; display: none;"></div>
                    </div>
                    <div id="ES_Contrasenia" style="height: 10px; display: none;"></div>
                    <div style="height: 20px;"></div>
                    <div class="formbtn2">
                        <input id="btnCambiarContrasenia" type="button" class="btnCrear" value="CAMBIAR CONTRASEÑA" onclick="ValidarFormulario()">
                    </div>
                    <div class="formbtn3">
                        <a href="IngresoComunidad.aspx">Cancelar</a>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
    <div id="pnlExito" style="display: none;">
        <div id="Mensaje">
        </div>
    </div>
</asp:Content>
