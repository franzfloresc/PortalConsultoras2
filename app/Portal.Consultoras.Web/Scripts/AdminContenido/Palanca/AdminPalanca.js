﻿
var _toastHelper = ToastHelper();
var _listPalanca = ["LAN", "RDR", "RD", "OPT"];
var _palanca = {
    showroom: "SR",
    odd: "ODD"
}

var _tipopresentacion = {
    showroom: "5",
    odd: "6",
    banner: "4",
    bannerInterativo: "10"
}

jQuery(document).ready(function () {
    admPalancaDatos.ini();

    UpdateGrillaOfertas();
    UpdateGrillaPalanca();
    IniDialogs();

    $("#btnBuscar").click(function () {
        UpdateGrillaOfertas();
    });


    $("#ddlTipoEstrategia").change(function () {

    });

    $.jgrid.extend({
        Editar: Modificar,
        EditarOfertas: ModificarOfertas,
    });

    $("body").on("change", "#cbDesktopCantidadTodos", function () {
        var esTrue = $(this).is(":checked");

        if (esTrue) {
            $("#DesktopCantidadProductos").attr("disabled", "disabled");
            $("#DesktopCantidadProductos").val("0");
        } else {
            $("#DesktopCantidadProductos").removeAttr("disabled");
        }
    });

    $("body").on("change", "#cbMobileCantidadTodos", function () {
        var esTrue = $(this).is(":checked");

        if (esTrue) {
            $("#MobileCantidadProductos").attr("disabled", "disabled");
            $("#MobileCantidadProductos").val("0");
        } else {
            $("#MobileCantidadProductos").removeAttr("disabled");
        }
    });

    $("body").on("change", "#cbAncla", function () {
        var esTrue = $(this).is(":checked");

        if (esTrue) {
            $("#UrlMenu").attr("disabled", "disabled");
            $("#UrlMenu").val("#");
        } else {
            $("#UrlMenu").removeAttr("disabled");
            $("#UrlMenu").val("");
        }
    });

    $("body").on("change", "#ddlConfiguracionIdOfertas", function () {

        if (_listPalanca.indexOf($(this).find("option:selected").attr("data-codigo")) > -1) {
            $(".hide-configuration").show();
        } else {
            $(".hide-configuration").hide();
        }
        
        if ($(this).find("option:selected").attr("data-codigo") === _palanca.odd) {
            $(".hide-config-image-odd").show();
        } else {
            $(".hide-config-image-odd").hide();
        }

        if ($(this).find("option:selected").attr("data-codigo") == ConstantesModule.TipoEstrategia.ATP) {
            $(".div-disenio-atp-visible").show();
            $(".div-disenio-atp-oculto").hide();
            $("#tituloSeccionDesktop").html("Desktop/Mobile");
            $("#titColorTexto").html("Color de títulos");
            $("#DesktopTitulo").val("ARMA TU PACK");
            $("#DesktopColorFondo").val("#fa1702");
            $("#DesktopSubTitulo").val("Elige #Cantidad y llevátelos al #PrecioTotal");
            $("#DesktopColorTexto").val("#ffffff");
            $("#BotonTexto1").val("Comenzar");
            $("#BotonTexto2").val("Modificar");
            $("#BotonColor").val("#000000");
            $("#BotonColorTexto").val("#ffffff");
            $("#DesktopCantidadProductos").val("0");
            $("#DesktopOrden").val("1");            
            $("#cbDesktopCantidadTodos").prop("checked", true);
            $("#DesktopCantidadProductos").attr("disabled", "disabled");
            $("#ddlDesktopTipoPresentacionOfertas").val(_tipopresentacion.bannerInterativo);   
            $("#titTamanioImagenFondo").html("(Ancho: 1920 px x Alto: 300 px)");
        }else {
            $(".div-disenio-atp-visible").hide();
            $(".div-disenio-atp-oculto").show();
            $("#tituloSeccionDesktop").html("Desktop");
            $("#titColorTexto").html("Color Texto:");
        }
    });
});

