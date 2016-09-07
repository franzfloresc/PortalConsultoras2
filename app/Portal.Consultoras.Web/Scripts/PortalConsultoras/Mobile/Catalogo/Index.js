﻿//CATALOGO

$(document).ready(function () {
    aCam.push($("#hdCampaniaAnterior").val());
    aCam.push($("#hdCampaniaActual").val());
    aCam.push($("#hdCampaniaSiguiente").val());

    //Revista
    aCamRev.push($("#hdrCampaniaAnterior").val());
    aCamRev.push($("#hdrCampaniaActual").val());
    aCamRev.push($("#hdrCampaniaSiguiente").val());
    rCampSelect = $("#hdrCampaniaActual").val();
    $("#contentRevista .titulo_central[data-titulo='revista']").text("REVISTA C-" + rCampSelect.substring(4, 6));
    MostrarRevistaCorrecta(rCampSelect);
    //Revista Fín

    $('ul[data-tab="tab"] li a[data-tag]').click(function (e) {
        // mostrar el tab correcto
        $("[data-tag-html]").hide();
        var tag = $(this).attr("data-tag") || "";
        var obj = $("[data-tag-html='" + tag + "']");
        $.each(obj, function (ind, objTag) {
            $(objTag).fadeIn(300).show();
        });

        //mantener seleccionado
        $('ul[data-tab="tab"] li a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    });

    $('ul[data-tab="tab"]').mouseover(function () {
        $("#barCursor").css("opacity", "1");
    }).mouseout(function () {
        $("#barCursor").css("opacity", "0");
    });

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
        'defaultText': 'Ingresar correo...',
        'delimiter': ',',
        'unique': true,
        'validate': /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i,
        classMain: 'tag-editor tag_fijo_scroll',
        autocomplete_url: '', //baseUrl + 'MisCatalogosRevistas/AutocompleteCorreo'
        'autocomplete': {
            'source': listaCorreo,
            'create': renderItemCliente,
            'appendTo': $("#tagParent")
        }
    });


    $("#tagParent #tagCorreo_tag").on("keypress", function (e) {
        if (e.keyCode == 13) {
            $("#tagParent > ul").hide();
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
        var tipo = obj.attr("data-cat");
        if (obj.find("[type='checkbox']").is(":checked")) {
            obj.find("[type='checkbox']").prop("checked", false);
        } else {
            obj.find("[type='checkbox']").prop("checked", true);
        }
    });

    $("#btnEnviarCorreo").on("click", function () {
        CatalogoEnviarEmail();
    });

});

//Variables
var tagLbel = "Lbel";
var tagEsika = "Esika";
var tagCyzone = "Cyzone";

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
var valContenidoCorreoDefecto = "Hola,\nRevisa los catálogos de esta campaña y comunícate conmigo si estás interesada en algunos de los productos.";

var urlISSUU = "http://issuu.com/somosbelcorp/docs/";
imgIssuu = imgIssuu.startsWith("https") ? imgIssuu.replace("https://", "http://") : imgIssuu;

function CargarCarruselCatalogo() {
    ShowLoading();

    var htmlBase = "";
    var totalItem = cantCat * cantCam;

    $("#divCatalogo").children()
                     .not('.previous_carrusel_catalogo, .next_carrusel_catalogo, .previous_carrusel_catalogo *, .next_carrusel_catalogo *')
                     .remove();

    for (var i = 0; i < totalItem; i++) {
        var nro = "";
        var anio = "";
        var tipo = "";

        if (i < cantCat) {
            anio = $("#hdCampaniaAnterior").val().substring(0, 4);
            nro = $("#hdCampaniaAnterior").val().substring(4, 6);
        }
        else if (i < cantCat * 2) {
            anio = $("#hdCampaniaActual").val().substring(0, 4);
            nro = $("#hdCampaniaActual").val().substring(4, 6);
        }
        else if (i < cantCat * 3) {
            anio = $("#hdCampaniaSiguiente").val().substring(0, 4);
            nro = $("#hdCampaniaSiguiente").val().substring(4, 6);
        }

        var x = i - parseInt(i / cantCat) * cantCat;
        x = x < 0 ? 3 : x > 2 ? 3 : x;
        //tipo = x == 0 ? tagLbel : x == 1 ? tagEsika : x == 2 ? tagCyzone : "";
        tipo = ordenCat[x];
        if (nro == "" || anio == "" || tipo == "") {
            continue;
        }

        var data = {
            campania: anio + nro,
            tipoCatalogo: tipo,
            comp: tipo,
            descripcion: descrCat[tipo],
            estado: "0"
        };
        var source = $("#catalogo-template").html();
        var template = Handlebars.compile(source);
        var context = data;
        var html = template(context);

        $("#divCatalogo").append(html);
    }

    //$("#divCatalogo").append("<div class='clear'></div>");
    //$("#divCatalogo [data-cat='Cyzone'] > div").addClass("no_margin_right");

    CloseLoading();
}
function ColumnasDeshabilitadasxPais(valor, accion, label) {
    ShowLoading();

    //if (!(typeof (accion) === 'undefined')) {
    //    SetGoogleAnalytics("", accion, label);
    //}

    var deferedCam = new Object();
    for (var i = 0; i < aCam.length; i++) {
        var camp = aCam[i];
        deferedCam[camp] = jQuery.Deferred();

        deferedCam[camp] = ObtenerEstadoCatalogo(camp, deferedCam[camp]);
        deferedCam[camp].done(function (data, camp) {
            if (data != null) {
                GetCatalogosLinksByCampania(data, camp);
            }
            else {
                cont += cantCat;
            }
        });
    }

    $.when(deferedCam[aCam[0]], deferedCam[aCam[1]], deferedCam[aCam[2]]).done(function () {
        FinRenderCatalogo();
    });
}
function ObtenerEstadoCatalogo(campana, defered) {
    jQuery.ajax({
        type: "GET",
        url: baseUrl + 'MisCatalogosRevistas/Detalle',
        dataType: "json",
        data: { campania: campana },
        success: function (result) {
            defered.resolve(result, campana);
        },
        error: function (x, xh, xhr) {
            defered.resolve(null, campana);
        }
    });
    return defered.promise();

}
function GetCatalogosLinksByCampania(data, campania) {
    ShowLoading();

    $.ajaxSetup({ cache: false });

    var idPais = $("#hdPaisId").val();

    var defered = new Object();

    var anio = campania.substring(0, 4);
    var nro = campania.substring(4, 6);
    var idCat = "#divCatalogo";

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

        defered[tagCat] = jQuery.Deferred();

        var elemItem = "[data-cam='" + campania + "'][data-cat='" + tagCat + "']";
        $(idCat).find(elemItem).find("[data-tipo='content']").hide();
        $(elemItem).attr("data-estado", estado || "0")

        var catalogo = tagCat.toLowerCase() + "." + ObtenerNombrePais(idPais) + ".c" + nro + "." + anio;

        //defered[tagCat] = ObtenerCodigoISSUU(catalogo, defered[tagCat], elemItem, tagCat, campania);
        //defered[tagCat].done(function (codigoISSUU, elem, tag, camp) {
        var codigoISSUU = '';
        $.each(data.listCatalogo, function (key, catalogo) {
            if (catalogo.marcaCatalogo.toLowerCase() == tagCat.toLowerCase()) {
                codigoISSUU = catalogo.DocumentID;
            }
        });
        cont++;
        if (codigoISSUU == '') {
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", linkCat[tagCat]);
            $(idCat).find(elemItem).find("[data-tipo='img']").attr("onclick", "SetGoogleAnalytics('','Ver','" + tagCat + "')");
            $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgNoDisponible);
        }
        else {

            //var n = campania.substring(4, 6);
            //var a = campania.substring(0, 4);
            //$(idCat).find(elemItem).find("[data-tipo='img']").attr("onclick", "SetGoogleAnalytics('" + codigoISSUU + "','Ver','" + tagCat + "')");
            //var urlCat = urlISSUU + tagCat.toLowerCase() + "." + ObtenerNombrePais(idPais) + ".c" + n + "." + a + "?e=1/2";
            
            //var codigozona = $('#divCatalogo')[0].dataset.codigozona;
            //var arrC201614 = new Array("1072", "1075", "3035", "3036", "5035", "5044");
            //var arrC201615 = new Array("1081", "3033", "3035", "3036", "5035", "5044");

            //if (idPais == 11 && campania == "201614")
            //{
            //    if (tagCat == "Lbel" && (arrC201614.indexOf(codigozona) > -1)) {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/");
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val("http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/");

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + "http://issuu.com/somosbelcorp/docs/piloto_lb1614pe_1/");
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");
            //    }
            //    else if (tagCat == "Esika" && (arrC201614.indexOf(codigozona) > -1)) {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/");
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val("http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/");

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + "http://issuu.com/somosbelcorp/docs/piloto_ek1614pe/");
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");
            //    }
            //    else if (tagCat == "Cyzone" && (arrC201614.indexOf(codigozona) > -1)) {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/");
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val("http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/");

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + "http://issuu.com/somosbelcorp/docs/piloto_cy1614pe/");
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");


            //    }
            //    else {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", urlCat);
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val(urlCat);

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + urlCat);
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");
            //    }
            //}
            //else if (idPais == 11 && campania == "201615") {

            //    if (tagCat == "Lbel" && (arrC201615.indexOf(codigozona) > -1)) {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/");
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val("https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/");

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + "https://issuu.com/somosbelcorp/docs/piloto_lb1615pe/");
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");
            //    }
            //    else if (tagCat == "Esika" && (arrC201615.indexOf(codigozona) > -1)) {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/");
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val("http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/");

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + "http://issuu.com/somosbelcorp/docs/piloto_ek1615pe/");
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");
            //    }
            //    else if (tagCat == "Cyzone" && (arrC201615.indexOf(codigozona) > -1)) {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/");
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val("http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/");

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + "http://issuu.com/somosbelcorp/docs/piloto_cy1615pe/");
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");


            //    }
            //    else {
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", urlCat);
            //        $(idCat).find(elemItem).find("#txtUrl" + tagCat).val(urlCat);

            //        $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

            //        $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
            //        $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

            //        //Whatsapp
            //        $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + urlCat);
            //        $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");
            //    }
            //}
            //else {

                var n = campania.substring(4, 6);
                var a = campania.substring(0, 4);
                $(idCat).find(elemItem).find("[data-tipo='img']").attr("onclick", "SetGoogleAnalytics('" + codigoISSUU + "','Ver','" + tagCat + "')");
                var urlCat = urlISSUU + tagCat.toLowerCase() + "." + ObtenerNombrePais(idPais) + ".c" + n + "." + a + "?e=1/2";

                urlCat = urlCat.ReplaceAll("/", "%2F");
                urlCat = urlCat.ReplaceAll(":", "%3A");
                urlCat = urlCat.ReplaceAll("?", "%3F");
                urlCat = urlCat.ReplaceAll("=", "%3D");

                $(idCat).find(elemItem).find("[data-tipo='img']").attr("href", urlCat);
                $(idCat).find(elemItem).find("#txtUrl" + tagCat).val(urlCat);

                $(idCat).find(elemItem).find("[data-tipo='img'] img").attr("src", imgIssuu.replace("{img}", codigoISSUU));

                $(idCat).find(elemItem).find("[data-accion='face']").attr("title", 'FB-' + tagCat + ' C' + n + a);
                $(idCat).find(elemItem).find("[data-tipo='img']").attr("title", 'Ver-' + tagCat + ' C' + n + a);

                //Whatsapp
                $(idCat).find(elemItem).find(".btn_ws").attr("href", "whatsapp://send?text=" + urlCat);
                $(idCat).find(elemItem).find(".btn_ws").attr("data-action", "share/whatsapp/share");

            //}
        }
    }

    //$.when(defered[tagLbel], defered[tagEsika], defered[tagCyzone]).done(function () {
    FinRenderCatalogo();
    //});
}
function ObtenerNombrePais(idPais) {
    var resultado = "";
    var pais = parseInt(idPais);

    switch (pais) {
        case 1:
            resultado = "argentina";
            break;
        case 2:
            resultado = "bolivia";
            break;
        case 3:
            resultado = "chile";
            break;
        case 4:
            resultado = "colombia";
            break;
        case 5:
            resultado = "costarica";
            break;
        case 6:
            resultado = "ecuador";
            break;
        case 7:
            resultado = "elsalvador";
            break;
        case 8:
            resultado = "guatemala";
            break;
        case 9:
            resultado = "mexico";
            break;
        case 10:
            resultado = "panama";
            break;
        case 11:
            resultado = "peru";
            break;
        case 12:
            resultado = "puertorico";
            break;
        case 13:
            resultado = "republicadominicana";
            break;
        case 14:
            resultado = "venezuela";
            break;
        default:
            resultado = "sinpais";
            break;
    }

    return resultado;
}
function SetGoogleAnalytics(Imagen, Accion, Label) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Catalogo',
        'action': Accion,
        'label': Label
    });
}
function FinRenderCatalogo() {
    ShowLoading();
    if (cont >= cantCam * cantCat) {
        campSelect = campSelect || $("#hdCampaniaActual").val().substring(4, 6);
        campSelectI = campSelectI || 1;
        $('[data-tag-html="Catalogos"] .titulo_catalogo').text("CATÁLOGOS C-" + campSelect);
        $("#divCatalogo > div > div").show();
        CatalogoMostrar(0);
        CloseLoading();
    }
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
            $.each(result, function (ind, correo) {
                correo.label = $.trim(correo.nombre) + " " + $.trim(correo.email);
                correo.value = $.trim(correo.email);
                listaCorreo.push(correo);
            });
        },
        error: function (x, xh, xhr) {
            listaCorreo = new Array();
        }
    });
}
function CatalogoMostrar(accion, btn) {
    campSelectI = accion == -1 ? campSelectI - 1 : accion == 1 ? campSelectI + 1 : campSelectI;
    campSelectI = campSelectI <= 0 ? 0 : campSelectI >= cantCam - 1 ? cantCam - 1 : campSelectI;

    var campS = aCam[campSelectI];
    campSelect = campS.substring(4, 6);
    $('[data-tag-html="Catalogos"] .titulo_catalogo').text("CATÁLOGOS C-" + campSelect);
    $("#divCatalogo > div").hide();
    $("#divCatalogo > div[data-cam='" + campS + "'][data-estado='1']").show();

   $("#divCatalogo > a img").show();
    if (campSelectI == 0 || campSelectI == cantCam - 1) {
        if (btn != null) {
            $(btn).hide();
        }
    }
}
function CompartirFacebook(Catalogo, btn) {

    var u = $(btn).parents("[data-cat='" + Catalogo + "']").find("#txtUrl" + Catalogo).val();

    var popWwidth = 570;
    var popHeight = 420;
    var left = (screen.width / 2) - (popWwidth / 2);
    var top = (screen.height / 2) - (popHeight / 2);
    var url = "http://www.facebook.com/sharer/sharer.php?u=" + u;
    window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
}
function renderItemCliente(event, ui) {
    var htmlTag = '' //'<div class="foto_usuario_compartir"><img src="' + urlIconoClienteAutoCompletar + '" alt="" /></div>'
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
function CatalogoEnviarEmail() {
    ShowLoading();

    var correoEnviar = $('#tagCorreo').exportTag() || new Array();
    if (correoEnviar.length <= 0) {
        $('#MensajeAlertaMobile2 .mensaje_alerta').html('No se ha ingresado ningun correo electrónico');
        $('#MensajeAlertaMobile2').show();
        CloseLoading();
        return false;
    }
    var catalogoEnviar = $('#divCheckbox input:checked') || new Array();
    if (catalogoEnviar.length <= 0) {
        $('#MensajeAlertaMobile2 .mensaje_alerta').html('No se ha seleccionado ningún catálogo');
        $('#MensajeAlertaMobile2').show();
        CloseLoading();
        return false;
    }

    var _Flagchklbel = "0";
    var _Flagchkcyzone = "0";
    var _Flagchkesika = "0";
    var _Flagchkfinart = "0";

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
            _Flagchkfinart = objCorreo.Finart;
        }
        clientes.push(objCorreo);
    }

    // Flags => Considerar a todos los clientes
    var FlagMarcas = _Flagchklbel + "|" + _Flagchkcyzone + "|" + _Flagchkesika + "|" + _Flagchkfinart;

    var campActual = $("#hdCampaniaActual").val();
    var campComparte = campaniaEmail; //$("#hdCampaniaComparte").val();
    var Tipo = campActual == campComparte ? "1" : "2";

    var mensaje = $("#comentarios").val();

    jQuery.ajax({
        type: 'POST',
        url: urlEnviarMail,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        //data: JSON.stringify({ CatalogoClienteModel: EmailsLbel, EmailsCyzone: EmailsCyzone, EmailsEsika: EmailsEsika, EmailsFinart: EmailsFinart, Mensaje: mensaje }),
        data: JSON.stringify({ ListaCatalogosCliente: clientes, Mensaje: mensaje, Campania: campaniaEmail }),
        async: true,
        success: function (data) {
            CloseLoading();
            $('#CompartirCorreoMobile').hide();
            if (checkTimeout(data)) {
                $('#MensajeAlertaMobile .mensaje_alerta').html(data.message);
                $('#MensajeAlertaMobile').show();
                if (!data.success) {
                    if (data.extra == "R") {
                        location.href = urlBienvenidaMobile;
                    }
                }
            }
        },
        error: function (data, error) {
            CloseLoading();
            $('#CompartirCorreoMobile').hide();
            if (checkTimeout(data)) {
                console.log('ERROR');
            }
        }
    });

}

