﻿var tagLbel = "Lbel";
var tagEsika = "Esika";
var tagCyzone = "Cyzone";
var tagTodo = "Todo";

var campSelect = "";
var campSelectI = 1;

var aCam = new Array();
var linkCat = new Object();
var descrCat = new Object();
var ordenCat = new Object();

var cantCat = 3;
var cantCam = 3;
var cont = 0;

var listaCorreo = new Array();
var nombreCat = new Object();

var campaniaEmail = "";

var rCampSelect = "";
var rCampSelectI = 1;
var cantCamRev = 3;
var aCamRev = new Array();

$(document).ready(function () {

        //configurarContenedorExpoOfertas();
    campSelect = getNumeroCampania(getCodigoCampaniaActual());
    $('#campaniaRevista').val(getCodigoCampaniaActual());
    $("#contentCatalogo #TextoCampania").text("CATÁLOGOS C-" + campSelect);
    aCam.push(getCodigoCampaniaAnterior());
    aCam.push(getCodigoCampaniaActual());
    aCam.push(getCodigoCampaniaSiguiente());

    nombreCat[tagLbel] = "L'Bel";
    nombreCat[tagEsika] = "Ésika";
    nombreCat[tagCyzone] = "Cyzone";

    linkCat[tagLbel] = "http://www.lbel.com";
    linkCat[tagEsika] = "http://www.esika.biz";
    linkCat[tagCyzone] = "http://www.cyzone.com";

    descrCat[tagLbel] = "";
    descrCat[tagEsika] = "";
    descrCat[tagCyzone] = "";

    ordenCat[0] = isEsika ? tagLbel : tagEsika;
    ordenCat[1] = isEsika ? tagEsika : tagLbel;
    ordenCat[2] = tagCyzone;
    ordenCat[3] = "";

    CargarCarruselCatalogo();
    ColumnasDeshabilitadasxPais();
    CargarTodosCorreo();

    $(".mostrar_todos").html($.trim($(".mostrar_todos").html()).replace("##", listaCorreo.length));

    $('#tagCorreo').tagsInput({
        'width': '100%',
        'height': '50px',
        minInputWidth: '100%',
        'defaultText': 'Separa los correos con &#59;',
        'delimiter': ';',
        'unique': true,
        'validate': /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i,
        classMain: 'tag-editor tag_fijo_scroll',
        autocomplete_url: '',
        'autocomplete': {
            'source': listaCorreo,
            'create': renderItemCliente,
            'appendTo': $("#tagParent")
        }
    });

    $(".mostrar_todos").on("click", function () {
        CargarTodosCorreo();
        $.each(listaCorreo, function (ind, item) {
            item.email = $.trim(item.email);
            if (item.email != "") {
                $("#tagCorreo").addTag(item.email, { unique: true, valuePk: item.email, obj: item });
            }
        });
    });

    $("#divCheckbox [data-cat] > div").on("click", function () {
        var obj = $(this).parents("[data-cat]");
        obj.find("[type='checkbox']").Checked();
    });

    $("#btnEnviarCorreo").on("click", function () { CatalogoEnviarEmail(); });

    // Eventos que se utilizan en vista responsive

    $('.tab__catalogos a').on('click', function (e) {
        e.preventDefault();
        $('.contenido__seccion__mi__revista').fadeOut(200);
        $('.contenido__seccion__catalogo').fadeIn(200);
        $('.indicador__catalogos__revistas').removeClass('indicador__catalogos__revistas--activo');
        $(this).next().addClass('indicador__catalogos__revistas--activo');
    });

    $('.tab__revistas a').on('click', function (e) {
        e.preventDefault();
        $('.contenido__seccion__catalogo').fadeOut(200);
        $('.contenido__seccion__mi__revista').fadeIn(200);
        $('.indicador__catalogos__revistas').removeClass('indicador__catalogos__revistas--activo');
        $(this).next().addClass('indicador__catalogos__revistas--activo');
    });

    $('.catalogos__por__campania__slider__control__izq img').on('click', function (e) {
        e.preventDefault();
        
        if ($('.catalogos__por__campania__slider__control__der img').is(':visible')) {
            $('.catalogos__campania--actual').fadeOut(100);
            $('.catalogos__campania--siguiente').fadeOut(100);
            $('.catalogos__campania--anterior').fadeIn(100);
            $('.catalogos__por__campania__slider__control__izq img').fadeOut(100);
        } else {
            $('.catalogos__campania--anterior').fadeOut(100);
            $('.catalogos__campania--siguiente').fadeOut(100);
            $('.catalogos__campania--actual').fadeIn(100);
            $('.catalogos__por__campania__slider__control__der img').fadeIn(100);
        }
    });

    $('.catalogos__por__campania__slider__control__der img').on('click', function (e) {
        e.preventDefault();
        if ($('.catalogos__por__campania__slider__control__izq img').is(':visible')) {
            $('.catalogos__campania--actual').fadeOut(100);
            $('.catalogos__campania--anterior').fadeOut(100);
            $('.catalogos__campania--siguiente').fadeIn(100);
            $('.catalogos__por__campania__slider__control__der img').fadeOut(100);
        } else {
            $('.catalogos__campania--anterior').fadeOut(100);
            $('.catalogos__campania--siguiente').fadeOut(100);
            $('.catalogos__campania--actual').fadeIn(100);
            $('.catalogos__por__campania__slider__control__izq img').fadeIn(100);
        }
    });

    if ($('.catalogos__campania--anterior').is(':visible')) {
        $('.catalogos__por__campania__slider__control__izq img').fadeOut(100);
    }

    if ($('.catalogos__campania--siguiente').is(':visible')) {
        $('.catalogos__por__campania__slider__control__der img').fadeOut(100);
    }

    $('.btn__compartir').on('click', function (e) {
        if (window.matchMedia('(max-width:991px)').matches) {
            $('.background__opciones__compartir__catalogos').fadeIn(100);
            $('.background__opciones__compartir__catalogos').css('display', 'flex');
            $(this).next().fadeIn(100);
            $(this).next().css('display', 'flex');
        } else {
            $(this).next().fadeIn(100);
            $(this).next().css('display', 'flex');
        }

    });

    $(document).on('click', 'body', ocultarTooltipCompartirCatalogo);

    // Fin - Eventos que se utilizan en vista responsive

});