function Modificar(idConfiguracionPais, event) {
    $.ajax({
        url: baseUrl + "AdministrarPalanca/GetPalanca",
        type: "GET",
        dataType: "html",
        data: { idConfiguracionPais: idConfiguracionPais },
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $("#dialog-content-palanca").empty();
            $("#dialog-content-palanca").html(result).ready(
                UploadFilePalanca("icono"), UploadFilePalanca("desktop-fondo-banner"), UploadFilePalanca("desktop-logo-banner"),
                UploadFilePalanca("mobile-fondo-banner"), UploadFilePalanca("mobile-logo-banner")
            );


            showDialog("DialogMantenimientoPalanca");

            var esTrueAncla = $.trim($("#UrlMenu").val()) == "#";

            if (esTrueAncla) {
                $("#cbAncla").prop("checked", true);
                $("#UrlMenu").attr("disabled", "disabled");
            }

            /*INIT Agana 159*/
             
            var esATP = $.trim($("#Codigo").val()) === ConstantesModule.TipoEstrategia.ATP;
           
            if (esATP) {
                $("#lblDesktop").html('Desktop/Mobile');

                $("#divUrlMenu").hide();
                $("#divUrlMenuTxt").hide();

                $("#divDesktopFondo").hide();
                $("#divDesktopLogo").hide();

                $("#divSeccionMobileTitulo").hide();
                $("#divSeccionMobile").hide();

                $("#divOrdenBPT").hide();
                $("#divDesktopSubTituloMenu").hide();
                $("#divDesktopTituloBanner").hide();
                $("#divDesktopSubTituloBanner").hide();       
            } else {
                $("#lblDesktop").html('Desktop');//Default
                $("#divUrlMenu").show();
                $("#divUrlMenuTxt").show();

                $("#divDesktopFondo").show();
                $("#divDesktopLogo").show();

                $("#divSeccionMobileTitulo").show();
                $("#divSeccionMobile").show();

                $("#divOrdenBPT").show();
                $("#divDesktopSubTituloMenu").show();
                $("#divDesktopTituloBanner").show();
                $("#divDesktopSubTituloBanner").show();
            }

            /*END Agana 159*/

             /*Ini Agana 186*/

            if ($(this).find("option:selected").attr("data-codigo") == ConstantesModule.TipoEstrategia.ATP) {
                $(".div-disenio-atp-visible").show();
                $(".div-disenio-atp-oculto").hide();
                $("#tituloSeccionDesktop").html("Desktop/Mobile");
                $("#titColorTexto").html("Color de títulos");
                $("#titTamanioImagenFondo").html("(Ancho: 1920 px x Alto: 300 px)");
            }

             /*Fin Agana 186*/
        },
        error: function (request, status, error) { }
    });
}

