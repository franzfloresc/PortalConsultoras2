<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/MasterComunidad.Master" AutoEventWireup="true" CodeBehind="CambiarUsuarioComunidad.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.CambiarUsuarioComunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('body').css('background', 'url("../../Content/images/comunidad/bg_regis_2.jpg") top center no-repeat #FFF');
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
                        $('#ErrorUsuario').html("Este apodo ya existe.");
                        $('#ErrorUsuario').css({ "color": "red" });
                    } else {
                        $('#ErrorUsuario').html("Apodo Disponible.");
                        $('#ErrorUsuario').css({ "color": "green" });
                    }
                },
                error: function (result) {
                    alert('Ocurrió un error al intentar validar el usuario. Por favor, volver a intentar.');
                }
            });
        }

        function ValidarFormulario() {
            var result = true;

            if ($('#txtUsuario').val() == 'Tu nuevo apodo') {
                $('#ErrorUsuario').css({ "display": "block" });
                $('#ES_Usuario').css({ "display": "block" });
                $('#ErrorUsuario').html("Debe ingresar un nuevo apodo.");
                result = false;
            }
            else {
                if ($('#txtUsuario').val() == $('#txtUsuarioActual').val()) {
                    $('#ErrorUsuario').css({ "display": "block" });
                    $('#ES_Usuario').css({ "display": "block" });
                    $('#ErrorUsuario').html("Debe ingresar un apodo diferente al actual.");
                    result = false;
                }
            }

            if (result) {
                if ($('#ErrorUsuario').html() != 'Apodo Disponible.')
                    return;

                var item = {
                    CodigoUsuario: $('#txtUsuario').val(),
                };

                waitingDialog({});

                CambiarApodoComunidad(JSON.stringify(item), function (output, context) {
                    var result = JSON.parse(output);
                    if (result.success == true) {
                        closeWaitingDialog();
                        $("#divMensaje").css({ "display": "block" });
                        $("#divCambio").css({ "display": "none" });
                    }
                    else {
                        closeWaitingDialog();
                        $("#Mensaje").html(result.message);
                        AbrirAlerta_1();
                    }

                    Limpiar();
                    return false;
                });
            }
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

        function Limpiar() {
            $('#txtUsuario').val("Tu nuevo apodo");

            $('#ErrorUsuario').css({ "display": "none" });
            $('#ES_Usuario').css({ "display": "none" });
            $('#ErrorUsuario').html('')
        }

        $(document).keypress(function (e) {
            if (e.which == 13)
                $("#btnCambiarUsuario").click();
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdfCodigoUsuarioActual" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfCodigoUsuarioNuevo" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfUsuarioComunidadId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfEsConsultora" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfPaisId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfCodigoUsuarioSB" runat="server" ClientIDMode="Static" />
    <div class="wrapMain_B">
        <div id="divMensaje" style="display: none; margin-right: 20%">
            <div class="webFormMessage" style="font-size: 25px; font-weight: normal; line-height: normal;">
                <p>El cambio de tu apodo fue realizado</p>
                <p>de manera satisfactoria.</p>
            </div>
            <div class="webFormMessage" style="padding-top: 20px;">
                <div class="formbtn">
                    <asp:Button ID="btnRegresar" Text="IR A LA COMUNIDAD" CssClass="btnCrear" runat="server" OnClick="btnIrComunidad_Click" />
                </div>
            </div>
        </div>
        <div id="divCambio" style="display: block;">
            <div class="webFormDiv_B">
            </div>
            <div class="webForm_B">
                <div class="title_B">
                    CAMBIA TU APODO EN LA COMUNIDAD
                </div>
                <div class="formCont">
                    <div class="formMen_B">
                        <p>Para proceder con el cambio hemos cerrado tu sesión en la comunidad. Una vez realizado</p>
                        <p>el cambio, se iniciará sesión de manera automática.</p>
                    </div>

                </div>
                <div class="formCont" style="width: 326px;">
                    <div class="formcontrol_B user">
                        <input id="txtUsuarioActual" runat="server" type="text" class="inputForm_B" value="" readonly="readonly">
                    </div>
                    <div class="formcontrol_C user">
                        <input id="txtUsuario" type="text" class="inputForm_C ValidaAlfanumerico" maxlength="25" onpaste="return false;" value="Tu nuevo apodo" onfocus="if (this.value == 'Tu nuevo apodo') {this.value = '';$(this).css({ 'color': '#425363' });}" onblur="if (this.value == '') {this.value = 'Tu nuevo apodo';$(this).css({ 'color': '#d8d8d8' });}else{$(this).css({ 'color': '#425363' });if (this.value != 'Tu nuevo apodo') {ValidarUsuarioIngresado(this.value);}}">
                        <div id="ErrorUsuario" style="font-size: 11px; color: red; display: none;">Debe ingresar un nuevo apodo.</div>
                        <div id="ValUsuario" style="font-size: 11px; display: none;">
                            <img src="../Content/Images/loadingCatalogo.gif" width="12" style="vertical-align: middle;" alt="Cargando" />
                            Validando...
                        </div>
                    </div>
                    <div id="ES_Usuario" style="height: 10px; display: none;"></div>
                    <div style="height: 30px;"></div>
                    <div class="formbtn2" style="float: none;">
                        <input id="btnCambiarUsuario" type="button" class="btnCrear" value="CAMBIAR APODO" onclick="ValidarFormulario()">
                    </div>
                    <div class="formbtn4">
                        <asp:LinkButton ID="lbtnRegresar" runat="server" Text="< Volver" OnClick="lbtnRegresar_Click"></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="pnlExito" style="display: none;">
        <div id="Mensaje">
        </div>
    </div>
</asp:Content>