function getCodigoCampaniaAnterior() {
    return $.trim($("#hdCampaniaAnterior").val()) || '';
}

function getCodigoCampaniaActual() {
    return $.trim($("#hdCampaniaActual").val()) || '';
}

function getCodigoCampaniaSiguiente() {
    return $.trim($("#hdCampaniaSiguiente").val()) || '';
}

function getNumeroCampania(codigoCampania) {
    codigoCampania = codigoCampania || '';
    return codigoCampania.substring(4, 6);
}

function getAnioCampania(codigoCampania) {
    codigoCampania = codigoCampania || '';
    return codigoCampania.substring(0, 4);
}

function InsertarLogCatalogoDynamo(opcionAccion, campaniaCatalogo, marca, cantidad) {
    InsertarLogDymnamo(
        'Catalogo-Compartir',
        opcionAccion,
        false,
        [
            { 'key': 'CampaniaCatalogo', 'value': campaniaCatalogo },
            { 'key': 'Marca', 'value': marca },
            { 'key': 'Cantidad', 'value': cantidad }
        ]
    );
}

function configurarContenedorExpoOfertas() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'Banner/ObtenerBannerPaginaPrincipal',
        data: '',
        dataType: 'Json',
        success: function (dataResult) {
            if (checkTimeout(dataResult)) {
                if (!dataResult.success) {
                    MonstrarExclamacion('Error al cargar la informacion de Expoferta.');
                    return;
                }

                var $arrayBanners = $.grep(dataResult.data, function (e) {
                    return e.GrupoBannerID == -5;
                });

                if ($arrayBanners.length === 0)
                    return;

                var urlExpoferta = '';
                $.each($arrayBanners, function (key, banner) {
                    if (banner.TituloComentario.toLowerCase() === "expoferta") {
                        urlExpoferta = banner.URL;
                    }
                });

                $("#catalogoExpoferta").css("cursor", "pointer");
                $('#contenedorExpofertaMCR').hide();

                if (urlExpoferta.length > 0) {
                    $('#contenedorExpofertaMCR').show();
                    $('#catalogoExpoferta').click(function () {
                        SetGoogleAnalytics('', 'Ver expoferta', 'Expoferta');
                        window.open(urlExpoferta, '_blank');
                    });
                }
            }
        }
    });
};