function NuevoOfertaHome() {
    ModificarOfertas(0);
}
function ModificarOfertas(idOfertasHome) {
    waitingDialog({});

    $.ajax({
        url: baseUrl + "AdministrarPalanca/GetOfertasHome",
        type: "GET",
        dataType: "html",
        data: { idOfertasHome: idOfertasHome },
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            closeWaitingDialog();

            $("#dialog-content-ofertas-home").empty();
            $("#dialog-content-ofertas-home").html(result).ready(
                UploadFilePalanca("fondo-mobile"), UploadFilePalanca("fondo-desktop"), UploadFilePalancaApp("fondo-app")
            );

            showDialog("DialogMantenimientoOfertasHome");

            var esTrueDesktopCantidad = $.trim($("#DesktopCantidadProductos").val()) == "0";
            if (esTrueDesktopCantidad) {
                $("#cbDesktopCantidadTodos").prop("checked", true);
                $("#DesktopCantidadProductos").attr("disabled", "disabled");
            }

            var esTrueMobileCantidad = $.trim($("#MobileCantidadProductos").val()) == "0";
            if (esTrueMobileCantidad) {
                $("#cbMobileCantidadTodos").prop("checked", true);
                $("#MobileCantidadProductos").attr("disabled", "disabled");
            }
            if (_listPalanca.indexOf($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo")) > -1) {
                $(".hide-configuration").show();
            } else {
                $(".hide-configuration").hide();
            }

            /*Inicia Agana 186 */
            if ($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") == ConstantesModule.TipoEstrategia.ATP) {               
                $(".div-disenio-atp-visible").show();
                $(".div-disenio-atp-oculto").hide();
                $("#tituloSeccionDesktop").html("Desktop/Mobile");
                $("#titColorTexto").html("Color de títulos");                
            }
            /*Fin Agana 186 */

        },
        error: function (request, status, error) { }
    });
}
function IniDialogs() {
    $("#DialogMantenimientoPalanca").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 830,
        draggable: false,
        title: "Menú",
        open: function (event, ui) {
            //(".ui-dialog-titlebar-close", ui.dialog).hide(); //eaar tiene bug
        },
        close: function () {
            HideDialog("DialogMantenimientoPalanca");
        },
        buttons:
        {
            "Guardar": function () {
                //valores para enviar al actualizar la palanca
                if (isNaN($("#Orden").val())) {
                    _toastHelper.error("El valor del orden tiene que ser numerico.");
                    return false;
                }

                /*INIT AGANA 159 */
                var esATP = $.trim($("#Codigo").val()) === ConstantesModule.TipoEstrategia.ATP;

                if (esATP) {
                    //valores a replicar
                    $("#OrdenBpt").val($("#Orden").val());
                    $("#DialogMantenimientoPalanca #MobileOrden").val($("#Orden").val());
                    $("#DialogMantenimientoPalanca #MobileOrdenBpt").val($("#Orden").val());
                    $("#MobileTituloMenu").val($("#DesktopTituloMenu").val());
                }
                /*END AGANA 159 */

                var params = {
                    ConfiguracionPaisID: $("#ConfiguracionPaisID").val(),
                    Codigo: $("#ddlConfiguracionPais").val(),
                    Excluyente: $("input[name='Excluyente']:checked").val(),
                    Estado: $("#Estado").is(":checked"),
                    Logo: $("#nombre-icono").val(),
                    Orden: $("#Orden").val(),
                    DesdeCampania: $("#ddlCampania").val(),
                    DesktopTituloMenu: $("#DesktopTituloMenu").val(),
                    MobileTituloMenu: $("#MobileTituloMenu").val(),
                    DesktopSubTituloMenu: $("#DesktopSubTituloMenu").val(),
                    MobileSubTituloMenu: $("#MobileSubTituloMenu").val(),
                    DesktopTituloBanner: $("#DesktopTituloBanner").val(),
                    DesktopSubTituloBanner: $("#DesktopSubTituloBanner").val(),
                    MobileTituloBanner: $("#MobileTituloBanner").val(),
                    MobileSubTituloBanner: $("#MobileSubTituloBanner").val(),
                    DesktopFondoBanner: $("#nombre-desktop-fondo-banner").val(),
                    DesktopLogoBanner: $("#nombre-desktop-logo-banner").val(),
                    MobileFondoBanner: $("#nombre-mobile-fondo-banner").val(),
                    MobileLogoBanner: $("#nombre-mobile-logo-banner").val(),
                    UrlMenu: $("#UrlMenu").val(),
                    OrdenBpt: $("#OrdenBpt").val(),
                    MobileOrden: $("#DialogMantenimientoPalanca #MobileOrden").val(),
                    MobileOrdenBpt: $("#DialogMantenimientoPalanca #MobileOrdenBpt").val()
                };
                jQuery.ajax({
                    type: "POST",
                    url: baseUrl + "AdministrarPalanca/Update",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        if (data.success) {
                            HideDialog("DialogMantenimientoPalanca"); 
                             //_toastHelper.error("Solicitud realizada sin problemas.");
                            showDialogMensaje("Solicitud realizada sin problemas.", '');
                            UpdateGrillaPalanca();
                        } else {
                            //_toastHelper.error("Error al procesar la Solicitud.");
                            showDialogMensaje("Error al procesar la Solicitud.", '');
                        }
                    },
                    error: function (data, error) {
                        //_toastHelper.error("Error al procesar la Solicitud.");
                        showDialogMensaje("Error al procesar la Solicitud.", '');
                    }
                });

            },
            "Salir": function () {
                $("#ddlTipoEstrategia").val($("#hdEstrategiaIDConsulta").val());
                HideDialog("DialogMantenimientoPalanca");
            }
        }
    });

    $("#DialogMantenimientoOfertasHome").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        closeOnEscape: true,
        width: 830,
        draggable: false,
        title: "Home",
        close: function () {
            $('div[id^="collorpicker_"]').hide();
            HideDialog("DialogMantenimientoOfertasHome");
        },
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog).hide();
            $("#colorpickerHolder").ColorPicker({ flat: true });
            $("#DesktopColorFondo, #DesktopColorTexto, #MobileColorFondo, #MobileColorTexto, #AdministrarOfertasHomeAppModel_AppColorFondo, #AdministrarOfertasHomeAppModel_AppColorTexto, #BotonColor, #BotonColorTexto").ColorPicker({
                onSubmit: function (hsb, hex, rgb, el) {
                    var newValue = "#" + hex;
                    $(el).val(newValue);
                    $(el).ColorPickerHide();
                },
                onBeforeShow: function () {
                    $(this).ColorPickerSetColor(this.value);
                }
            })
                .bind("keyup", function () {
                    $(this).ColorPickerSetColor(this.value);
                });

            if ($("#DesktopColorFondo").val() === "") {
                $("#DesktopColorFondo").val("#000000");
            }
            if ($("#MobileColorFondo").val() === "") {
                $("#MobileColorFondo").val("#000000");
            }
            if ($("#AdministrarOfertasHomeAppModel_AppColorFondo").val() === "") {
                $("#AdministrarOfertasHomeAppModel_AppColorFondo").val("#000000");
            }
            if ($("#DesktopColorTexto").val() === "") {
                $("#DesktopColorTexto").val("#ffffff");
            }
            if ($("#MobileColorTexto").val() === "") {
                $("#MobileColorTexto").val("#ffffff");
            }
            if ($("#AdministrarOfertasHomeAppModel_AppColorTexto").val() === "") {
                $("#AdministrarOfertasHomeAppModel_AppColorTexto").val("#ffffff");
            }

            if ($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") !== _palanca.odd) {
                $(".hide-config-image-odd").hide();
            }
        },
        buttons:
        {
            "Guardar": function () {
                //valores para seccion de home del contenedor de ofertas

                if ($("#ddlConfiguracionIdOfertas").val() == "" || isNaN($("#ddlConfiguracionIdOfertas").val())) {
                    _toastHelper.error("Selecione una Configuracion Oferta.");
                    return false;
                }
                if ($("#ddlCampaniaOfertas").val() == "" || isNaN($("#ddlCampaniaOfertas").val())) {
                    _toastHelper.error("Seleccione una campaña.");
                    return false;
                }
                if (isNaN($("#DesktopOrden").val())) {
                    _toastHelper.error("El valor del orden tiene que ser numérico.");
                    return false;
                }
                if (isNaN($("#DesktopCantidadProductos").val())) {
                    _toastHelper.error("El valor de cantidad de productos debe ser numérico.");
                    return false;
                }
                if (isNaN($("#MobileCantidadProductos").val())) {
                    _toastHelper.error("El valor de cantidad de productos debe ser numérico.");
                    return false;
                }

                if ($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") === _palanca.odd &&
                    $("#DesktopUsarImagenFondo").prop("checked") && $("#nombre-fondo-desktop").val() === "") {
                    _toastHelper.error("Se dede seleccionar una imagen para usar como fondo en desktop.");
                    return false;
                }

                if ($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") === _palanca.odd &&
                    $("#MobileUsarImagenFondo").prop("checked") && $("#nombre-fondo-mobile").val() === "") {
                    _toastHelper.error("Se dede seleccionar una imagen para usar como fondo en móvil.");
                    return false;
                }

                var desktopTipoPresentacion = $("#ddlDesktopTipoPresentacionOfertas").val();
                var mobileTipoPresentacion = $("#ddlMobileTipoPresentacionOfertas").val();
                var desktopColorFondo = $("#DesktopColorFondo").val();
                var mobileColorFondo = $("#MobileColorFondo").val();
                var desktopColorTexto = $("#DesktopColorTexto").val();
                var mobileColorTexto = $("#MobileColorTexto").val();
                var desktopUsarImagenFondo = $("#DesktopUsarImagenFondo").prop("checked");
                var mobileUsarImagenFondo = $("#MobileUsarImagenFondo").prop("checked");
                var botonColor = $("#BotonColor").val();
                var botonColorTexto = $("#BotonColorTexto").val();

                var regExpColorHex = /^#+([a-fA-F0-9]{6})/;
                if (!regExpColorHex.test(desktopColorFondo) && desktopColorFondo !== "") {
                    _toastHelper.error("El color de fondo para desktop debe tener un código hexadecimal válido.");
                    return false;
                }

                if (!regExpColorHex.test(mobileColorFondo) && mobileColorFondo !== "") {
                    _toastHelper.error("El color de fondo para móvil debe tener un código hexadecimal válido.");
                    return false;
                }

                if (!regExpColorHex.test(desktopColorTexto) && desktopColorTexto !== "") {
                    _toastHelper.error("El color de texto para desktop debe tener un código hexadecimal válido.");
                    return false;
                }

                if (!regExpColorHex.test(mobileColorTexto) && mobileColorTexto !== "") {
                    _toastHelper.error("El color de texto para móvil debe tener un código hexadecimal válido.");
                    return false;
                }

                var esATP = $.trim($("#Codigo").val()) === ConstantesModule.TipoEstrategia.ATP;

                if (esATP) {
                    if (!regExpColorHex.test(botonColor) && botonColor !== "") {
                        _toastHelper.error("El color del botón debe tener un código hexadecimal válido.");
                        return false;
                    }

                    if (!regExpColorHex.test(botonColorTexto) && botonColorTexto !== "") {
                        _toastHelper.error("El color del mensaje del botón debe tener un código hexadecimal válido.");
                        return false;
                    }
                }


                if ($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") === _palanca.odd) {
                    desktopTipoPresentacion = _tipopresentacion.odd;
                    mobileTipoPresentacion = _tipopresentacion.odd;
                } else {
                    desktopColorFondo = "";
                    mobileColorFondo = "";
                    desktopColorTexto = "";
                    mobileColorTexto = "";
                    desktopUsarImagenFondo = false;
                    mobileUsarImagenFondo = false;
                }

                /*Inicio Agana 186 - Setear valores por defecto*/

                if ($("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") == ConstantesModule.TipoEstrategia.ATP) {
                    desktopColorFondo = $("#DesktopColorFondo").val();
                    mobileColorFondo = desktopColorFondo;
                    desktopColorTexto = $("#DesktopColorTexto").val();
                    mobileColorTexto = desktopColorTexto;
                    desktopUsarImagenFondo = $("#DesktopUsarImagenFondo").prop("checked");
                    mobileUsarImagenFondo = desktopUsarImagenFondo;

                    $("#DesktopOrdenBpt").val($("#DesktopOrden").val());
                    $("#MobileOrden").val($("#DesktopOrden").val());
                    $("#MobileOrdenBpt").val($("#DesktopOrden").val());
                    $("#nombre-fondo-mobile").val($("#nombre-fondo-desktop").val());
                    $("#src-fondo-mobile").attr("src", $("#src-fondo-desktop").attr("src"));
                    $("#MobileTitulo").val($("#DesktopTitulo").val());
                    $("#MobileSubTitulo").val($("#DesktopSubTitulo").val());

                }

                /*Fin Agana 186*/

                if (isNaN($("#AdministrarOfertasHomeAppModel_AppOrden").val())) {
                    _toastHelper.error("El valor del orden app tiene que ser numérico.");
                    return false;
                }
                if (isNaN($("#AdministrarOfertasHomeAppModel_AppCantidadProductos").val())) {
                    _toastHelper.error("El valor de cantidad de productos app debe ser numérico.");
                    return false;
                }
                var AppColorFondo = $("#AdministrarOfertasHomeAppModel_AppColorFondo").val();
                var AppColorTexto = $("#AdministrarOfertasHomeAppModel_AppColorTexto").val();
                if (!regExpColorHex.test(AppColorFondo) && AppColorFondo !== "") {
                    _toastHelper.error("El color de fondo para app debe tener un código hexadecimal válido.");
                    return false;
                }
                if (!regExpColorHex.test(AppColorTexto) && AppColorTexto !== "") {
                    _toastHelper.error("El color de texto para app debe tener un código hexadecimal válido.");
                    return false;
                }

                var params = {
                    ConfiguracionOfertasHomeID: $("#ConfiguracionOfertasHomeID").val(),
                    ConfiguracionPaisID: $("#ddlConfiguracionIdOfertas").val(),
                    CampaniaID: $("#ddlCampaniaOfertas").val(),
                    DesktopOrden: $("#DesktopOrden").val(),
                    MobileOrden: $("#DialogMantenimientoOfertasHome #MobileOrden").val(),
                    DesktopColorFondo: desktopColorFondo,
                    MobileColorFondo: mobileColorFondo,
                    DesktopUsarImagenFondo: desktopUsarImagenFondo,
                    MobileUsarImagenFondo: mobileUsarImagenFondo,
                    DesktopImagenFondo: $("#nombre-fondo-desktop").val(),
                    MobileImagenFondo: $("#nombre-fondo-mobile").val(),
                    DesktopColorTexto: desktopColorTexto,
                    MobileColorTexto: mobileColorTexto,
                    DesktopTitulo: $("#DesktopTitulo").val(),
                    MobileTitulo: $("#MobileTitulo").val(),
                    DesktopSubTitulo: $("#DesktopSubTitulo").val(),
                    MobileSubTitulo: $("#MobileSubTitulo").val(),
                    DesktopTipoPresentacion: desktopTipoPresentacion,
                    MobileTipoPresentacion: mobileTipoPresentacion,
                    DesktopTipoEstrategia: GetStringEstrategia("desktop-tipo-estrategia"),
                    MobileTipoEstrategia: GetStringEstrategia("mobile-tipo-estrategia"),
                    DesktopCantidadProductos: $("#DesktopCantidadProductos").val(),
                    MobileCantidadProductos: $("#MobileCantidadProductos").val(),
                    DesktopActivo: $("#DesktopActivo").is(":checked"),
                    MobileActivo: $("#MobileActivo").is(":checked"),
                    UrlSeccion: $("#UrlSeccion").val(),
                    DesktopOrdenBpt: $("#DesktopOrdenBpt").val(),
                    MobileOrdenBpt: $("#DialogMantenimientoOfertasHome #MobileOrdenBpt").val(),
                    AdministrarOfertasHomeAppModel:
                    {
                        ConfiguracionOfertasHomeAppID: $("#AdministrarOfertasHomeAppModel_ConfiguracionOfertasHomeAppID").val(),
                        AppActivo: $("#AdministrarOfertasHomeAppModel_AppActivo").is(":checked"),
                        AppTitulo: $("#AdministrarOfertasHomeAppModel_AppTitulo").val(),
                        AppColorFondo: $("#AdministrarOfertasHomeAppModel_AppColorFondo").val(),
                        AppColorTexto: $("#AdministrarOfertasHomeAppModel_AppColorTexto").val(),
                        AppBannerInformativo: $("#nombre-fondo-app").val(),
                        AppOrden: $("#AdministrarOfertasHomeAppModel_AppOrden").val(),
                        AppCantidadProductos: $("#AdministrarOfertasHomeAppModel_AppCantidadProductos").val(),
                    },
                    BotonTexto1 : $("#BotonTexto1").val(),
                    BotonTexto2 : $("#BotonTexto2").val(),
                    BotonColor : $("#BotonColor").val(),
                    BotonColorTexto: $("#BotonColorTexto").val(),
                    Codigo: $("#ddlConfiguracionIdOfertas").find("option:selected").attr("data-codigo") 
                };
                
                waitingDialog({});

                jQuery.ajax({
                    type: "POST",
                    url: baseUrl + "AdministrarPalanca/UpdateOfertasHome",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(params),
                    async: true,
                    success: function (data) {
                        closeWaitingDialog();

                        if (data.success) {
                            HideDialog("DialogMantenimientoOfertasHome");
                            //_toastHelper.success("Solicitud realizada sin problemas.");
                            showDialogMensaje(data.message, '');
                            UpdateGrillaOfertas();
                        } else {
                            showDialogMensaje(data.message, '');
                            //_toastHelper.error("Error al procesar la Solicitud.");
                        }
                    },
                    error: function (data, error) {
                        closeWaitingDialog();
                        console.log(data);
                        _toastHelper.error("Error al procesar la Solicitud.");
                    }
                });

            },
            "Salir": function () {
                HideDialog("DialogMantenimientoOfertasHome");
            }
        }
    });
}