// catalogo email
var campaniaEmail = "";
function AbrirCompartirCorreo(tipoCatalogo, campania) {
    $("#comentarios").val(valContenidoCorreoDefecto);
    // remover todos los tag
    $('#tagCorreo').removeTagAll();
    // asignar el check al catalogo correspondiente mediante tipoCatalogo
    campaniaEmail = campania;
    $("#divCheckbox").find("[type='checkbox']").removeAttr('checked');
    $("#divCheckbox").find("[data-cat='" + tipoCatalogo + "']").find("[type='checkbox']").prop("checked", true);    
    $('#CompartirCorreoMobile').show();
}


var rCampSelect = "";
var rCampSelectI = 1;
var cantCamRev = 3;
var aCamRev = new Array();

//REVISTA

//jQuery(document).ready(function () {

//    aCamRev.push($("#hdrCampaniaAnterior").val());
//    aCamRev.push($("#hdrCampaniaActual").val());
//    aCamRev.push($("#hdrCampaniaSiguiente").val());

//    rCampSelect = $("#hdrCampaniaActual").val();
//    $("#contentRevista .titulo_central[data-titulo='revista']").text("REVISTA C-" + rCampSelect.substring(4, 6));

//    MostrarRevistaCorrecta(rCampSelect);

//});

function MostrarRevistaCorrecta(campania) {
    
    var urlImagen = "";
    var defered = jQuery.Deferred();
    defered = ObtenerImagenRevista(campania, defered);
    defered.done(function (urlRevista) {
        urlImagen = urlRevista;
    });

    $.when(defered).done(function () {
        $("#imgPortadaGana").attr("src", !urlImagen || urlImagen == "" ? defaultImageRevista : urlImagen);

        var urlExterno = ObtenerUrlRevista(rCampSelect);
        $('[data-tag-html="Revistas"] .titulo_catalogo').text("REVISTA C-" + rCampSelect.substring(4, 6));
        $("#lbPortadaGana").attr("href", urlExterno);

        FinRenderCatalogo();
    });
}
function ObtenerImagenRevista(campania, defered) {
    
    var src = "";
    var anio = campania.substring(0, 4);
    var numero = campania.substring(4, 6);
    var prefijoPais = codigoIso.toLowerCase();

    var codigoRevista = 'revista.' + prefijoPais + '.c' + numero + '.' + anio;

    jQuery.ajax({
        type: 'POST',
        url: urlObtenerPortadaRevista,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ codigoRevista: codigoRevista }),
        success: function (response) {
            if (checkTimeout(response)) {
                if (response) {
                    response = response.startsWith("https") ? response.replace("https://", "http://") : response;
                    src = response;
                } else {
                    src = defaultImageRevista;
                }

                defered.resolve(src);
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                src = defaultImageRevista;
                defered.resolve(src);
            }
        }
    });

    return defered.promise();
}
function ObtenerUrlRevista(campania) {
    
    var prefijoPais = codigoIso.toLowerCase();
    var numeroCampania = campania.substring(4, 6);;
    var anioCampania = campania.substring(0, 4);;

    //EPD
    var paisid = $('#divCatalogo')[0].dataset.paisid;
    var codigozona = $('#divCatalogo')[0].dataset.codigozona;
    var arrC201614 = new Array("1072", "1075", "3035", "3036", "5035", "5044");
    var arrC201615 = new Array("1081", "3033", "3035", "3036", "5035", "5044");
    
    if(paisid == 11 && campania == "201614" && (arrC201614.indexOf(codigozona) > -1))
    {
        return "http://issuu.com/somosbelcorp/docs/piloto_rev1614pe_1/";
    }
    else if (paisid == 11 && campania == "201615" && (arrC201615.indexOf(codigozona) > -1)) {
        return "http://issuu.com/somosbelcorp/docs/piloto_rev1615pe/";
    }
    //EPD
    else {
        return 'http://issuu.com/somosbelcorp/docs/revista.' + prefijoPais + '.c' + numeroCampania + '.' + anioCampania + "?e=11111/22222";
    }
    
}
function SetGoogleAnalytics() {
    campania = $("#spNroCampania").text();
    if (campania == $("#hdrCampaniaActual").val().substr(4)) {
        //_gaq.push(['_trackEvent', 'Revista', 'Actual-C' + $("#hdrCampaniaActual").val(), 'Vista']);

        /*RQ 2505*/
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Revista',
            'action': 'Ver',
            'label': 'SomosBelcorp'
        });

    }
    if (campania == $("#hdrCampaniaAnterior").val().substr(4)) {
        //_gaq.push(['_trackEvent', 'Revista', 'Anterior-C' + $("#hdrCampaniaAnterior").val(), 'Vista']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Revista/Anterior-C' + $("#hdrCampaniaActual").val() + '/Vista'
        });
    }
    if (campania == $("#hdrCampaniaSiguiente").val().substr(4)) {
        //_gaq.push(['_trackEvent', 'Revista', 'Proxima-C' + $("#hdrCampaniaSiguiente").val(), 'Vista']);
        dataLayer.push({
            'event': 'pageview',
            'virtualUrl': '/Revista/Proxima-C' + $("#hdrCampaniaActual").val() + '/Vista'
        });
    }
}
function RevistaMostrar(accion, btn) {
    
    rCampSelectI = accion == -1 ? rCampSelectI - 1 : accion == 1 ? rCampSelectI + 1 : rCampSelectI;
    rCampSelectI = rCampSelectI <= 0 ? 0 : rCampSelectI >= cantCamRev - 1 ? cantCamRev - 1 : rCampSelectI;

    rCampSelect = aCamRev[rCampSelectI] || "";

    var campania = rCampSelect || "";

    if (campania && campania.length > 4) {
        $("#spNroCampania").text(campania.substr(4));
        if (rCampSelect == $("#hdrCampaniaActual").val()) {
            //_gaq.push(['_trackEvent', 'Revista', 'Actual-C' + campania, 'Seleccionada']);
            /*RQ 2505*/
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Revista',
                'action': 'Click',
                'label': 'Revista Campaña ' + campania.substring(4, 6)
            });

        }
        if (campania == $("#hdrCampaniaAnterior").val()) {
            //_gaq.push(['_trackEvent', 'Revista', 'Anterior-C' + campania, 'Seleccionada']);
            /*RQ 2505*/
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Revista',
                'action': 'Click',
                'label': 'Revista Anterior'
            });
        }
        if (campania == $("#hdrCampaniaSiguiente").val()) {
            //_gaq.push(['_trackEvent', 'Revista', 'Proxima-C' + campania, 'Seleccionada']);
            /*RQ 2505*/
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Revista',
                'action': 'Click',
                'label': 'Próxima Revista'
            });
        }
    }

    ShowLoading();

    MostrarRevistaCorrecta(rCampSelect);

    $(".content_revistas_mobile > a img").show();
    if (rCampSelectI == 0 || rCampSelectI == cantCamRev - 1) {
        $(btn).hide();
    }
}

function TagManagerPaginasVirtuales() {
    dataLayer.push({
        'event': 'virtualPage',
        'pageUrl': '/Mobile/catalogo/revistas/',
        'pageName': 'Catálogo – Revistas | Somos Belcorp'
    });
}