function CargarCarruselCatalogo() {
    waitingDialog();

    var htmlSection = "";
    var htmlCatalogo = "";
    var htmlCatalogoAppend = "";
    var totalItem = cantCat * cantCam;    

    var objCheckCata = $($("#divCheckbox > div")[0]).clone();
    $("#divCheckbox").html("");

    for (var i = 0; i < cantCam; i++) {

        var xhtmlSection = "#xhtmlSection";
        if (i == 1) xhtmlSection = "#xhtmlSectionActual";
        htmlSection = $(xhtmlSection).html();
        htmlSection = htmlSection.replace(/{sectionid}/g, 'idSection' + i);
        htmlSection = htmlSection.replace(/{divCatalogo}/g, 'divCatalogo' + i);

        $("#divSection").append(htmlSection);

        if (i == 0) document.querySelector("#idSection" + i).className += " catalogos__campania--anterior";
        else if (i == 1) {                        
            document.querySelector("#idSection" + i).className += " catalogos__campania--actual";            
            $("#idSection" + i).append($("#xHtmlItemCatalogoPasosActual").html());
        }
        else if (i == 2) document.querySelector("#idSection" + i).className += " catalogos__campania--siguiente";
    }


    for (var i = 0; i < cantCam; i++) {
        
        htmlCatalogo = "";
        htmlCatalogoAppend = "";
        var nro = "";
        var anio = "";
        var tipo = "";

        if (i < cantCat/3) {
            anio = getAnioCampania(getCodigoCampaniaAnterior());
            nro = getNumeroCampania(getCodigoCampaniaAnterior());
        }
        else if (i < (cantCat * 2)/3) {
            anio = getAnioCampania(getCodigoCampaniaActual());
            nro = getNumeroCampania(getCodigoCampaniaActual());
        }
        else if (i < (cantCat * 3)/3) {
            anio = getAnioCampania(getCodigoCampaniaSiguiente());
            nro = getNumeroCampania(getCodigoCampaniaSiguiente());
        }

        //var x = i - parseInt(i / cantCat) * (cantCat/3);
        //x = x < 0 ? 3 : x > 2 ? 3 : x;
        //tipo = ordenCat[x];
        if (nro == "" || anio == "") {
            continue;
        }

        //if (i < 3) {
        //    $(objCheckCata).attr("data-catalogo", tipo);
        //    $(objCheckCata).find(".check_label").html(nombreCat[tipo]);
        //    var objxx = $("<div></div>").append(objCheckCata);
        //    $("#divCheckbox").append(objxx.html());
        //}
         
        for (var j = 0; j < cantCat; j++) {

            var itemCatalogo = "#xHtmlItemCatalogo";
            if (i == 1) itemCatalogo = "#xHtmlItemCatalogoActual";

            var x = j - parseInt(j / cantCat) * (cantCat / 3);
            x = x < 0 ? 3 : x > 2 ? 3 : x;
            tipo = ordenCat[x];

            if (tipo == "") {
                continue;
            }

            if (i == 0 && j < 3) {
                $(objCheckCata).attr("data-cat", tipo);
                $(objCheckCata).find(".check_label").html(nombreCat[tipo]);
                var objxx = $("<div></div>").append(objCheckCata);
                $("#divCheckbox").append(objxx.html());
            }

            htmlCatalogo = $(itemCatalogo).html();
            htmlCatalogo = htmlCatalogo.replace(/{campania}/g, anio + nro);
            htmlCatalogo = htmlCatalogo.replace(/{tipoCatalogo}/g, tipo);
            htmlCatalogo = htmlCatalogo.replace(/{tipoCatalogoTodo}/g, tagTodo);
            htmlCatalogo = i == 1 ? htmlCatalogo : htmlCatalogo.replace(/{comp}/g, tipo);
            htmlCatalogo = i == 1 ? htmlCatalogo : htmlCatalogo.replace(/{descripcion}/g, descrCat[tipo]);
            htmlCatalogo = htmlCatalogo.replace(/{estado}/g, "0");
            htmlCatalogoAppend = htmlCatalogoAppend + htmlCatalogo;
        }
               
        $("#divCatalogo" + i).append(htmlCatalogoAppend);               
    }

    //$("#divCatalogo").append("<div class='clear'></div>");
    //$("#divCatalogo [data-cat='Cyzone'] > div").addClass("no_margin_right");

    for (var i = 0; i < cantCat; i++) {
        $("#divCatalogo" + i + " [data-cat='Lbel']").addClass(" catalogos__por__campania__item__imagen--lbel");
        $("#divCatalogo" + i + " [data-cat='Esika']").addClass(" catalogos__por__campania__item__imagen--esika");
        $("#divCatalogo" + i + " [data-cat='Cyzone']").addClass(" catalogos__por__campania__item__imagen--cyzone");       
    }
    
    closeWaitingDialog();
}