function UpdateGrillaPalanca() {
    $("#list").jqGrid("GridUnload");

    jQuery("#list").jqGrid({
        url: baseUrl + "AdministrarPalanca/ListPalanca",
        hidegrid: false,
        datatype: "json",
        mtype: "GET",
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ["ConfiguracionPaisID", "Orden", "Código", "Descripción", "Acción"],
        colModel: [
            {
                name: "ConfiguracionPaisID",
                index: "ConfiguracionPaisID",
                width: 20,
                editable: true,
                resizable: false,
                hidden: true
            },
            {
                name: "Orden",
                index: "Orden",
                width: 40,
                ConfiguracionPaisID: true,
                resizable: false,
                hidden: false,
                sortable: false
            },
            { name: "Codigo", index: "Codigo", width: 40, editable: true, hidden: false, sortable: false },
            { name: "Descripcion", index: "Descripcion", width: 280, editable: true, hidden: false, sortable: false },
            {
                name: "Activo",
                index: "Activo",
                width: 30,
                align: "center",
                editable: true,
                resizable: false,
                sortable: false,
                formatter: ShowActions
            }
        ],
        pager: false,
        loadtext: "Cargando datos...",
        recordtext: "{0} - {1} de {2} Registros",
        emptyrecords: "No hay resultados",
        rowNum: 100,
        scrollOffset: 0,
        sortname: "Orden",
        sortorder: "asc",
        height: "auto",
        width: 930,
        altRows: true,
        altclass: "jQGridAltRowClass",
        pgbuttons: false,
        viewrecords: false,
        pgtext: "",
        pginput: false
    });
    jQuery("#list").jqGrid("navGrid", "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
}

function UpdateGrillaOfertas() {
    // seccion ofertas home
    $("#listOfertas").jqGrid("GridUnload");

    jQuery("#listOfertas").jqGrid({
        url: baseUrl + "AdministrarPalanca/ListOfertasHome",
        hidegrid: false,
        datatype: "json",
        postData: ({
            campaniaID: $("#CampaniaBuscar").val()
        }),
        mtype: "GET",
        contentType: "application/json; charset=utf-8",
        multiselect: false,
        colNames: ["ConfiguracionOfertasHomeID", "Orden", "Campaña", "Palanca", "Título", "Acción"],
        colModel: [
            {
                name: "ConfiguracionOfertasHomeID",
                index: "ConfiguracionOfertasHomeID",
                width: 20,
                editable: true,
                resizable: false,
                hidden: true
            },
            { name: "DesktopOrden", index: "Orden", width: 20, editable: true, hidden: false, sortable: false },
            {
                name: "CampaniaID",
                index: "CampaniaID",
                width: 30,
                editable: true,
                resizable: false,
                hidden: false,
                sortable: false
            },
            { name: "ConfiguracionPaisID", index: "ConfiguracionPais", width: 80, editable: true, hidden: false, sortable: false },
            { name: "DesktopTitulo", index: "DesktopTitulo", width: 200, editable: true, hidden: false, sortable: false },
            {
                name: "Activo",
                index: "Activo",
                width: 30,
                align: "center",
                editable: true,
                resizable: false,
                sortable: false,
                formatter: ShowActionsOfertas
            }
        ],
        jsonReader:
        {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: true,
            cell: "cell",
            id: "id"
        },
        pager: jQuery("#pager"),
        loadtext: "Cargando datos...",
        recordtext: "{0} - {1} de {2} Registros",
        emptyrecords: "No hay resultados",
        rowNum: 10,
        scrollOffset: 0,
        rowList: [10, 20, 30, 40, 50],
        sortname: "DesktopOrden",
        sortorder: "asc",
        viewrecords: true,
        height: "auto",
        width: 930,
        pgtext: "Pág: {0} de {1}",
        altRows: true,
        altclass: "jQGridAltRowClass",
    });
    jQuery("#listOfertas").jqGrid("navGrid", "#pager", { edit: false, add: false, refresh: false, del: false, search: false });
}

function ShowActions(cellvalue, options, rowObject) {

    var des = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Editar('" + rowObject[0] + "',event);\" >" + "<img src='" + rutaImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
    if (rowObject[10] === "1") {
        des += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" + rowObject[0] + "',event);\" >" + "<img src='" + rutaImagenDelete + "' alt='Deshabilitar' title='Deshabilitar' border='0' /></a>";
    }
    return des;
}

function ShowActionsOfertas(cellvalue, options, rowObject) {

    var des = "&nbsp;<a href='javascript:;' onclick=\"return jQuery('#listOfertas').EditarOfertas('" + rowObject[0] + "');\" >" + "<img src='" + rutaImagenEdit + "' alt='Editar' title='Editar' border='0' /></a>";
    if (rowObject[10] === "1") {
        des += "&nbsp;&nbsp;<a href='javascript:;' onclick=\"return jQuery('#list').Eliminar('" + rowObject[0] + "');\" >" + "<img src='" + rutaImagenDelete + "' alt='Deshabilitar' title='Deshabilitar' border='0' /></a>";
    }
    return des;
}
function UploadFilePalanca(tag) {

    var tipoFile = ["jpg", "png", "jpeg"];
    var tipoFileTag = $("#nombre-" + tag).attr("data-tipofile");
    if (tipoFileTag === "imggif") {
        tipoFile.push("gif");
    }

    new qq.FileUploader({
        allowedExtensions: tipoFile,
        element: document.getElementById("img-" + tag),
        action: rutaFileUpload,
        onComplete: function (id, fileName, responseJSON) {
            if (checkTimeout(responseJSON)) {
                if (responseJSON.success) {
                    $("#nombre-" + tag).val(responseJSON.name);
                    $("#src-" + tag).attr("src", rutaTemporal + responseJSON.name);
                } else alert(responseJSON.message);
            }
            return false;
        },
        onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); },
        onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
        onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
    });
    if ($("#nombre-" + tag).val() !== "") {
        $("#src-" + tag).attr("src", urlS3 + $("#nombre-" + tag).val());
    }

    return false;
}

