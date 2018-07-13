﻿var RedesSociales = (function () {

    var _variables = {
        clickDataCompartir: "[data-compartir]"
    }
    
    var CompartirRedesSociales = function (e) {
        var obj = $(e.target);
        var tipoRedes = $.trim($(obj).parents("[data-compartir]").attr("data-compartir"));
        if (tipoRedes == "") tipoRedes = $.trim($(obj).attr("data-compartir"));
        if (tipoRedes == "") return false;

        var ruta = CompartirRedesSocialesUrl();
        if (ruta == "") return false;

        var padre = obj.parents("[data-item]");
        var article = $(padre).find("[data-compartir-campos]").eq(0);

        var label = $(article).find(".rs" + tipoRedes + "Mensaje").val();
        if (label != "") {
            dataLayer.push({
                'event': 'virtualEvent',
                'category': 'Ofertas Showroom',
                'action': 'Compartir ' + tipoRedes,
                'label': label,
                'value': 0
            });
        }

        CompartirRedesSocialesInsertar(article, tipoRedes);
    }

    var CompartirRedesSocialesUrl = function (id) {
        if (variablesPortal) {
            var urlPortal = $.trim(variablesPortal.UrlCompartir);
            if (urlPortal != "") {
                urlPortal = urlPortal.replace('[valor]', id);
            }
            return urlPortal;
        }
        return "";
    }

    var CompartirRedesSocialesInsertar = function (article, tipoRedes) {

        var _rutaImagen = $.trim($(article).find(".rs" + tipoRedes + "RutaImagen").val());
        var _mensaje = $.trim($(article).find(".rs" + tipoRedes + "Mensaje").val());
        var _nombre = $.trim($(article).find(".Nombre").val());
        var _marcaID = $.trim($(article).find(".MarcaID").val());
        var _marcaDesc = $.trim($(article).find(".MarcaNombre").val());
        var _descProd = $.trim($(article).find(".ProductoDescripcion").val());
        var _vol = $.trim($(article).find(".Volumen").val());
        var _palanca = $.trim($(article).find(".Palanca").val());

        var pcDetalle = _rutaImagen + "|" + _marcaID + "|" + _marcaDesc + "|" + _nombre;
        if (_palanca === "FAV") {
            pcDetalle += "|" + _vol + "|" + _descProd;
        }
        try {
        } catch (e) { console.log(e); }

        var Item = {
            mCUV: $(article).find(".CUV").val(),
            mPalanca: _palanca,
            mDetalle: pcDetalle,
            mApplicacion: tipoRedes
        };


        jQuery.ajax({
            type: 'POST',
            url: "/CatalogoPersonalizado/InsertarProductoCompartido",
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(Item),
            success: function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        CompartirRedesSocialesAbrirVentana(response.data.id, tipoRedes, _mensaje, _nombre);
                    } else {
                        AbrirMensaje(response.message);
                    }
                }
            },
            error: function (response, error) { }
        });
    }

    var CompartirRedesSocialesAbrirVentana = function (id, tipoRedes, texto, nombre) {

        id = $.trim(id);
        if (id == "0" || id == "")
            return false;

        var ruta = CompartirRedesSocialesUrl(id);
        if (ruta == "")
            return false;

        nombre = $.trim(nombre);

        CompartirRedesSocialesAnalytics(tipoRedes, ruta, nombre);

        if (tipoRedes == "FB") {
            var popWwidth = 570;
            var popHeight = 420;
            var left = (screen.width / 2) - (popWwidth / 2);
            var top = (screen.height / 2) - (popHeight / 2);
            var url = "http://www.facebook.com/sharer/sharer.php?u=" + ruta;
            window.open(url, 'Facebook', "width=" + popWwidth + ",height=" + popHeight + ",menubar=0,toolbar=0,directories=0,scrollbars=no,resizable=no,left=" + left + ",top=" + top + "");
        } else if (tipoRedes == "WA") {
            if (texto != "")
                texto = texto + " - ";
            $("#HiddenRedesSocialesWA").attr("href", 'javascript:window.location=RedesSociales.CompartirTexto("' + texto + ruta + '")');
            $("#HiddenRedesSocialesWA")[0].click();
        }
    }

    var CompartirRedesSocialesTexto = function (texto) {
        texto = texto.ReplaceAll("/", '%2F');
        texto = texto.ReplaceAll(":", "%3A");
        texto = texto.ReplaceAll("?", "%3F");
        texto = texto.ReplaceAll("=", "%3D");
        texto = texto.ReplaceAll(" ", "%32");
        texto = texto.ReplaceAll("+", "%43");

        texto = texto.ReplaceAll("&", "y");

        return "whatsapp://send?text=" + texto;
    }

    var CompartirRedesSocialesAnalytics = function (tipoRedes, ruta, nombre) {

        try {
            if (origenPedidoWebEstrategia !== undefined && origenPedidoWebEstrategia.indexOf("7") !== -1) {
                rdAnalyticsModule.CompartirProducto(tipoRedes, ruta, nombre);
            } else {

                if (tipoRedes === "FB") {
                    dataLayer.push({
                        'event': 'socialEvent',
                        'network': 'Facebook',
                        'action': 'Share',
                        'target': ruta
                    });
                } else if (tipoRedes == "WA") {
                    dataLayer.push({
                        'event': 'socialEvent',
                        'network': 'Whatsapp',
                        'action': 'Compartir',
                        'target': ruta
                    });
                }
            }
        } catch (e) { console.log(e) }


    }

    var _bindingEvents = function () {
        $("body").on("click", "[data-compartir]", function (e) {
            e.preventDefault();
            CompartirRedesSociales(e);
        });
    }

    function Inicializar() {
        _bindingEvents();
    }

    return {
        init: Inicializar,
        CompartirTexto: CompartirRedesSocialesTexto
    }
})();

$(document).ready(function () {
    RedesSociales.init();
});