function FinRenderCatalogo() {
    waitingDialog();
    if (cont >= cantCam * cantCat) {
        campSelect = campSelect || getAnioCampania(getCodigoCampaniaActual());
        campSelectI = campSelectI || 1;
        $("#contentCatalogo #TextoCampania").text("CATÁLOGOS C-" + campSelect);
        for (var i = 0; i < cantCam; i++) {
            $("#divCatalogo" + i +" > div > div").show();
        }
        
        CatalogoMostrar(0);
        closeWaitingDialog();
    }
}

function ColumnasDeshabilitadasxPais(valor, accion, label) {
    waitingDialog();
    
    if (typeof (accion) !== 'undefined') {
        SetGoogleAnalytics("", accion, label);
    }
    var deferedCam = new Object();
    for (var i = 0; i < aCam.length; i++) {

        var camp = aCam[i];
        deferedCam[camp] = jQuery.Deferred();

        deferedCam[camp] = ObtenerEstadoCatalogo(camp, deferedCam[camp]);
        deferedCam[camp].done(meDone);
    }

    $.when(deferedCam[aCam[0]], deferedCam[aCam[1]], deferedCam[aCam[2]]).done(function () {
        FinRenderCatalogo();
    });
}
var meDone = function (data, camp) {

    if (data != null) GetCatalogosLinksByCampania(data, camp);
    else cont += cantCat;
}
function ObtenerEstadoCatalogo(campana, defered) {
    jQuery.ajax({
        type: "GET",
        url: urlDetalle,
        dataType: "json",
        data: { campania: campana },
        success: function (result) {
            if (checkTimeout(result)) {
                defered.resolve(result, campana);
            }
        },
        error: function (data, x, xh, xhr) {
            if (checkTimeout(data)) {
                defered.resolve(null, campana);
            }
        }
    });
    return defered.promise();
}