function UploadFilePalancaApp(tag) {
    var tipoFileTag = $("#nombre-" + tag).attr("imageextension");
    var tipoFile = tipoFileTag.split(",");

    var params = {};
    params["width"] = $("#nombre-" + tag).attr("imagewidth");
    params["height"] = $("#nombre-" + tag).attr("imageheight");
    params["messageSize"] = $("#nombre-" + tag).attr("messageSize");

    new qq.FileUploader({
        allowedExtensions: tipoFile,
        element: document.getElementById("img-" + tag),
        action: rutaFileUpload,
        params: params,
        messages: {
            typeError: $("#nombre-" + tag).attr("messageFormat")
        },
        onComplete: function (id, fileName, responseJSON) {
            closeWaitingDialog();
            if (checkTimeout(responseJSON)) {
                if (responseJSON.success) {
                    $("#nombre-" + tag).val(responseJSON.name);
                    $("#src-" + tag).attr("src", rutaTemporal + responseJSON.name);
                }
                else {
                    alert(responseJSON.message);
                }
            }
            return false;
        },
        onSubmit: function (id, fileName) { $(".qq-upload-list").remove(); waitingDialog({}); },
        onProgress: function (id, fileName, loaded, total) { $(".qq-upload-list").remove(); },
        onCancel: function (id, fileName) { $(".qq-upload-list").remove(); }
    });
    if ($("#nombre-" + tag).val() !== "") $("#src-" + tag).attr("src", urlS3 + $("#nombre-" + tag).val());

    return false;
}

function GetStringEstrategia(nameCheckBox) {
    var estrategias = "";
    $("input[name='" + nameCheckBox + "']:checked").each(function () {
        estrategias += $(this).attr("value");
        estrategias += ",";
    });
    return estrategias.slice(0, -1);
}