function GetCatalogosLinksByCampania(data, campania) {
    waitingDialog();
    $.ajaxSetup({ cache: false });
    
    var contDiv;
    for (var i = 0; i < aCam.length; i++) {
        if (campania == aCam[i]) {
            contDiv = i;
            break;
        }
    }

    var idCat = "#divCatalogo" + contDiv;

    for (var i = 0; i < cantCat; i++) {

        
        var tagCat = i == 0 && data.estadoLbel != 1 ? tagLbel
            : i == 1 && data.estadoCyzone != 1 ? tagCyzone
                : i == 2 && data.estadoEsika != 1 ? tagEsika
                    : "";

        if (tagCat == "") {
            cont++;
            continue;
        }

        var estado = i == 0 && data.estadoLbel != 1 ? "1"
            : i == 1 && data.estadoCyzone != 1 ? "1"
                : i == 2 && data.estadoEsika != 1 ? "1"
                    : "0";

        var elemItem = "[data-cam='" + campania + "'][data-cat='" + tagCat + "']";
        $(idCat).find(elemItem).find("[data-tipo='content']").hide();
        $(elemItem).attr("data-estado", estado);

        var codigoISSUU = '', urlCat;
        $.each(data.listCatalogo, function (key, catalogo) {
            if (catalogo.marcaCatalogo.toLowerCase() == tagCat.toLowerCase()) {
                codigoISSUU = catalogo.DocumentID;
                urlCat = catalogo.SkinURL;
            }
        });
        cont++;
        if (codigoISSUU == '') {
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", linkCat[tagCat]);
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("onclick", "SetGoogleAnalytics('','Ver catálogo','" + tagCat + "')");
            $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgNoDisponible);
        }
        else {
            var a = getAnioCampania(campania);
            var n = getNumeroCampania(campania);
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("onclick", "SetGoogleAnalytics('" + codigoISSUU + "','Ver catálogo','" + tagCat + "')");
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", urlCat);
            $(idCat).find(elemItem).find("#txtUrl" + tagCat).val(urlCat);
            $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);
        }
    }
    FinRenderCatalogo();
}

function ObtenerCodigoISSUU(catalogo, defered, elemItem, tagCat, campaniaX) {
    var codigoISSUU = "";
    var urlGetImg = urlBuscadorIssu + 'docname:' + catalogo + '&jsonCallback=?';
    jQuery.ajax({
        type: "GET",
        url: urlGetImg,
        dataType: "json",
        success: function (result) {
            if (checkTimeout(result)) {
                if (result.response.docs.length > 0) {
                    var doc = result.response.docs[result.response.docs.length - 1];
                    codigoISSUU = doc.documentId;
                }
                defered.resolve(codigoISSUU, elemItem, tagCat, campaniaX);
            }
        },
        error: function (data, x, xh, xhr) {
            if (checkTimeout(data)) {
                codigoISSUU = '';
                defered.resolve("", elemItem, tagCat, campaniaX);
            }
        }
    });
    return defered.promise();
}

function CatalogoMostrar(accion, btn) {

    campSelectI = accion == -1 ? campSelectI - 1 : accion == 1 ? campSelectI + 1 : campSelectI;
    campSelectI = campSelectI <= 0 ? 0 : campSelectI >= cantCam - 1 ? cantCam - 1 : campSelectI;

    var campS = aCam[campSelectI];
    campSelect = getNumeroCampania(campS);
    $("#contentCatalogo #TextoCampania").text("CATÁLOGOS C-" + campSelect);
    //$("#divCatalogo > div").hide();
    //$("#divCatalogo > div[data-cam='" + campS + "'][data-estado='1']").show();

    $("#contentCatalogo > span img").show();
    if (campSelectI == 0 || campSelectI == cantCam - 1) {
        if (btn != null) {
            $(btn).hide();
        }
    }

    //// Centrar segun cantidad de catalgos
    //var cata = $("#divCatalogo [data-cam='" + aCam[campSelectI] + "'][data-estado='1'] > div");
    //if (cata.length < 3) {
    //    var wUnit = 24.7;//%
    //    var wTotalRender = wUnit * cata.length;
    //    var wVacio = 100 - wTotalRender;
    //    var wVacioUnit = wVacio / cata.length;
    //    //cata.removeClass("no_margin_right");

    //    if (_Pagina == 1) {
    //        cata.css("margin-right", (wVacioUnit / 2) + "%");
    //        cata.css("margin-left", (wVacioUnit / 2) + "%");
    //    }
    //    else {
    //        cata.css("margin-right", "0%");
    //        cata.css("margin-left", "0%");
    //    }
    //}

    if (btn != null) {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Catálogos y revistas',
            'action': accion == -1 ? 'Ver anterior campaña' : 'Ver siguiente campaña',
            'label': 'Catálogos C-' + campSelect,
            'value': 0
        });
    }
}

function SetGoogleAnalytics(Imagen, Accion, Label) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Catálogos y revistas',
        'action': Accion,
        'label': Label,
        'value': 0
    });
}

function CargarTodosCorreo() {
    listaCorreo = listaCorreo || new Array();
    if (listaCorreo.length > 0) {
        return listaCorreo;
    }
    listaCorreo = new Array();
    jQuery.ajax({
        type: "GET",
        url: baseUrl + 'MisCatalogosRevistas/AutocompleteCorreo',
        dataType: "json",
        async: false,
        success: function (result) {
            if (checkTimeout(result)) {
                $.each(result, function (ind, correo) {
                    correo.label = $.trim(correo.nombre) + " " + $.trim(correo.email);
                    correo.value = $.trim(correo.email);
                    listaCorreo.push(correo);
                });
            }
        },
        error: function (data, x, xh, xhr) {
            if (checkTimeout(data)) {
                listaCorreo = new Array();
            }
        }
    });
}

function CatalogoEnviarEmail() {
    waitingDialog();

    $('#tagCorreo').addTag($('#tagCorreo_tag').val());

    var correoEnviar = $('#tagCorreo').exportTag() || new Array();
    if (correoEnviar.length <= 0) {
        MonstrarExclamacion("No se ha ingresado ningún correo electrónico.");
        closeWaitingDialog();
        return false;
    }
    var catalogoEnviar = $("#divCheckbox").find("[type='checkbox'][checked]") || new Array();
    if (catalogoEnviar.length <= 0) {
        MonstrarExclamacion("No se ha seleccionado ningún catálogo.");
        closeWaitingDialog();
        return false;
    }

    var _Flagchklbel = "0";
    var _Flagchkcyzone = "0";
    var _Flagchkesika = "0";


    var clientes = new Array();
    for (var i = 0; i < correoEnviar.length; i++) {
        var objCorreo = {
            "ClienteID": correoEnviar[i].obj.clienteID,
            "Nombre": correoEnviar[i].obj.nombre,
            "Email": correoEnviar[i].Name,
            LBel: "0",
            Esika: "0",
            Cyzone: "0",
            Finart: "0"
        }
        for (var c = 0; c < catalogoEnviar.length; c++) {
            var chk = catalogoEnviar[c];
            var checkCat = $(chk).parents("[data-cat]").attr("data-cat").toLowerCase();
            objCorreo.LBel = checkCat == "lbel" ? "1" : objCorreo.LBel;
            objCorreo.Esika = checkCat == "esika" ? "1" : objCorreo.Esika;
            objCorreo.Cyzone = checkCat == "cyzone" ? "1" : objCorreo.Cyzone;
            objCorreo.Finart = checkCat == "finart" ? "1" : objCorreo.Finart;

            _Flagchklbel = objCorreo.LBel;
            _Flagchkesika = objCorreo.Esika;
            _Flagchkcyzone = objCorreo.Cyzone;

        }
        clientes.push(objCorreo);
    }
    
    var mensaje = $("#comentarios").val();
    if (_Flagchklbel == "1") {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Catálogos y revistas',
            'action': 'Compartir email',
            'label': 'Lbel',
            'value': clientes.length
        });
        InsertarLogCatalogoDynamo('Email', campaniaEmail, 'Lbel', clientes.length);
    }
    if (_Flagchkesika == "1") {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Catálogos y revistas',
            'action': 'Compartir email',
            'label': 'Esika',
            'value': clientes.length
        });
        InsertarLogCatalogoDynamo('Email', campaniaEmail, 'Esika', clientes.length);
    }
    if (_Flagchkcyzone == "1") {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Catálogos y revistas',
            'action': 'Compartir email',
            'label': 'Cyzone',
            'value': clientes.length
        });
        InsertarLogCatalogoDynamo('Email', campaniaEmail, 'Cyzone', clientes.length);
    }

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisCatalogosRevistas/EnviarEmail',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ ListaCatalogosCliente: clientes, Mensaje: mensaje, Campania: campaniaEmail }),
        async: true,
        success: function (data) {
            closeWaitingDialog();
            $('#CompartirCorreo').hide();
            if (checkTimeout(data)) {
                if (data.success) {
                    MonstrarAlerta(data.message);
                    if (data.extra == "R") {
                        location.href = '/Bienvenida';
                    }
                }
                else {
                    MonstrarExclamacion(data.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            $('#CompartirCorreo').hide();
            if (checkTimeout(data)) {
                MonstrarExclamacion("ERROR");
            }
        }
    });

}
function CatalogoEnviarEmailPiloto() {
    waitingDialog();

    $('#tagCorreo').addTag($('#tagCorreo_tag').val());

    var correoEnviar = $('#tagCorreo').exportTag() || new Array();
    if (correoEnviar.length <= 0) {
        MonstrarExclamacion("No se ha ingresado ningún correo electrónico.");
        closeWaitingDialog();
        return false;
    }

    var clientes = new Array();
    for (var i = 0; i < correoEnviar.length; i++) {
        var objCorreo = {
            "ClienteID": correoEnviar[i].obj.clienteID,
            "Nombre": correoEnviar[i].obj.nombre,
            "Email": correoEnviar[i].Name
        }
        clientes.push(objCorreo);
    }

    var mensaje = $("#comentarios").val();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'MisCatalogosRevistas/EnviarEmailPiloto',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ ListaCatalogosCliente: clientes, Mensaje: mensaje, Campania: campaniaEmail }),
        async: true,
        success: function (data) {
            closeWaitingDialog();
            $('#CompartirCorreo').hide();
            if (checkTimeout(data)) {
                if (data.success) {
                    MonstrarAlerta(data.message);
                    if (data.extra == "R") {
                        location.href = '/Bienvenida';
                    }
                }
                else {
                    MonstrarExclamacion(data.message);
                }
            }
        },
        error: function (data, error) {
            closeWaitingDialog();
            $('#CompartirCorreo').hide();
            if (checkTimeout(data)) {
                MonstrarExclamacion("ERROR");
            }
        }
    });
}

function renderItemCliente(event, ui) {
    var htmlTag = ''
        + '<a>'
        + '<div class="content_datos_c">'
        + '<div class="nombre_compartir">{nombre}</div>'
        + '<div class="correo_compartir">{email}</div>'
        + '</div>'
        + '</a>';
    $(this).data('ui-autocomplete')._renderItem = function (ul, item) {
        var htmlTagAdd = htmlTag.replace('{nombre}', item.nombre);
        htmlTagAdd = htmlTagAdd.replace('{email}', item.email);
        return $('<li>')
            .append(htmlTagAdd)
            .appendTo(ul);
    };
}

// js-Revista

jQuery(document).ready(function () {
    aCamRev.push($("#hdrCampaniaAnterior").val());
    aCamRev.push($("#hdrCampaniaActual").val());
    aCamRev.push($("#hdrCampaniaSiguiente").val());

    waitingDialog({ title: "Cargando Imagen" });
    MostrarRevistaCorrecta($("#hdrCampaniaActual").val());
});

function RevistaMostrar(accion, btn) {
    rCampSelectI = accion == -1 ? rCampSelectI - 1 : accion == 1 ? rCampSelectI + 1 : rCampSelectI;
    rCampSelectI = rCampSelectI <= 0 ? 0 : rCampSelectI >= cantCamRev - 1 ? cantCamRev - 1 : rCampSelectI;

    rCampSelect = aCamRev[rCampSelectI] || "";

    $("#numero_campania").text(rCampSelect);
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Catálogos y revistas',
        'action': accion == -1 ? 'Ver anterior campaña' : 'Ver siguiente campaña',
        'label': 'Revista C-' + rCampSelect.substr(4),
        'value': 0
    });

    waitingDialog({ title: "Cargando Imagen" });
    MostrarRevistaCorrecta(rCampSelect);

    $("#contentRevista [data-accion] img").show();

    $("#contentRevista > span[data-accion] img").show();
    if (rCampSelectI == 0 || rCampSelectI == cantCamRev - 1) {
        $(btn).hide();
    }

    $('#campaniaRevista').val(rCampSelect);
}

function MostrarMiRevista() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Catálogos y revistas',
        'action': 'Ver revista',
        'label': 'Revista',
        'value': 0
    });

    var frmMiRevista = $('#frmMiRevista');
    frmMiRevista.submit();
}

function MostrarRevistaCorrecta(codigoCampania) {
    var promise = getUrlImagenPortadaRevistaPromise(codigoCampania);
    $.when(promise).done(function (promiseResult) {
        if (checkTimeout(promiseResult)) {
            var urlImagen = promiseResult || defaultImageRevista;
            $("#imgPortadaGana").attr("src", urlImagen);
            $("#contentRevista .titulo_central[data-titulo='revista']").text("REVISTA C-" + getNumeroCampania(codigoCampania));
            FinRenderCatalogo();
        }
    });
}

function getUrlImagenPortadaRevistaPromise(codigoCampania) {

    var defered = jQuery.Deferred();

    var data = JSON.stringify({
        codigoRevista: RevistaCodigoIssuu[codigoCampania]
    });
    jQuery.ajax({
        type: 'POST',
        url: urlObtenerPortadaRevista,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: data,
        success: function (response) {
            defered.resolve(response);
        },
        error: function () {
            defered.resolve(defaultImageRevista);
        }
    });

    return defered.promise();
}

function ocultarTooltipCompartirCatalogo(e) {

    var backgroundMobileCompartirCatalogo = $('.background__opciones__compartir__catalogos');
    var compartirCatalogoArea = $('.compartir__catalogo__area');
    var tooltipOpcionesCompartirCatalogoParteSuperior = $('#btnCompartir').next();
    var tooltipOpcionesCompartirCatalogoParteInferior = $('#btnCompartirActual').next();

    if (tooltipOpcionesCompartirCatalogoParteSuperior.css('display') == 'flex' || tooltipOpcionesCompartirCatalogoParteInferior.css('display') == 'flex') {
        if ((!compartirCatalogoArea.is(e.target) && compartirCatalogoArea.has(e.target).length === 0)) {
            if (tooltipOpcionesCompartirCatalogoParteSuperior.is(':visible')) {
                tooltipOpcionesCompartirCatalogoParteSuperior.fadeOut(100);
            } else {
                tooltipOpcionesCompartirCatalogoParteInferior.fadeOut(100);
            }
            if (window.matchMedia('(max-width:991px)').matches) {
                backgroundMobileCompartirCatalogo.fadeOut(100);
            }
        }
    }
}

// mensaje alerta

function MonstrarExclamacion(texto) {
    $("#mensaje_exclamacion #mensaje_exclamacion_texto").html(texto);
    $("#mensaje_exclamacion").show();
}

function MonstrarAlerta(texto) {
    $("#mensaje_alerta #mensaje_alerta_texto").html(texto);
    $("#mensaje_alerta").show();
}