﻿var listaEscalaDescuento = listaEscalaDescuento || new Array();
var listaMensajeMeta = listaMensajeMeta || new Array();
var dataBarra = dataBarra || new Object();
var belcorp = belcorp || {};
var mtoLogroBarra = 0;
var ConfiguradoRegalo = false;
var avance = 0;
var EstadoPedido = EstadoPedido || 0;
var esPedidoReservado = (EstadoPedido === 1);
var montoIncentivo = montoIncentivo || 0;
var caminoBrillante = caminoBrillante || "False";

var tieneIncentivo = montoIncentivo >= 1 ? true : false;

var tpElectivos = {
    premioSelected: null,
    premios: [],
    loadPremios: false,
    loadedPremios: false,
    hasPremios: false,
    tempPrevLogro: -1,
    pedidoDetails: [],
    messages: {}
};


belcorp.barra = belcorp.barra || {};
belcorp.barra.settings = belcorp.barra.settings || {};
belcorp.barra.settings = {
    isMobile: isMobile()
}



function GetWidthTotalBase() {
    return $("[data-barra-width]").outerWidth();
}

function MostrarBarra(datax, destino) {
    $("#divBarra").hide();
    destino = destino || "2"; // 1: bienvenido  2: pedido
    $("#divBarra #divLimite").html("");
    datax = datax || new Object();
    var data = datax.dataBarra || datax.DataBarra || dataBarra || new Object();
    dataBarra = data;
    if (typeof (dataBarra.TippingPointBarra) !== "undefined")
        ConfiguradoRegalo = dataBarra.TippingPointBarra.InMinimo;

    ActualizarGanancia(dataBarra);
    if (destino == '2') {
        initCarruselPremios(dataBarra);
        if (datax.data && datax.data.CUV) {
            trySetPremioElectivo(datax.data.CUV);
        } else {
            savePedidoDetails(datax);
            checkPremioSelected();
        }
    }

    dataBarra.ListaEscalaDescuento = dataBarra.ListaEscalaDescuento || new Array();
    if (dataBarra.ListaEscalaDescuento.length > 0) {
        listaEscalaDescuento = dataBarra.ListaEscalaDescuento;
        if (dataBarra.redondeo == undefined) {
            $.each(listaEscalaDescuento, function (i, item) {
                if (IsDecimalExist(item.MontoHasta)) {
                    listaEscalaDescuento[i].MontoHasta = Math.ceil(item.MontoHasta);
                } else {
                    listaEscalaDescuento[i].MontoHasta = Math.ceil(item.MontoHasta) + 1;
                }
                listaEscalaDescuento[i].MontoHastaStr = DecimalToStringFormat(listaEscalaDescuento[i].MontoHasta, true);
            });
            dataBarra.redondeo = true;
        }
    }

    dataBarra.ListaMensajeMeta = dataBarra.ListaMensajeMeta || new Array();
    if (dataBarra.ListaMensajeMeta.length > 0) {
        listaMensajeMeta = dataBarra.ListaMensajeMeta;
    }

    dataBarra.MontoMinimo = Math.ceil(dataBarra.MontoMinimo);
    dataBarra.MontoMinimoStr = DecimalToStringFormat(dataBarra.MontoMinimo, true);
    dataBarra.MontoMaximo = Math.ceil(dataBarra.MontoMaximo);
    dataBarra.MontoMaximoStr = DecimalToStringFormat(dataBarra.MontoMaximo, true);
    dataBarra.TippingPoint = Math.ceil(dataBarra.TippingPoint);
    dataBarra.TippingPointStr = DecimalToStringFormat(dataBarra.TippingPoint, true);

    var me = data.MontoEscala;
    var md = data.MontoDescuento;
    var mx = data.MontoMaximo;
    var mn = data.MontoMinimo;
    var tp = data.TippingPoint;
    var mt = data.TotalPedido;

    var listaLimite = new Array();

    var widthTotal = GetWidthTotalBase();
    if (widthTotal <= 0)
        return false;

    var wPrimer = 0;
    var vLogro = mt - md;
    var wMsgFin = 0;
    var wmin = 45;
    if (!(mn == "0,00" || mn == "0.00" || mn == "0")) {
        wPrimer = wmin;
    }
    var TippingPointBarraActive = false;
    if (dataBarra.hasOwnProperty("TippingPointBarra"))
        TippingPointBarraActive = dataBarra.TippingPointBarra.Active;

    var valTopTotal = destino == '2' && TippingPointBarraActive && tp > 0 ? tp : mn;

    if (vLogro > valTopTotal) vLogro = valTopTotal > me ? valTopTotal : me;
    listaEscalaDescuento = listaEscalaDescuento || new Array();
    var listaEscala = new Array();
    var indDesde = -1;
    $.each(listaEscalaDescuento, function (ind, monto) {
        if (mx > 0 && destino == "1") {
            var desde = indDesde == -1 ? mx : listaEscalaDescuento[indDesde].MontoHasta
            if (mn < monto.MontoHasta && mx >= desde) {
                monto.MontoDesde = indDesde == -1 ? mn : listaEscalaDescuento[indDesde].MontoHasta;
                monto.MontoDesdeStr = indDesde == -1 ? data.MontoMinimoStr : listaEscalaDescuento[indDesde].MontoHastaStr;
                listaEscala.push(monto);
                indDesde = ind;
            }
        }
        else if (mn < monto.MontoHasta) {
            monto.MontoDesde = indDesde == -1 ? mn : listaEscalaDescuento[indDesde].MontoHasta;
            monto.MontoDesdeStr = indDesde == -1 ? data.MontoMinimoStr : listaEscalaDescuento[indDesde].MontoHastaStr;
            listaEscala.push(monto);
            indDesde = ind;
        }
    });

    var textoPunto = '<div style="font-size:12px; font-weight:400; margin-bottom:4px;">{titulo}</div><div style="font-size: 12px;">{detalle}</div>';
    if (mx > 0 && destino == '2') {
        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "M. Mínimo").replace("{detalle}", variablesPortal.SimboloMoneda + " " + data.MontoMinimoStr),
            tipoMensaje: 'MontoMinimo',
            width: wPrimer,
            valor: data.MontoMinimo,
            valorStr: data.MontoMinimoStr
        });

        if (tp > 0 && dataBarra.TippingPointBarra.Active) {
            listaLimite.push({
                nombre: "",
                tipoMensaje: 'TippingPoint',
                valor: data.TippingPoint,
                valorStr: data.TippingPointStr
            });
        }

        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "M. Máximo").replace("{detalle}", variablesPortal.SimboloMoneda + " " + data.MontoMaximoStr),
            tipoMensaje: 'MontoMaximo',
            widthR: wmin,
            valor: data.MontoMaximo,
            valorStr: data.MontoMaximoStr
        });
    }
    else {

        if (mx > 0 && destino == "1" && listaEscala.length > 0) {
            listaEscala[listaEscala.length - 1].MontoHasta = mx;
            listaEscala[listaEscala.length - 1].MontoHastaStr = data.MontoMaximoStr;
        }

        var textoPunto2 = (destino == "1" && caminoBrillante == "True") ? '<div style="font-weight: bold;">{titulo}</div><div style="font-size: 11px;">DSCTO</div>' :
            '<div style="font-weight: bold;">{titulo}</div><div style="font-size: 11px;">{detalle}</div>'


        var textoApp = '<div>{titulo}</div><div>{detalle}</div>';
        $.each(listaEscala, function (ind, monto) {
            var montox = ind == 0 ? monto : listaEscala[ind - 1];
            listaLimite.push({
                nombre: textoPunto
                    .replace("{titulo}", monto.PorDescuento + "% DSCTO")
                    .replace("{detalle}", (ind == 0 ? "M. Mínimo: " : "") + variablesPortal.SimboloMoneda + " " + (ind == 0 ? data.MontoMinimoStr : montox.MontoHastaStr)),
                nombre2: textoPunto2.replace("{titulo}", monto.PorDescuento + "% {DSCTO}"),
                nombreApp: textoApp
                    .replace("{titulo}", "<span>" + monto.PorDescuento + "</span>" + "% DSCTO")
                    .replace("{detalle}", variablesPortal.SimboloMoneda + " " + (ind === 0 ? data.MontoMinimoStr : montox.MontoHastaStr)),
                width: ind == 0 ? wPrimer : null,
                widthR: ind == listaEscala.length - 1 ? wmin : null,
                tipoMensaje: 'EscalaDescuento',
                valPor: monto.PorDescuento,
                valor: ind == 0 ? data.MontoMinimo : montox.MontoHasta,
                valorStr: ind == 0 ? data.MontoMinimoStr : montox.MontoHastaStr,
                tipo: ind == 0 ? 'min' : ind == listaEscala.length - 1 ? 'max' : 'int',
                MontoDesde: monto.MontoDesde,
                MontoDesdeStr: monto.MontoDesdeStr,
                MontoHasta: monto.MontoHasta,
                MontoHastaStr: monto.MontoHastaStr
            });
        });

        if (listaLimite.length == 0 && mn > 0 && destino == '2') {
            listaLimite.push({
                nombre: textoPunto.replace("{titulo}", "M. Mínimo").replace("{detalle}", variablesPortal.SimboloMoneda + " " + data.MontoMinimoStr),
                tipoMensaje: 'MontoMinimo',
                width: wPrimer,
                valor: data.MontoMinimo,
                valorStr: data.MontoMinimoStr,
                MontoDesde: 0,
                MontoDesdeStr: DecimalToStringFormat(0, true),
                MontoHasta: data.MontoMinimo,
                MontoHastaStr: data.MontoMinimoStr
            });
        }
    }
    mtoLogroBarra = vLogro;

    listaLimite = listaLimite || new Array();
    if (listaLimite.length == 0)
        return false;

    var indPuntoLimite = 0;

    listaLimite = listaLimite || new Array();
    $.each(listaLimite, function (ind, limite) {
        if (ind > 0) {
            var valBack = listaLimite[ind - 1].valor;
            if (valBack < vLogro && vLogro < limite.valor) {
                indPuntoLimite = ind;
            }
            else if (vLogro >= limite.valor) {
                indPuntoLimite = ind;
            }
            else if (valBack == vLogro && vLogro > 0) {
                indPuntoLimite = ind;
            }
        }
    });

    var wTotal = widthTotal;
    var vLimite = listaLimite[indPuntoLimite].valor;

    $("#divBarra").show();
    if (!belcorp.barra.settings.isMobile) {
        $("#divBarra #divBarraPosicion").css("width", wTotal);
        $("#divBarra").css("width", wTotal);
    }

    var styleMin = 'style="margin-left: 6px;"';

    var htmlPunto = "";

    if (destino == 2) {
        htmlPunto = '<div id="punto_{punto}" data-punto="{select}">'
            + '<div class="monto_minimo_barra" style="width:{wText}px">'
            + '<div style="width:{wText}px;position: absolute; color:#808080;" data-texto>{texto}</div>'
            + '</div>'
            + '</div>'
            + '<div class="linea_indicador_barra" id="barra_{punto}" {style}></div>';
    }
    else
        htmlPunto = '<div id="punto_{punto}" data-punto="{select}">'
            + '<div class="monto_minimo_barra" style="width:{wText}px">'
            + '<div style="width:{wText}px;position: absolute; color:#808080;" data-texto>{texto}</div>'
            + '<div class="linea_indicador_barra_vista_bienvenida"></div>'
            + '</div>'
            + '</div>';

    // quitando esta clase contenedor_tippingPoint se quita el tooltip y el efecto que salta
    var htmlTippintPoint = "";
    var dataTP = dataBarra.TippingPointBarra;

    // si se va ha mostrar el tooltip
    if (dataTP.Active) {
        if (destino == '2') {
            htmlTippintPoint =
                '<div id="punto_{punto}" data-punto="{select}" style="position: relative; top: -51px; z-index: 200;">'
                + '<div class="monto_minimo_barra">'
                + '<div style="width:{wText}px;position: relative;" data-texto>'
                + '<div class="{barra_tooltip_class}">';

            if (esPedidoReservado) {
                htmlTippintPoint = htmlTippintPoint + '<a class="tippingPoint {estado}" href="javascript:;" ></a>';
            } else {
                htmlTippintPoint = htmlTippintPoint + '<a class="tippingPoint {estado}" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo(' + "'Ver Regalos'" + ');"></a>';
            }

            htmlTippintPoint = htmlTippintPoint
                + '{barra_monto}'
                + '{barra_tooltip}'
                + '</div>'
                + '<div class="contenedor_circulos microEfecto_regaloPendienteEleccion">'
                + '<div class="circulo-1 iniciarTransicion"></div>'
                + '<div class="circulo-2 iniciarTransicion"></div>'
                + '<div class="circulo-3 iniciarTransicion"></div>'
                + '</div>'
                + '</div>'
                + '</div>'
                + '</div>';
        }
        else {
            htmlTippintPoint =
                '<div id="punto_{punto}" data-punto="{select}" style="position: relative; top: -51px; z-index: 200;">'
                + '<div class="monto_minimo_barra">'
                + '<div style="width:{wText}px;position: relative;" data-texto>'
                + '<div class="{barra_tooltip_class}">';

            if (esPedidoReservado) {
                htmlTippintPoint = htmlTippintPoint + '<a class="tippingPoint {estado}" href="javascript:;"></a>';
            } else {
                htmlTippintPoint = htmlTippintPoint + '<a class="tippingPoint {estado}" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo(' + "'Ver Regalos'" + ');"></a>';
            }

            htmlTippintPoint = htmlTippintPoint
                + '{barra_monto}'
                + '{barra_tooltip}'
                + '</div>'
                + '<div class="contenedor_circulos microEfecto_regaloPendienteEleccion">'
                + '<div class="circulo-1 iniciarTransicion"></div>'
                + '<div class="circulo-2 iniciarTransicion"></div>'
                + '<div class="circulo-3 iniciarTransicion"></div>'
                + '</div>'
                + '</div>'
                + '<div class="linea_indicador_barra_vista_bienvenida"></div>'
                + '</div>'
                + '</div>';
        }

        htmlTippintPoint = htmlTippintPoint
            .replace('{barra_tooltip_class}', dataTP.ActiveTooltip ? 'contenedor_tippingPoint' : '')
            .replace('{barra_tooltip}',
                dataTP.ActiveTooltip ?
                    '<div class="tooltip_regalo_meta_tippingPoint">'
                    + '<div class="tooltip_producto_regalo_img">'
                    + '<img src="' + dataTP.LinkURL + '" alt="Producto de regalo"/>'
                    + '</div>'
                    + '{barra_tooltip_descripcion}'
                    + '</div>' :
                    ''
            )
            .replace('{barra_monto}',
                dataTP.ActiveMonto ?
                    '<div class="monto_meta_tippingPoint">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div>' :
                    ''
            )
            .replace('{barra_tooltip_descripcion}',
                dataTP.ActiveMonto ?
                    '<div class="tooltip_producto_regalo_descripcion">Llega a <span>' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</span><br>y llévate de regalo<br><strong>' + dataTP.DescripcionCUV2 + '</strong></div>' :
                    '<div class="tooltip_producto_regalo_descripcion"><br> Llévate de regalo<br><strong>' + dataTP.DescripcionCUV2 + '</strong></div>'
            );
    }

    var htmlPuntoLimite = "";
    if (destino == '2') {
        htmlPuntoLimite = '<div id="punto_{punto}" data-punto="{select}">'
            + '<div class="monto_minimo_barra">'
            + '<div style="width: {wText}px;position: absolute; color:#808080;" data-texto>{texto}</div>'
            + '</div>'
            + '</div>'
            + '<div class="linea_indicador_barra" id="barra_{punto}" {style}></div>';
    }
    else {
        htmlPuntoLimite = '<div id="punto_{punto}" data-punto="{select}">'
            + '<div class="monto_minimo_barra">'
            + '<div style="width: {wText}px;position: absolute; color:#808080;" data-texto>{texto}</div>'
            + '<div class="linea_indicador_barra_vista_bienvenida"></div>'
            + '</div>'
            + '</div>';
    }

    if (mx > 0 || destino == '1') htmlPuntoLimite = htmlPunto;
    var wTotalPunto = 0;
    $("#divBarra #divBarraLimite").html("");

    $.each(listaLimite, function (ind, limite) {
        var htmlSet = indPuntoLimite == ind && ind > 0 ? vLogro < vLimite ? htmlPuntoLimite : htmlPunto : htmlPunto;
        htmlSet = ind == 1 && indPuntoLimite == 0 && mn == 0 ? htmlPuntoLimite : htmlSet;
        htmlSet = limite.tipoMensaje == 'TippingPoint' ? htmlTippintPoint : htmlSet;

        var selectPunto = "0";
        var wText = ind == 0 ? "130" : "90";
        if (destino == '1') {
            if (vLogro < vLimite) {
                wText = indPuntoLimite - 1 != ind || indPuntoLimite == 0 ? "55" : "130";
                selectPunto = indPuntoLimite - 1 != ind || indPuntoLimite == 0 ? "0" : "1";
            }
            else {
                wText = indPuntoLimite != ind || indPuntoLimite == 0 ? "55" : "130";
                selectPunto = indPuntoLimite != ind || indPuntoLimite == 0 ? "0" : "1";
            }

        }
        var marl = indPuntoLimite == listaLimite.length - 1 ? "-80" : "21";
        if (destino == '1' && indPuntoLimite == 0) {
            wText = wTotal / listaLimite.length
            marl = "0";
        }
        var activo = limite.tipoMensaje == 'TippingPoint' && indPuntoLimite == 1 ? "activo" : "";
        var styleMinx = mn == 0 && ind == 0 ? styleMin : "";
        var nombrePunto = limite.nombre;
        if (destino == '1') {
            if (selectPunto == "0" && indPuntoLimite == 0 && mn == 0) {
                styleMinx = "";
            }
            var txtDscto = "";
            var txtDetalle = "";
            if (vLogro <= vLimite) {

                if (indPuntoLimite == 0) {
                    txtDscto = "";
                    txtDetalle = "DSCTO";
                }
                else {
                    if (caminoBrillante == "True") {
                        txtDscto = "";
                    } else {
                        txtDscto = "DSCTO";
                        txtDetalle = indPuntoLimite - 1 != ind ? "" :
                            (variablesPortal.SimboloMoneda + "" + limite.MontoDesdeStr + " a " + variablesPortal.SimboloMoneda + "" + limite.MontoHastaStr);
                    }
                }
            }
            else {
                if (caminoBrillante == "True") {
                    txtDscto = "";
                } else {
                    txtDscto = "DSCTO";
                    txtDetalle = indPuntoLimite != ind ? "" :
                        (variablesPortal.SimboloMoneda + "" + limite.MontoDesdeStr + " a más");
                    if (mx > 0 && destino == "1") {
                        txtDetalle = indPuntoLimite != ind ? "" :
                            (variablesPortal.SimboloMoneda + "" + limite.MontoDesdeStr + " a " + variablesPortal.SimboloMoneda + "" + limite.MontoHastaStr);
                    }
                }
            }

            nombrePunto = limite.nombre2
                .replace("{DSCTO}", txtDscto)
                .replace("{detalle}", txtDetalle);
        }

        htmlSet = htmlSet
            .ReplaceAll("{punto}", ind)
            .ReplaceAll("{texto}", nombrePunto)
            .ReplaceAll("{wText}", wText)
            .ReplaceAll("{marl}", marl)
            .ReplaceAll("{estado}", activo)
            .ReplaceAll("{style}", styleMinx)
            .ReplaceAll("{select}", selectPunto);

        var objH = $(htmlSet).css("float", 'left');
        $("#divBarra #divBarraLimite").append(objH);

        var wPunto = wText;
        if (!(destino == '1' && indPuntoLimite == 0)) {
            wPunto = $("#punto_" + ind + " [data-texto]").width();
            wPunto += $("#punto_" + ind + " .bandera_marcador").width() || 0;

            if (indPuntoLimite == listaLimite.length - 1 && indPuntoLimite == ind) {
                if (destino == '2' && vLogro < vLimite && mx <= 0) {
                    wPunto = wmin;
                }

                $("#punto_" + ind).css("width", wPunto);
                if (ind == 0 && mn == 0) {
                    $("#punto_" + ind + " .linea_indicador_barra").css("margin-left", "0px;");
                }
            }
        }
        wTotalPunto += wPunto;
    });
    $("#divBarra #divBarraLimite").append("<div class='clear'></div>");

    if (destino == '1') {
        $("#divBarraLimite [data-punto='0']").find("[data-texto]").css("color", "#979797");
        $("#divBarraLimite [data-punto='1']").find("[data-texto]").css("color", "#808080");
        $("#divBarraLimite [data-punto='1']").find("[data-texto]").css("font-weight", "bold");
    }

    if (wTotalPunto > wTotal) {
        var indAux = indPuntoLimite;
        while (indAux > 1) {
            if (indAux - 1 < indPuntoLimite - 1) {
                var wwx = $("#punto_" + (indAux - 1) + " [data-texto]").width();
                wTotalPunto -= wwx;
                $("#punto_" + (indAux - 1)).remove();
                listaLimite.splice(indAux - 1, 1);
                if (wTotalPunto < wTotal) {
                    indAux = 0;
                }
            }
            indAux--;
        }
        if (wTotalPunto > wTotal) {
            indAux = listaLimite.length;
            while (indAux > indPuntoLimite + 1) {
                var wwx = $("#punto_" + (indAux) + " [data-texto]").width();
                wTotalPunto -= wwx;
                $("#punto_" + indAux).remove();
                listaLimite.splice(indAux, 1);
                indAux--;
                if (wTotalPunto < wTotal) {
                    indAux = 0;
                }
            }
        }
    }

    var wAreaMover = widthTotal - wTotalPunto;
    if (destino == "1" && indPuntoLimite == 0) {
        wAreaMover = 0;
    }
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) {
            $("#punto_" + (indPuntoLimite)).css("margin-right", wAreaMover);
        }
        else {
            $("#punto_" + (indPuntoLimite - 1)).css("margin-right", wAreaMover);
        }
    }
    else {
        if (mn > 0) {
            if (destino == '1') $("#punto_" + indPuntoLimite).css("margin-left", wAreaMover);
        }
        else {
            $("#punto_" + indPuntoLimite).css("margin-right", wAreaMover);
        }
    }

    var wPuntosAnterior = 0;
    indAux = indPuntoLimite;
    while (indAux > 0) {
        if (indAux == 1 && mn == 0 && indPuntoLimite == 1) {
            wPuntosAnterior += 0;
        }
        else {
            wPuntosAnterior += $("#punto_" + (indAux - 1)).width();
        }
        indAux--;
    }
    if (mn > 0) {
        if (vLogro >= vLimite) {
            if (indPuntoLimite > 0) {
                wPuntosAnterior += $("#punto_" + indPuntoLimite).width();
            }
        }
    }
    else {
        if (indPuntoLimite == 1) {
            wPuntosAnterior += $("#punto_" + (indPuntoLimite - 1)).width();
        }
    }

    var wLimite = wAreaMover + wPuntosAnterior;
    var wLimiteAnterior = wPuntosAnterior;
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) {
            wLimite = widthTotal;
            wLimiteAnterior -= parseInt($("#punto_" + (indPuntoLimite) + " >  div").width() / 2, 10);
        }
        else {
            wLimiteAnterior -= wLimiteAnterior <= 0 ? 0 : $("#punto_" + (indPuntoLimite - 1)).width() - parseInt($("#punto_" + (indPuntoLimite - 1) + " >  div").width() / 2, 10);
            if ($("#punto_" + indPuntoLimite).find(".bandera_marcador").length == 0) {
                wLimite += parseInt($("#punto_" + (indPuntoLimite) + " >  div").width() / 2, 10);
            }
        }
    }
    else {
        var indxx = indPuntoLimite == 0 && mn == 0 ? (indPuntoLimite + 1) : indPuntoLimite;
        if ($("#punto_" + indxx).find(".bandera_marcador").length == 0) {
            wLimite += parseInt($("#punto_" + (indxx) + " >  div").width() / 2, 10);
        }
        if (indPuntoLimite == 0 && mn == 0) {
            wLimite += parseInt($("#punto_" + (0)).width(), 10);
        }
    }
    wLimiteAnterior = wLimiteAnterior < 0 ? 0 : wLimiteAnterior;
    wAreaMover = wLimite - wLimiteAnterior;

    listaLimite = listaLimite || new Array();
    $.each(listaLimite, function (ind, limite) {
        if (ind > 0) {
            var valBack = listaLimite[ind - 1].valor;
            if (valBack < vLogro && vLogro < limite.valor) {
                indPuntoLimite = ind;
            }
            else if (vLogro >= limite.valor) {
                indPuntoLimite = ind;
            }
            else if (valBack == vLogro && vLogro > 0) {
                indPuntoLimite = ind;
            }
        }
    });

    var vLimiteAnterior = indPuntoLimite > 0 ? listaLimite[indPuntoLimite - 1].valor : 0;
    var vMover = vLogro - vLimiteAnterior;
    var vDiferencia = listaLimite[indPuntoLimite].valor - vLimiteAnterior;
    var wLogro = wLimiteAnterior;
    wLogro += vDiferencia > 0 ? (vMover * wAreaMover) / vDiferencia : 0;

    if (wLimite == widthTotal) {
        if (vLogro > vLimite) {
            wLogro = widthTotal - 20;
        }
        else if (vLogro == vLimite) {
            wLogro = wLimiteAnterior;
        }
    }

    if (listaLimite.length == 1) {
        if (vLogro > vLimite) {
            wLimite = widthTotal;
            wLogro = widthTotal - 20;
        }
    }

    if (destino == '2') {
        if (belcorp.barra.settings.isMobile) {
            wLogro = CalculoLlenadoBarra();
            CalculoPosicionMinimoMaximo();
        }
        else {
            wLogro = CalculoLlenadoBarraDestokp();
            wLimite = CalculoLlenadoBarraEspacioLimiteDestokp();
        }
    }

    $("#divBarra #divBarraEspacioLimite").css("width", wLimite);
    $("#divBarra #divBarraEspacioLogrado").css("width", wLogro);

    if (mn == 0 && vLogro == 0 && !belcorp.barra.settings.isMobile) {
        $("#divBarra #divBarraMensajeLogrado").hide();

        var montoPedidoIngresado = 0;
        var valorTexto = $.trim($('#spanPedidoIngresado').text().split(' ')[1]);

        if (valorTexto.length > 0) {
            montoPedidoIngresado = parseFloat(valorTexto);
        }

        if (TieneMontoMaximo()) { // se trata como tipinpoing
            if (dataBarra.TippingPointBarra.Active != null && dataBarra.TippingPointBarra.Active != false) {
                document.getElementById('punto_0').style = '';
                document.getElementById('punto_0').className = 'EscalaDescuento';
                document.getElementById('punto_1').className = 'EscalaDescuento';
                document.getElementById('punto_2').className = 'EscalaDescuento';
            }
            else {
                if (ConfiguradoRegalo == true) {
                    document.getElementById('punto_0').style = '';
                    document.getElementById('punto_0').className = 'EscalaDescuento';
                    document.getElementById('punto_1').className = 'EscalaDescuento';
                    document.getElementById('punto_2').className = 'EscalaDescuento';
                }
                else {
                    document.getElementById('punto_0').style = '';
                    document.getElementById('punto_0').className = 'EscalaDescuento';
                    document.getElementById('punto_1').className = 'EscalaDescuento';
                }
            }
        } else if (montoPedidoIngresado > 0) {
            for (var x = 0; x < dataBarra.ListaEscalaDescuento.length; x++) {
                if (x == 0) {
                    if (document.getElementById('punto_0')) document.getElementById('punto_0').style = '';
                    if (document.getElementById('punto_0')) document.getElementById('punto_0').className = 'EscalaDescuento';
                }
                else {
                    if (document.getElementById('punto_' + x.toString())) document.getElementById('punto_' + x.toString()).className = 'EscalaDescuento';

                }
            }
        }

        CalculoPosicionMinimoMaximoDestokp();
        return false;
    }

    var valorFalta = vLimite - vLogro;
    var tipoMensaje = '';
    var muestraTP = destino == '2' && dataBarra.TippingPointBarra.Active && tp > 0;
    var limiteEsPremio = vLogro < tp;

    if (mn == 0 && vLogro == 0) tipoMensaje = "";
    else if (muestraTP && vLogro == 0) tipoMensaje = "Inicio";
    else if (muestraTP && limiteEsPremio) {
        valorFalta = tp - vLogro;
        tipoMensaje = "TippingPoint";
    }
    else if (vLogro < mn) tipoMensaje = "MontoMinimo";
    else {
        tipoMensaje = listaLimite[indPuntoLimite].tipoMensaje;
        if (tipoMensaje == 'EscalaDescuento') valorFalta = vLimite - me;
        if (vLogro >= vLimite) tipoMensaje += "Supero";
    }

    showToolTipPremioDetalle(tp);

    if (belcorp.barra.settings.isMobile) {
        cargarMontoBanderasMobile(dataBarra);
    }

    listaMensajeMeta = listaMensajeMeta || new Array();
    var objMsg = getMessageBarra(tipoMensaje);
    if (!belcorp.barra.settings.isMobile) objMsg.Mensaje += ' (*)';

    if (objMsg.Mensaje != "") {
        $("#divBarra #divBarraMensajeLogrado").show();
    }
    var valPor = listaLimite[indPuntoLimite].valPor || "";
    var valorMonto = variablesPortal.SimboloMoneda + " " + DecimalToStringFormat(parseFloat(valorFalta));

    $("#divBarra #divBarraMensajeLogrado .mensaje_barra").html(objMsg.Titulo.replace("#porcentaje", valPor).replace("#valor", valorMonto));

    var dvMsg = $("#divBarra #divBarraMensajeLogrado .barra_title");
    dvMsg.html(muestraTP && mtoLogroBarra >= tp && hasPremioInDetails() ? tpElectivos.messages.textAlcanzasteRegalo : '');


    if (tp > 0 && dataBarra.TippingPointBarra.Active) {
        $('#hrefIconoRegalo').show();

        if (ConfiguradoRegalo == true && document.getElementById('divtippingPoint') != null) {
            document.getElementById('divtippingPoint').style.display = 'none';
            document.getElementById('lineaPosicionRegalo').style.display = 'none';
        }
    }

    var divBarraMsg = $("#divBarra #divBarraMensajeLogrado .agrega_barra");
    divBarraMsg.html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", valorMonto));


    $("#divBarraMensajeLogrado").css("width", "");
    var wMsgTexto = $("#divBarra #divBarraMensajeLogrado > div").width() + 1;
    wMsgTexto = wLogro + wMsgTexto >= wTotal ? wTotal : (wLogro + wMsgTexto);
    if (!belcorp.barra.settings.isMobile) {
        $("#divBarra #divBarraMensajeLogrado").css("width", wMsgTexto);
    }


    if (destino == '2') {
        if (dataBarra.TippingPointBarra.InMinimo != null) {
            ConfiguradoRegalo = dataBarra.TippingPointBarra.InMinimo;
        }

        if (!belcorp.barra.settings.isMobile) {
            if (TieneMontoMaximo()) { // se trata como tipinpoing

                if (dataBarra.TippingPointBarra.Active != null && dataBarra.TippingPointBarra.Active != false) {
                    document.getElementById('punto_0').style = '';
                    document.getElementById('punto_0').className = 'EscalaDescuento';
                    document.getElementById('punto_1').className = 'EscalaDescuento';
                    document.getElementById('punto_2').className = 'EscalaDescuento';
                }
                else {


                    if (ConfiguradoRegalo == true) {
                        document.getElementById('punto_0').style = '';
                        document.getElementById('punto_0').className = 'EscalaDescuento';
                        document.getElementById('punto_1').className = 'EscalaDescuento';
                        document.getElementById('punto_2').className = 'EscalaDescuento';
                    }
                    else {
                        document.getElementById('punto_0').style = '';
                        document.getElementById('punto_0').className = 'EscalaDescuento';
                        document.getElementById('punto_1').className = 'EscalaDescuento';
                    }

                }

            }
            else {

                for (var x = 0; x < dataBarra.ListaEscalaDescuento.length; x++) {
                    if (x == 0) {
                        if (document.getElementById('punto_0')) document.getElementById('punto_0').style = '';
                        if (document.getElementById('punto_0')) document.getElementById('punto_0').className = 'EscalaDescuento';
                    } else {
                        if (document.getElementById('punto_' + x.toString())) document.getElementById('punto_' + x.toString()).className = 'EscalaDescuento';

                    }
                }

            }

            CalculoPosicionMinimoMaximoDestokp();
            CalculoPosicionMensajeDestokp();
            var premioNoSelected = destino == '2' && tpElectivos.hasPremios && !tpElectivos.premioSelected;
            if (premioNoSelected) {
                $('#divBarra .contenedor_circulos').show();
            }
        }
    }


    return true;
}

function getMessageBarra(tipoMensaje) {
    if (tipoMensaje == 'Inicio' || tipoMensaje == 'TippingPoint') {
        if (!tpElectivos.loadedPremios) {
            tipoMensaje = '';
        }
        else if (isKitInicio(tpElectivos.premios)) {
            tipoMensaje += 'Kit';
        }
    }

    var msg = listaMensajeMeta.Find("TipoMensaje", tipoMensaje)[0] || new Object();

    msg.Titulo = $.trim(msg.Titulo);
    msg.Mensaje = $.trim(msg.Mensaje);

    return msg;
}
function calcMtoLogro(data, destino) {
    var barra = data.DataBarra;
    var me = data.MontoEscala;
    var md = data.MontoDescuento;
    var mn = data.MontoMinimo;
    var mx = data.MontoMaximo;
    var mt = data.TotalPedido;
    var tp = data.TippingPoint;

    var vLogro = mt - md;

    if (!(mx > 0 && destino == '2')) {
        var valTopTotal = destino == '2' && barra.TippingPointBarra.Active && tp > 0 ? tp : mn;
        if (vLogro > valTopTotal) vLogro = valTopTotal > me ? valTopTotal : me;
    }

    mtoLogroBarra = vLogro;

    return vLogro;
}

function showToolTipPremioDetalle(tp) {
    if (tp == 0) return;

    var dv = $('.tooltip_informativo_condicion_regalo_programaNuevas');
    if (mtoLogroBarra < tp) {
        var mtoTp = variablesPortal.SimboloMoneda + " " + dataBarra.TippingPointStr;
        dv.html('Sólo si llegas a ' + mtoTp);
        dv.show();
    } else {
        dv.hide();
    }
}

function cargarMontoBanderasMobile(barra) {
    $('#divMontoMinimo').html(variablesPortal.SimboloMoneda + ' ' + barra.MontoMinimoStr);
    $('#divMontoMaximo').html(variablesPortal.SimboloMoneda + ' ' + barra.MontoMaximoStr);
    var divMontoTp = $('#divtippingPoint');

    if (barra.TippingPointBarra.ActiveMonto) {
        divMontoTp.html(variablesPortal.SimboloMoneda + ' ' + barra.TippingPointStr);
        divMontoTp.show();
    } else {
        divMontoTp.hide();
        $('#lineaPosicionRegalo').hide();
    }
}

function savePedidoDetails(response) {
    if (!response.data) {
        return;
    }

    tpElectivos.pedidoDetails = response.data.ListaDetalleModel || [];
}

function hasPremioInDetails() {
    var details = tpElectivos.pedidoDetails;
    if (!details || details.length === 0) return false;

    return getPremioElectivoInDetails(tpElectivos.pedidoDetails);
}

function initCarruselPremios(barra) {
    if (tpElectivos.loadPremios) {
        return;
    }

    if (barra.TippingPointBarra && barra.TippingPointBarra.ActivePremioElectivo) {
        tpElectivos.loadPremios = true;
        cargarPremiosElectivos();

        return;
    }

    hidePencilInDetails();
}


function cerrarProgramaNuevas(valor) {
    var valorCerrar = "icono_cerrar_popup_eleccion_regalo_programaNuevas";
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Carrito de Compras',
        'action': valor.className == valorCerrar ? valor.title : valor.innerHTML,
        'label': 'popupPremio',
    });

}


function cargarPopupEleccionRegalo(disableCheck) {
    if (!tpElectivos.hasPremios) {
        return;
    }

    var disable = typeof disableCheck === 'boolean' && disableCheck === true;
    if (!disable) {
        checkPremioSelected(true);
    }

    showTextsPremio();

    var disableValue = typeof disableCheck === 'string' && disableCheck.length > 0;
    if (disableValue) {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Carrito de Compras',
            'action': 'Click Botón',
            'label': disableCheck
        });
    }
    AbrirPopup('#popupEleccionRegalo');
    setTimeout(function () {
        armarCarouselRegalos();
    }, 150);
}

function isTippingPointSuperado() {
    if (!dataBarra) {
        return false;
    }

    var tp = dataBarra.TippingPoint;
    return tp > 0 &&
        mtoLogroBarra >= tp &&
        dataBarra.TippingPointBarra &&
        dataBarra.TippingPointBarra.ActivePremioElectivo &&
        tpElectivos.hasPremios &&
        !tpElectivos.premioSelected;
}

function checkPremioSelected(validateInCarrusel) {
    var details = tpElectivos.pedidoDetails;
    if (!details || details.length === 0) {

        return;
    }

    var detail = getPremioElectivoInDetails(details);
    if (!detail) {
        if (tpElectivos.premioSelected) {
            setPremio(null);
        }

        return;
    }

    if (isCuvSelected(detail.CUV, validateInCarrusel)) {
        return;
    }

    var premio = getPremioByCuv(detail.CUV);

    setPremio(premio);
}

function trySetPremioElectivo(cuv) {
    if (tpElectivos.premioSelected &&
        tpElectivos.premioSelected.CUV2 == cuv) {
        return;
    }

    var premio = getPremioByCuv(cuv);
    if (!premio) {
        return;
    }

    setPremio(premio);
}

function getPremioElectivoInDetails(details) {
    var len = details.length;

    for (var i = 0; i < len; i++) {
        var item = details[i];

        if (item.EsPremioElectivo) {
            return item;
        }
    }

    return null;
}

function getPremioElectivos() {
    var dfd = jQuery.Deferred();

    jQuery.ajax({
        type: "POST",
        url: baseUrl + "Pedido/CargarPremiosElectivos",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        async: true,
        cache: false,
        success: function (data) {
            dfd.resolve(data);
        },
        error: function (data, error) {
            dfd.reject(data, error);
        }
    });

    return dfd.promise();
}

function getPremiosEstrategia(list) {
    var len = list.length;
    var premios = [];
    for (var i = 0; i < len; i++) {
        var item = list[i];
        if (item.ImagenURL) {
            premios.push(item);
        }
    }

    return premios;
}

function hidePencilInDetails() {
    var style = $('<style>.icono_cambiar_regalo_programaNuevas { display: none; }</style>');
    $('html > head').append(style);
}

function cargarPremiosElectivos() {
    getPremioElectivos()
        .then(function (response) {
            tpElectivos.premios = response.lista;
            tpElectivos.premioSelected = response.selected;
            tpElectivos.messages = buildMessages(tpElectivos.premios);
            var premiosMostrar = getPremiosEstrategia(tpElectivos.premios);
            tpElectivos.loadedPremios = true;

            if (isTippingPointSuperado()) {
                agregarPremioDefault();
            }

            if (premiosMostrar.length === 0) {
                MostrarBarra();
                hidePencilInDetails();

                return;
            }

            SetHandlebars("#premios-electivos-template", { lista: premiosMostrar }, '#carouselOpcionesRegalo');
            loadCarruselPremiosEvents();

            $('#popupEleccionRegalo .descrip_regalo_carousel label').truncate({
                limit: 50,
                token: '...'
            });

            if (belcorp.barra.settings.isMobile) {
                if (!esPedidoReservado) {
                    dataLayer.push({
                        'event': 'virtualEvent',
                        'category': 'Carrito de Compras',
                        'action': 'Click Botón',
                        'label': 'Ver Regalos'
                    });

                    $('#hrefIconoRegalo').click(cargarPopupEleccionRegalo);
                }
            }

            setPremio(response.selected);
            tpElectivos.hasPremios = true;
            MostrarBarra();
        });
}

$.fn.truncate = function (options) {
    var defaults = {
        limit: 10,
        token: '...'
    };
    options = $.extend(defaults, options);
    return this.each(function () {
        var $element = $(this);
        var elementText = $element.text().replace(/\s\s+/g, ' ');

        var len = elementText.length;

        if (len > options.limit) {
            var lenToken = options.token.length;
            var replaceText = elementText.substr(0, options.limit - lenToken) + options.token;
            $element.text(replaceText);
        }

    });
};

function agregarPremioDefault() {
    var premio = getPremioDefault();
    if (!premio || tpElectivos.premioSelected) {
        return;
    }

    AgregarPremio(premio)
        .then(function (data) {
            if (!data) return;

            CallFnOFRegaloNuevas();
            tpElectivos.premioSelected = premio;
            $('#divBarra .contenedor_circulos').hide();
        });
}

function CallFnOFRegaloNuevas() { if (typeof ActValPopupOFByRegaloNuevas !== 'undefined' && $.isFunction(ActValPopupOFByRegaloNuevas)) ActValPopupOFByRegaloNuevas(); }

function getPremioDefault() {
    var list = tpElectivos.premios;

    for (var i = 0; i < list.length; i++) {
        var item = list[i];

        if (item.CuponElectivoDefault) {
            return item;
        }
    }

    return null;
}

function getElementPremiosByCuv(list, cuv) {
    var len = list.length;
    for (var i = 0; i < len; i++) {
        var element = $(list[i]);
        var currentCuv = element.data('cuv');

        if (currentCuv == cuv) {
            return element;
        }
    }
    return null;
}

function isCuvSelected(cuv, validateInCarrusel) {
    if (!tpElectivos.premioSelected ||
        tpElectivos.premioSelected.CUV2 != cuv) {
        return false;
    }

    if (!validateInCarrusel) {
        return true;
    }

    return isCuvSelectedInCarrusel(cuv);
}

function isCuvSelectedInCarrusel(cuv) {
    var element = getElementByCuv(cuv);

    return element && element.hasClass('opcion_regalo_carousel_elegido');
}

function loadCarruselPremiosEvents() {
    $('.texto_regalo_elegido').text(tpElectivos.messages.textElegido);
    $('.btn_elegir_regalo').click(seleccionRegaloProgramaNuevas);
}

function armarCarouselRegalos() {
    var carrusel = $('#carouselOpcionesRegalo');

    if (carrusel[0].slick) {
        return;
    }
    var options;

    if (belcorp.barra.settings.isMobile) {
        options = {
            infinite: true,
            lazyLoad: 'ondemand',
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: false,
            speed: 300,
            arrows: false,
            variableWidth: true,
            centerMode: true
        };
    } else {
        options = {
            infinite: false,
            lazyLoad: 'ondemand',
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 300,
            prevArrow: '<a class="ver_anterior_regalo js-slick-prev-h"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="ver_siguiente_regalo next js-slick-next-h"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>',
        };
    }

    carrusel.slick(options);
}

function seleccionRegaloProgramaNuevas() {
    var regaloProgramaNuevas = $(this);

    var cuv = regaloProgramaNuevas.parents('.opcion_regalo_carousel_programaNuevas').data('cuv');
    var premio = getPremioByCuv(cuv);

    if (!premio) {
        return;
    }

    var prevSelected = tpElectivos.premioSelected;
    var defaultSelectedAgain = prevSelected != null && prevSelected.CuponElectivoDefault && prevSelected.CUV2 == premio.CUV2;
    if (defaultSelectedAgain) {

        setPremio(premio);
        return;
    }

    AgregarPremio(premio)
        .then(function (data) {
            if (!data) return;

            CallFnOFRegaloNuevas();
            setPremio(premio);
        });
}

function markPremioSelected(premioDiv) {
    var btn = premioDiv.find('.btn_elegir_regalo');
    premioDiv.addClass('opcion_regalo_carousel_elegido');
    btn.fadeOut(100);
    btn.next().fadeIn(150);
}

function getPremioByCuv(cuv) {
    var cantPremios = tpElectivos.premios.length;
    for (var i = 0; i < cantPremios; i++) {
        var item = tpElectivos.premios[i];

        if (item.CUV2 == cuv) {
            return item;
        }
    }

    return null;
}

function getPopupRegalos() {
    return $('#popupEleccionRegalo');
}

function restoreDivPremios() {
    var divCarrusel = getPopupRegalos();
    divCarrusel.find('.opcion_regalo_carousel_programaNuevas').removeClass('opcion_regalo_carousel_elegido');
    divCarrusel.find('.mensaje_regalo_elegido').hide();
    divCarrusel.find('.btn_elegir_regalo').show();
}

function setPremio(premio) {
    tpElectivos.premioSelected = premio;
    restoreDivPremios();
    updateTitlePopupRegalos(premio);
    var btns = getPopupRegalos().find('.btn_elegir_regalo');
    btns.html(premio ? 'Cambiar' : 'Elegir');

    if (!premio) {
        $('#divBarra .contenedor_circulos').show();

        return;
    }

    $('#divBarra .contenedor_circulos').hide();
    selectPremioDivByCuv(tpElectivos.premioSelected.CUV2);
}

function updateTitlePopupRegalos(premio) {
    var msgRegaloDiv = getPopupRegalos().find('.mensaje_titulo_popup_eleccion_regalo');
    msgRegaloDiv.fadeOut(200);

    if (premio) {
        msgRegaloDiv.html(tpElectivos.messages.premioElegido);
    } else {
        msgRegaloDiv.html(tpElectivos.messages.puedesElegirPremio);
    }

    msgRegaloDiv.fadeIn(200);
}

function showTextsPremio() {
    if (!dataBarra) return -1;

    var subRegaloDiv = getPopupRegalos().find('.mensaje_subtitulo_regalo');
    var btn = getPopupRegalos().find('.btn_seguir_comprando');

    if (mtoLogroBarra < dataBarra.TippingPoint) {
        var mtoTp = variablesPortal.SimboloMoneda + " " + dataBarra.TippingPointStr;
        subRegaloDiv.html('Será tuyo si pasas ' + mtoTp);
        btn.html('Sigue comprando para llevártelo');
    } else {
        subRegaloDiv.html('Recuerda que puedes cambiarlo en cualquier momento');
        btn.html('Sigue comprando');
    }

    if (belcorp.barra.settings.isMobile) {
        btn.html('Sigue comprando');
    }
}

function getDivPremios() {
    var container = $('#carouselOpcionesRegalo');
    var slick = container[0].slick;
    if (slick) {
        return slick.$slides || [];
    }

    return container.find('.opcion_regalo_carousel_programaNuevas');
}

function getElementByCuv(cuv) {
    var list = getDivPremios();

    return getElementPremiosByCuv(list, cuv);
}

function selectPremioDivByCuv(cuv) {
    var element = getElementByCuv(cuv);
    if (!element) {
        return false;
    }

    markPremioSelected(element);
    return true;
}

function superoTippingPoint(barra, prevLogro) {
    var tippingPoint = barra.TippingPoint || 0;
    var montoMinimo = dataBarra.ListaEscalaDescuento[0].MontoDesde;
    var montoMaximo1 = dataBarra.ListaEscalaDescuento[1].MontoDesde;
    var montoMaximo2 = dataBarra.ListaEscalaDescuento[2].MontoDesde;

    if (tippingPoint > 0) {
        if (!barra.TippingPointBarra.Active) {
            return false;
        }

        var superaRegalo = tippingPoint <= mtoLogroBarra && tippingPoint > prevLogro;

        if (tieneIncentivo && tippingPoint <= mtoLogroBarra) {
            escala = dataBarra.ListaEscalaDescuento[0];
            // se mantiene entre la 1er y 2da escala de descuento
            if (montoIncentivo <= montoMaximo1) {
                if (mtoLogroBarra >= montoIncentivo && mtoLogroBarra <= montoMaximo1 && prevLogro > montoMinimo ) {
                    if (montoIncentivo > prevLogro) {
                        var content = 'Llegaste al' + '&nbsp' + escala.PorDescuento + '% Dscto.' + '</br>' + 'Y concursas por el incentivo.' + '</br>' + '¡Felicidades!';
                        showPopupIncentivo(content);
                        tpElectivos.tempPrevLogro = -1;
                        return false;
                    }
                }

            } else {
                escala = dataBarra.ListaEscalaDescuento[1];
                // se mantiene entre la 2da y 3era escala de descuento
                if (mtoLogroBarra >= montoMaximo1 && mtoLogroBarra >= montoIncentivo && mtoLogroBarra <= montoMaximo2) {
                    if (montoIncentivo > prevLogro) {
                        var content = 'Llegaste al' + '&nbsp' + escala.PorDescuento + '% Dscto.' + '</br>' + 'Y concursas por el incentivo.' + '</br>' + '¡Felicidades!';
                        showPopupIncentivo(content);
                        tpElectivos.tempPrevLogro = -1;
                        return false;
                    }
                }
            }

        }

        if (superaRegalo) {
            return true;
        }
    }

    return false;
}

function showPopupIncentivo(content) {
    var idPopup = '#popupIncentivo';
    $(idPopup + ' .titulo_popup_treinta_y_cinco_descuento').html(content);

    $(idPopup).show();
    setContainerLluvia(idPopup);
    mostrarLluvia();

    setTimeout(function () {
        $(idPopup).fadeOut(2000);
    }, 3000);
}

function showPopupEscalaSiguiente(dataBarra, prevLogro) {

    if (!dataBarra || !dataBarra.ListaEscalaDescuento) return false;
    var escala = 0;
    var indice = 0;
    var total = mtoLogroBarra;
    var len = dataBarra.ListaEscalaDescuento.length;
    var montoMaximo1 = dataBarra.ListaEscalaDescuento[1].MontoDesde;
    var montoMaximo2 = dataBarra.ListaEscalaDescuento[2].MontoDesde;
    var tippingPoint = dataBarra.TippingPoint || 0;

    if (tieneIncentivo && tippingPoint <=0 ) {

        // se mantiene entre la 1er y 2da escala de descuento
        if (montoIncentivo <= montoMaximo1) {
            indice = 1;
            escala = dataBarra.ListaEscalaDescuento[0];
            if (total >= montoIncentivo && total <= montoMaximo1) {
                if (montoIncentivo > prevLogro) {
                    var content = 'Llegaste al' + '&nbsp' + escala.PorDescuento + '% Dscto.' + '</br>' + 'Y concursas por el incentivo.' + '</br>' + '¡Felicidades!';
                    showPopupIncentivo(content);
                    tpElectivos.tempPrevLogro = -1;
                    return true;
                }
            }

        } else {
            // se mantiene entre la 2da y 3era escala de descuento
            indice = 2;
            escala = dataBarra.ListaEscalaDescuento[1];
            if (total >= montoMaximo1 && total >= montoIncentivo && total <= montoMaximo2) {
                if (montoIncentivo > prevLogro) {
                    var content = 'Llegaste al' + '&nbsp' + escala.PorDescuento + '% Dscto.' + '</br>' + 'Y concursas por el incentivo.' + '</br>' + '¡Felicidades!';
                    showPopupIncentivo(content);
                    tpElectivos.tempPrevLogro = -1;
                    return true;
                }
            }
        }

    } 
        // comportamiento sin incentivo 
        for (var i = indice; i < len; i++) {
            var escala = dataBarra.ListaEscalaDescuento[i];
            if (total >= escala.MontoDesde && total < escala.MontoHasta) {
                if (escala.MontoDesde > prevLogro) {
                        var content = escala.PorDescuento + '% Dscto.';
                        showPopupEscala(content);
                        tpElectivos.tempPrevLogro = -1;
                        return true;
                    }
                }
        }

    return false;
}

function showPopupEscala(content) {
    var idPopup = '#popupEscalaDescuento';
    $(idPopup + ' .porcentaje').html(content);

    $(idPopup).show();
    setContainerLluvia(idPopup);
    mostrarLluvia();

    setTimeout(function () {
        $(idPopup).fadeOut(2000);
    }, 3000);
}

function checkPopupEscala() {
    var montoMaximo1 = dataBarra.ListaEscalaDescuento[1].MontoDesde;
    if (tpElectivos.tempPrevLogro < 0) return;
    if (tieneIncentivo && mtoLogroBarra <= montoMaximo1) return;
    if (!TieneMontoMaximo()) {
        var prevLogro = tpElectivos.tempPrevLogro;
        setTimeout(function () {
            showPopupEscalaSiguiente(dataBarra, prevLogro);
        }, 200);
    }

    tpElectivos.tempPrevLogro = -1;
}

function setContainerLluvia(containerId) {
    if (typeof lluviaContainerId !== 'undefined') {
        lluviaContainerId = containerId;
    }
}

function showPopupNivelSuperado(barra, prevLogro) {
    if (!barra) {
        return;
    }
    tpElectivos.tempPrevLogro = prevLogro;
    var superoTp = superoTippingPoint(barra, prevLogro);

    if (superoTp) {

        checkPremioSelected(true);
        if (!tpElectivos.premioSelected) {
            agregarPremioDefault();
        }
        
            showPopupPremio();
        
        return;
    }

    if (!TieneMontoMaximo()) {
        showPopupEscalaSiguiente(barra, prevLogro);
    }
    else {
        if (mtoLogroBarra < dataBarra.MontoMaximo) {
            showPopupEscalaSiguiente(barra, prevLogro);
        }
    }
}

function showPopupPremio() {

    var idPopup = '#popupPremio';
    var dvPremio = $(idPopup);
    var btn = dvPremio.find('.btn_escoger_o_cambiar_regalo');
    dvPremio.find('.title-premio-elect').html('¡Felicidades!<br />' + (!tpElectivos.hasPremios ? tpElectivos.messages.textLlegasteRegalo : tpElectivos.messages.textTienesRegalo));
    dvPremio.find('.sub-premio-elect').css('display', !tpElectivos.hasPremios ? 'none' : 'block');
    btn.css('display', !tpElectivos.hasPremios ? 'none' : 'block');
    btn.html(tpElectivos.premioSelected ? 'CAMBIAR PRODUCTO' : '¡Escoger ahora!');
    AbrirPopup(idPopup);
    setContainerLluvia(idPopup);
    mostrarLluvia();

}

function addPremioDefaultSuperado(barra, prevLogro) {
    var superoTp = superoTippingPoint(barra, prevLogro);

    if (superoTp) {
        agregarPedidoDefaultExt();
    }
}

function agregarPedidoDefaultExt() {
    AbrirLoad();
    jQuery.ajax({
        type: 'POST',
        url: baseUrl + "PedidoRegistro/AgergarPremioDefault",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: true,
        cache: false
    }).always(function () {
        CerrarLoad();
    });
}



function CalculoLlenadoBarra() {
    var TippingPointBarraActive = dataBarra.TippingPointBarra.Active;
    var montoMaximo = dataBarra.MontoMaximo;
    var montoTipipoing = dataBarra.TippingPoint;
    var montoActual = mtoLogroBarra;
    var montoMinimo = dataBarra.MontoMinimo;
    var AvancePorcentaje = 0;

    if (TieneMontoMaximo()) { // se trata como tipinpoing
        if (!ConfiguradoRegalo && TippingPointBarraActive) {
            if (montoActual < montoTipipoing) AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoTipipoing);
            else AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
        }
        else {
            if (montoActual < montoMinimo) AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMinimo);
            else AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
        }        
    }
    else { // se trata como escala de descuento

        if (ConfiguradoRegalo == true) {
            if (montoActual < montoTipipoing) {
                AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMinimo);
            }
            else {

                var escala = 0;
                var lista = dataBarra.ListaEscalaDescuento;
                for (var i = 0; i < lista.length; i++) {
                    if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, escala);
                        break;
                    }
                    else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoActual);
                    }

                }


            }

        }
        else {
            //montoMinimo
            if (montoActual < montoTipipoing) {
                AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoTipipoing);
            }
            else {


                var escala = 0;
                var lista = dataBarra.ListaEscalaDescuento;
                for (var i = 0; i < lista.length; i++) {
                    if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        escala = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, escala);
                        break;
                    }
                    else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoActual);
                    }

                }


            }

        }

    }
    return AvancePorcentaje;
}

function CalculoPosicionMinimoMaximo() {

    var TippingPointBarraActive = dataBarra.TippingPointBarra.Active;
    var montoMaximo = dataBarra.MontoMaximo;
    var montoTipipoing = dataBarra.TippingPoint;
    var montoActual = mtoLogroBarra;
    var montoMinimo = dataBarra.MontoMinimo;

    if (dataBarra.TippingPointBarra.InMinimo != null) {
        ConfiguradoRegalo = dataBarra.TippingPointBarra.InMinimo;
    }

    var PosicionMontoMinimo = 0;
    if (TieneMontoMaximo()) { // se trata como tipinpoing
        if (ConfiguradoRegalo == true) {
            if (montoActual < montoMinimo) {
                PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;
                PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('MontoMinimoBloque').style.display = 'block';
                document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('MontoMinimoBloque').style.left = "";
                document.getElementById('MontoMinimoBloque').style.right = '-11px';

                document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";
                document.getElementById('hrefIconoRegalo').style.left = "";
                document.getElementById('hrefIconoRegalo').style.right = '-11px';

                document.getElementById('divtippingPoint').style.left = "";

                document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                document.getElementById('lineaPosicionRegalo').style.right = "";
                document.getElementById('lineaPosicionRegalo').style.display = 'block';

                document.getElementById('MontoMaximoBloque').style.display = "none";


            }
            else {

                PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                PosicionMontoTipipoing = montoMinimo * 100 / montoMaximo;

                document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('MontoMinimoBloque').style.right = '';
                document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                document.getElementById('MontoMinimoBloque').style.display = 'block';

                document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipipoing - 3) + '%';
                document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipipoing) + '%';
                document.getElementById('lineaPosicionRegalo').style.display = 'block';

                document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";
                document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                document.getElementById('MontoMaximoBloque').style.right = "-14px";
                document.getElementById('MontoMaximoBloque').style.display = "block";

                document.getElementById('divtippingPoint').style.display = 'none';
                document.getElementById('lineaPosicionRegalo').style.display = 'none';

            }
        }
        else {
            if (TippingPointBarraActive) {
                if (montoActual < montoTipipoing) {
                    PosicionMontoMinimo = montoMinimo * 100 / montoTipipoing;
                    PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                    document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';

                    document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";
                    document.getElementById('hrefIconoRegalo').style.left = "";
                    document.getElementById('hrefIconoRegalo').style.right = '-11px';

                    document.getElementById('divtippingPoint').style.left = "";

                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                    document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                    document.getElementById('lineaPosicionRegalo').style.right = "";
                    document.getElementById('lineaPosicionRegalo').style.display = 'block';
                    document.getElementById('MontoMaximoBloque').style.display = "none";


                }
                else {

                    PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                    PosicionMontoTipinpoing = montoTipipoing * 100 / montoMaximo;

                    document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                    document.getElementById('MontoMinimoBloque').style.right = '';
                    document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';


                    document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipinpoing - 3) + '%';
                    document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                    document.getElementById('lineaPosicionRegalo').style.display = 'block';

                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";
                    document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                    document.getElementById('MontoMaximoBloque').style.right = "-14px";
                    document.getElementById('MontoMaximoBloque').style.display = "block";

                    document.getElementById('divtippingPoint').style.left = "-20px";

                }
            }
            else {
                if (ConfiguradoRegalo == true) {

                    if (montoActual < montoMinimo) {

                        var PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;

                        document.getElementById('MontoMinimoBloque').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                        document.getElementById('MontoMinimoBloque').style.right = '-13px';

                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoMinimo - 4) + '%';
                        document.getElementById('hrefIconoRegalo').style.display = 'block';
                        document.getElementById('hrefIconoRegalo').className = "icono_regalo regalo_tippingPointInicio text-center";

                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                    }
                    else {

                        var PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                        var PosicionMontoTipipoing = montoTipipoing * 100 / montoMaximo;

                        document.getElementById('hrefIconoRegalo').className = document.getElementById('hrefIconoRegalo').className.replace('regalo_tippingPointInicio', 'regalo_tippingPoint');

                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';


                        document.getElementById('MontoMinimoBloque').style.right = '';
                        document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                        document.getElementById('MontoMinimoBloque').style.display = 'block';


                        document.getElementById('hrefIconoRegalo').style.display = 'block';
                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoMinimo - 4) + '%';
                        document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoMinimo) + '%';

                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                        document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";
                        document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                        document.getElementById('MontoMaximoBloque').style.right = "-14px";
                        document.getElementById('MontoMaximoBloque').style.display = "block";

                    }

                }
                else {
                    if (montoActual < montoMinimo) {
                        var PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;

                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('MontoMinimoBloque').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                        document.getElementById('MontoMinimoBloque').style.left = '';
                        document.getElementById('MontoMinimoBloque').style.right = '-13px';
                        document.getElementById('MontoMaximoBloque').style.display = 'none';


                    }
                    else {


                        PosicionMontoMinimo = montoMinimo * 100 / montoMaximo;
                        PosicionMontoTipipoing = montoTipipoing * 100 / montoMaximo;

                        document.getElementById('MontoMinimoBloque').style.right = '';
                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                        document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                        document.getElementById('MontoMinimoBloque').style.display = 'block';

                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                        document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";
                        document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                        document.getElementById('MontoMaximoBloque').style.right = "-14px";
                        document.getElementById('MontoMaximoBloque').style.display = "block";


                    }
                }
            }
        }

    }
    else { // se trata como escala de descuento
        if (ConfiguradoRegalo == true) {
            if (montoActual < montoTipipoing) {

                PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;

                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('MontoMinimoBloque').style.display = 'block';
                document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('MontoMinimoBloque').style.left = '';
                document.getElementById('MontoMinimoBloque').style.right = '-13px';

                document.getElementById('hrefIconoRegalo').style.left = "";
                document.getElementById('hrefIconoRegalo').style.display = 'block';
                document.getElementById('hrefIconoRegalo').style.right = '-12px';


                document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoMinimo) + '%';
                document.getElementById('lineaPosicionRegalo').style.right = "";
                document.getElementById('MontoMaximoBloque').style.display = "none";


            }
            else {
                document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                document.getElementById('MontoMinimoBloque').style.display = 'block';

                document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                document.getElementById('lineaPosicionMontoMaximo').style.left = "";
                document.getElementById('MontoMaximoBloque').style.display = "block";


                var escala = 0;
                var lista = dataBarra.ListaEscalaDescuento;
                for (var i = 0; i < lista.length; i++) {
                    if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                        escala = dataBarra.ListaEscalaDescuento[i].PorDescuento;
                        PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        document.getElementById('MontoMinimoBloque').style.right = "";
                        document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 8) + '%';
                        document.getElementById('MontoMinimoBloque').style.display = 'block';

                        document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                        document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                        document.getElementById('MontoMaximoBloque').innerHTML = escala + "%  DSCTO";
                        document.getElementById('MontoMaximoBloque').style.top = "5px";
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoMinimo - 4) + '%';
                        document.getElementById('hrefIconoRegalo').style.display = 'block';

                        break;
                    }
                    else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                        document.getElementById('MontoMaximoBloque').innerHTML = "";
                    }

                }


                document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";
                document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                document.getElementById('MontoMaximoBloque').style.right = "-14px";
                document.getElementById('MontoMaximoBloque').style.display = "block";
                if (montoActual >= dataBarra.ListaEscalaDescuento[3].MontoDesde) {
                    document.getElementById('MontoMaximoBloque').style.display = "none";
                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                }


            }
        }
        else {

            if (montoTipipoing != 0) {

                if (montoActual < montoTipipoing) {

                    PosicionMontoMinimo = montoMinimo * 100 / montoTipipoing;
                    PosicionMontoTipinpoing = montoTipipoing * 100 / montoTipipoing;

                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                    document.getElementById('MontoMinimoBloque').style.right = '';
                    document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 5) + '%';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';

                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                    document.getElementById('MontoMaximoBloque').style.display = 'none';


                    document.getElementById('hrefIconoRegalo').style.left = "";
                    document.getElementById('hrefIconoRegalo').style.right = '-11px';

                    document.getElementById('lineaPosicionRegalo').style.left = "";
                    document.getElementById('lineaPosicionRegalo').style.right = "0px";

                    document.getElementById('lineaPosicionRegalo').style.display = 'block';

                }
                else {


                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';

                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "";
                    document.getElementById('MontoMaximoBloque').style.display = "block";

                    var escala = 0;
                    var lista = dataBarra.ListaEscalaDescuento;
                    for (var i = 0; i < lista.length; i++) {
                        if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {
                            escala = dataBarra.ListaEscalaDescuento[i].PorDescuento;
                            PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            PosicionMontoTipinpoing = montoTipipoing * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;

                            document.getElementById('MontoMinimoBloque').style.right = "";
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 5) + '%';
                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                            document.getElementById('MontoMaximoBloque').innerHTML = escala + "%  DSCTO";
                            document.getElementById('MontoMaximoBloque').style.top = "5px";
                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                            document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                            document.getElementById('lineaPosicionRegalo').style.display = 'block';


                            document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipinpoing - 4) + '%';
                            document.getElementById('hrefIconoRegalo').style.display = 'block';


                            if (montoActual > dataBarra.ListaEscalaDescuento[1].MontoDesde) {
                                document.getElementById('MontoMinimoBloque').style.display = 'none';
                                document.getElementById('lineaPosicionMontoMinimo').style.display = 'None';
                            }

                            break;
                        }
                        else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                            PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            PosicionMontoTipinpoing = montoTipipoing * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;

                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 5) + '%';

                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                            document.getElementById('MontoMaximoBloque').innerHTML = "";

                            if (montoActual > dataBarra.ListaEscalaDescuento[1].MontoDesde) {
                                document.getElementById('MontoMinimoBloque').style.display = 'none';
                                document.getElementById('lineaPosicionMontoMinimo').style.display = 'None';
                            }


                        }
                    }

                    if (montoActual > dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde) {
                        PosicionMontoTipinpoing = montoTipipoing * 100 / montoActual;
                        document.getElementById('hrefIconoRegalo').style.left = (PosicionMontoTipinpoing - 3) + '%';
                        document.getElementById('lineaPosicionRegalo').style.left = (PosicionMontoTipinpoing) + '%';
                        document.getElementById('lineaPosicionRegalo').style.display = 'block';
                    }


                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";
                    document.getElementById('lineaPosicionMontoMaximo').style.right = "";
                    document.getElementById('MontoMaximoBloque').style.right = "-14px";
                    document.getElementById('MontoMaximoBloque').style.display = "block";


                    if (montoActual >= dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde) {
                        document.getElementById('MontoMaximoBloque').style.display = "none";
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                    }
                }

            }
            else {
                if (montoActual < montoMinimo) {
                    PosicionMontoMinimo = montoMinimo * 100 / montoMinimo;
                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                    document.getElementById('MontoMinimoBloque').style.left = '';
                    document.getElementById('MontoMinimoBloque').style.right = '-11px';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                    document.getElementById('MontoMaximoBloque').style.display = 'none';
                    document.getElementById('hrefIconoRegalo').style.display = 'None';
                    document.getElementById('lineaPosicionRegalo').style.display = 'None';
                }
                else {


                    document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                    document.getElementById('MontoMinimoBloque').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "";
                    document.getElementById('MontoMaximoBloque').style.display = "block";


                    var escala = 0;
                    var lista = dataBarra.ListaEscalaDescuento;
                    for (var i = 0; i < lista.length; i++) {
                        if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                            escala = dataBarra.ListaEscalaDescuento[i].PorDescuento;
                            PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;

                            document.getElementById('MontoMinimoBloque').style.right = "";
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 9) + '%';
                            document.getElementById('lineaPosicionMontoMinimo').style.display = 'block';
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';

                            document.getElementById('MontoMaximoBloque').innerHTML = escala + "%" + '<br />' + "DSCTO";
                            document.getElementById('MontoMaximoBloque').style.top = "5px";
                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'block';

                            document.getElementById('lineaPosicionRegalo').style.display = 'None';
                            document.getElementById('hrefIconoRegalo').style.display = 'None';

                            break;
                        }
                        else if (montoActual > dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                            PosicionMontoMinimo = montoMinimo * 100 / dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            document.getElementById('lineaPosicionMontoMinimo').style.left = (PosicionMontoMinimo) + '%';
                            document.getElementById('MontoMinimoBloque').style.left = (PosicionMontoMinimo - 9) + '%';

                            document.getElementById('lineaPosicionMontoMaximo').style.display = 'None';
                            document.getElementById('MontoMaximoBloque').innerHTML = "";



                        }
                    }


                    document.getElementById('lineaPosicionMontoMaximo').style.display = 'inline-block';
                    document.getElementById('lineaPosicionMontoMaximo').style.left = "100%";

                    document.getElementById('MontoMaximoBloque').style.right = "-14px";
                    document.getElementById('MontoMaximoBloque').style.display = "block";


                    if (montoActual >= dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde) {
                        document.getElementById('MontoMaximoBloque').style.display = "none";
                        document.getElementById('lineaPosicionMontoMaximo').style.display = 'none';
                    }

                }

            }

        }

    }

}

function CalculoLlenadoBarraDestokp() {
    var montoMaximo = dataBarra.MontoMaximo;
    var montoActual = mtoLogroBarra;
    var AvancePorcentaje = 0;


    if (TieneMontoMaximo()) {
        if (montoActual <= montoMaximo) {
            AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
        }
        else
            AvancePorcentaje = '100%';
    }
    else {
        montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde;
        if (montoActual <= montoMaximo) {

            montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde;
            AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);

        }
        else
            AvancePorcentaje = '100%';

    }

    return AvancePorcentaje;
}

function CalculoLlenadoBarraEspacioLimiteDestokp() {


    if (TieneMontoMaximo()) {
        var montoMaximo = dataBarra.MontoMaximo;
        var montoActual = mtoLogroBarra;

        if (montoActual <= montoMaximo) {
            AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
        }
        else
            AvancePorcentaje = '100%';


    }
    else {
        var montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde;
        var montoActual = mtoLogroBarra;
        var AvancePorcentaje;

        for (var i = 0; i < dataBarra.ListaEscalaDescuento.length; i++) {

            if (montoActual < dataBarra.ListaEscalaDescuento[i].MontoDesde) {

                var montoMaximo1 = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                AvancePorcentaje = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                break;
            }

        }


    }

    return AvancePorcentaje;
}


function CalculoPosicionMinimoMaximoDestokp() {
    var TippingPointBarraActive = dataBarra.TippingPointBarra.Active;
    var montoMaximo = dataBarra.MontoMaximo;
    var montoTipipoing = dataBarra.TippingPoint;
    var montoMinimo = dataBarra.MontoMinimo;
    var showTintineo;
    var AvancePorcentajeP1;

    if (TieneMontoMaximo()) { // se trata como tipinpoing
        if (ConfiguradoRegalo == true) {
            var AvancePorcentaje0 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
            document.getElementById('barra_0').style.left = AvancePorcentaje0;

            var AvancePorcentajeP0 = (AvancePorcentaje0.substring(0, AvancePorcentaje0.length - 1) * 1 - 7) + '%';
            document.getElementById('punto_0').style.left = AvancePorcentajeP0;

            var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
            if (document.getElementById('barra_1') != null) document.getElementById('barra_1').style.left = AvancePorcentaje1;

            if (document.getElementById('divBarra').style.width.substring(0, document.getElementById('divBarra').style.width.length - 2) * 1 > 1000) {
                AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 3.5) + '%';
            }
            else {
                AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 5) + '%';
            }
            document.getElementById('punto_1').style.left = AvancePorcentajeP1;
            document.getElementById('punto_1').firstChild.firstChild.style = "width:90px;position: absolute;";
            document.getElementById('punto_2').style.left = '94%';
            document.getElementById('barra_2').style.left = '99.9%';

        }
        else {
            if (TippingPointBarraActive) {
                var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
                document.getElementById('barra_0').style.left = AvancePorcentaje1;

                AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%';
                document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                var AvancePorcentaje2 = CalculoPorcentajeAvance(montoTipipoing, montoMaximo);
                if (document.getElementById('barra_1') != null) document.getElementById('barra_1').style.left = AvancePorcentaje2;

                var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 6) + '%';
                document.getElementById('punto_1').style.left = AvancePorcentajeP2;
                document.getElementById('punto_2').style.left = '94%';
                document.getElementById('barra_2').style.left = '99.9%';
            }
            else {
                var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMinimo, montoMaximo);
                document.getElementById('barra_0').style.left = AvancePorcentaje1;

                AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%';
                document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                document.getElementById('punto_1').style.left = '94%';
                document.getElementById('barra_1').style.left = '99.9%';
            }
        }
    }
    else { // se trata como escala de descuento
        if (ConfiguradoRegalo == true) {

            montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde

            var AvancePorcentajeTippingPoint = CalculoPorcentajeAvance(montoTipipoing, montoMaximo);

            var htmlTipinpoing = '';
            var MostrarMonto = 'none';
            if (dataBarra.TippingPointBarra.ActiveMonto == true) MostrarMonto = 'block';

            showTintineo = dataBarra.TippingPointBarra.ActivePremioElectivo && tpElectivos.hasPremios && tpElectivos.premioSelected == null;
            if (showTintineo) {
                if (esPedidoReservado) {
                    htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentajeTippingPoint + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" style="position: relative; left: -44px;"></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + ';position: relative;left: -47px;">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="display: block;left: -8px;" ><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                } else {
                    htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentajeTippingPoint + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();" style="position: relative; left: -44px;"></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + ';position: relative;left: -47px;">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="display: block;left: -8px;" ><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                }


            } else {
                if (esPedidoReservado) {
                    htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentajeTippingPoint + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;"  style="position: relative; left: -44px;"></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + ';position: relative;left: -47px;">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="left: -8px;"><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                } else {
                    htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentajeTippingPoint + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();" style="position: relative; left: -44px;"></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + ';position: relative;left: -47px;">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="left: -8px;"><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                }

            }

            document.getElementById('divBarraLimite').innerHTML = document.getElementById('divBarraLimite').innerHTML + htmlTipinpoing;

            montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde;


            var limite = 0;
            if (IsoPais == 'CO') {

                if (document.getElementById('hdEsConsultoraOficina').value == 'True') {
                    limite = dataBarra.ListaEscalaDescuento.length;

                    for (var j = 0; j < limite; j++) {

                        if (j == 0) {
                            var montoMaximo1 = dataBarra.ListaEscalaDescuento[j].MontoDesde;
                            var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                            document.getElementById('barra_0').style.left = AvancePorcentaje1;

                            AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%';
                            document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                        } else if (j == 1) {

                            var montoMaximo2 = dataBarra.ListaEscalaDescuento[1].MontoDesde;
                            var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                            document.getElementById('barra_1').style.left = AvancePorcentaje2;

                            var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 8) + '%';
                            document.getElementById('punto_1').style.left = AvancePorcentajeP2;
                        }
                        else {
                            var montoMaximo3 = dataBarra.ListaEscalaDescuento[j].MontoDesde;
                            var AvancePorcentaje3 = CalculoPorcentajeAvance(montoMaximo3, montoMaximo);
                            document.getElementById('barra_' + j.toString()).style.left = AvancePorcentaje3;


                            var AvancePorcentajeP3 = (AvancePorcentaje3.substring(0, AvancePorcentaje3.length - 1) * 1 - 5) + '%';
                            document.getElementById('punto_' + j.toString()).style.left = AvancePorcentajeP3;

                        }


                    }

                } else {

                    limite = dataBarra.ListaEscalaDescuento.length - 1;
                    for (var j = 0; j < limite; j++) {

                        if (j == 0) {
                            var montoMaximo1 = dataBarra.ListaEscalaDescuento[j + 1].MontoDesde;
                            var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                            document.getElementById('barra_0').style.left = AvancePorcentaje1;

                            AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%';
                            document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                        } else if (j == 1) {

                            var montoMaximo2 = dataBarra.ListaEscalaDescuento[1 + 1].MontoDesde;
                            var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                            document.getElementById('barra_1').style.left = AvancePorcentaje2;

                            var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 8) + '%';
                            document.getElementById('punto_1').style.left = AvancePorcentajeP2;
                        }
                        else {
                            var montoMaximo3 = dataBarra.ListaEscalaDescuento[j + 1].MontoDesde;
                            var AvancePorcentaje3 = CalculoPorcentajeAvance(montoMaximo3, montoMaximo);
                            document.getElementById('barra_' + j.toString()).style.left = AvancePorcentaje3;


                            var AvancePorcentajeP3 = (AvancePorcentaje3.substring(0, AvancePorcentaje3.length - 1) * 1 - 5) + '%';
                            document.getElementById('punto_' + j.toString()).style.left = AvancePorcentajeP3;

                        }
                    }
                }

            }
            else {

                for (var j = 0; j < dataBarra.ListaEscalaDescuento.length; j++) {

                    if (j == 0) {
                        var montoMaximo1 = dataBarra.ListaEscalaDescuento[j].MontoDesde;
                        var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                        document.getElementById('barra_0').style.left = AvancePorcentaje1;

                        AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%';
                        document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                    } else if (j == 1) {

                        var montoMaximo2 = dataBarra.ListaEscalaDescuento[1].MontoDesde;
                        var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                        document.getElementById('barra_1').style.left = AvancePorcentaje2;

                        var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 8) + '%';
                        document.getElementById('punto_1').style.left = AvancePorcentajeP2;
                    }
                    else {
                        var montoMaximo3 = dataBarra.ListaEscalaDescuento[j].MontoDesde;
                        var AvancePorcentaje3 = CalculoPorcentajeAvance(montoMaximo3, montoMaximo);
                        document.getElementById('barra_' + j.toString()).style.left = AvancePorcentaje3;


                        var AvancePorcentajeP3 = (AvancePorcentaje3.substring(0, AvancePorcentaje3.length - 1) * 1 - 5) + '%';
                        document.getElementById('punto_' + j.toString()).style.left = AvancePorcentajeP3;

                    }


                }

            }

        }
        else {

            montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde;

            var limite = 0;
            if (IsoPais == 'CO') {

                if (document.getElementById('hdEsConsultoraOficina').value == 'True') {
                    limite = dataBarra.ListaEscalaDescuento.length;


                    for (var i = 0; i < limite; i++) {

                        if (i == 0) {
                            var montoMaximo1 = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                            document.getElementById('barra_0').style.left = AvancePorcentaje1;

                            AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 7) + '%';
                            document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                        } else {
                            var montoMaximo2 = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                            var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                            document.getElementById('barra_' + i.toString()).style.left = AvancePorcentaje2;

                            var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 5) + '%';
                            document.getElementById('punto_' + i.toString()).style.left = AvancePorcentajeP2;

                        }


                    }

                }
                else {
                    limite = dataBarra.ListaEscalaDescuento.length - 1;

                    var mMinimo = dataBarra.ListaEscalaDescuento[0].MontoDesde;
                    var adjuste = 1;
                    if (mMinimo <= dataBarra.ListaEscalaDescuento[1].MontoDesde && mMinimo != 0) {
                        adjuste = 0;
                        limite = dataBarra.ListaEscalaDescuento.length;
                    }

                    for (var i = 0; i < limite; i++) {

                        if (i == 0) {
                            var montoMaximo1 = dataBarra.ListaEscalaDescuento[i + adjuste].MontoDesde;
                            var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                            document.getElementById('barra_0').style.left = AvancePorcentaje1;

                            AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 10) + '%';
                            document.getElementById('punto_0').style.left = AvancePorcentajeP1;

                        } else {
                            var montoMaximo2 = dataBarra.ListaEscalaDescuento[i + adjuste].MontoDesde;
                            var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                            document.getElementById('barra_' + i.toString()).style.left = AvancePorcentaje2;

                            var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 5) + '%';
                            document.getElementById('punto_' + i.toString()).style.left = AvancePorcentajeP2;

                        }

                        if (limite >= 6 && montoMaximo1 == 185000) {
                            document.getElementById('punto_0').style.left = '2%';
                            document.getElementById('punto_1').style.left = '15%';
                            document.getElementById('punto_2').style.left = '21.8%';
                            document.getElementById('punto_5').style.left = '94%';
                            document.getElementById('punto_0').getElementsByTagName('div')[2].style.marginLeft = '45%';
                            document.getElementById('punto_0').getElementsByTagName('div')[3].style.marginLeft = '15%';


                        } else {
                            if (limite >= 6 && montoMaximo1 == 195000) {
                                // document.getElementById('divBarraEspacioLimite').style.width = '16%';
                                document.getElementById('barra_0').style.left = '20%';
                                document.getElementById('punto_0').style.left = '9%';
                                document.getElementById('punto_1').style.left = '20%';
                                document.getElementById('punto_2').style.left = '21.8%';
                                document.getElementById('punto_0').getElementsByTagName('div')[2].style.marginLeft = '45%';
                                document.getElementById('punto_0').getElementsByTagName('div')[3].style.marginLeft = '15%';
                            }
                        }

                    }


                }

            }
            else {
                limite = dataBarra.ListaEscalaDescuento.length;

                for (var i = 0; i < limite; i++) {

                    if (i == 0) {
                        var montoMaximo1 = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        var AvancePorcentaje1 = CalculoPorcentajeAvance(montoMaximo1, montoMaximo);
                        $('#barra_0').css('left', AvancePorcentaje1);

                        AvancePorcentajeP1 = (AvancePorcentaje1.substring(0, AvancePorcentaje1.length - 1) * 1 - 9) + '%';
                        $('#punto_0').css('left', AvancePorcentajeP1);

                    } else {
                        var montoMaximo2 = dataBarra.ListaEscalaDescuento[i].MontoDesde;
                        var AvancePorcentaje2 = CalculoPorcentajeAvance(montoMaximo2, montoMaximo);
                        if (IsoPais == 'CL' && dataBarra.ListaEscalaDescuento.length >= 5) {

                            avance = (dataBarra.ListaEscalaDescuento[i].MontoDesde - dataBarra.ListaEscalaDescuento[i - 1].MontoDesde);
                            if (avance <= 5000) {

                                document.getElementById('punto_0').style.left = (AvancePorcentajeP1.substring(0, AvancePorcentajeP1.length - 1) * 1 + 2.2) + '%';
                                if (document.getElementById('barra_' + i.toString())) document.getElementById('barra_' + i.toString()).style.left =
                                    (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 + 0.2) + '%';

                            } else
                                if (document.getElementById('barra_' + i.toString())) document.getElementById('barra_' + i.toString()).style.left = AvancePorcentaje2;
                            var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 5) + '%'
                            if (document.getElementById('punto_' + i.toString())) document.getElementById('punto_' + i.toString()).style.left = AvancePorcentajeP2;

                        } else {

                            if (document.getElementById('barra_' + i.toString())) document.getElementById('barra_' + i.toString()).style.left = AvancePorcentaje2;
                            var AvancePorcentajeP2 = (AvancePorcentaje2.substring(0, AvancePorcentaje2.length - 1) * 1 - 5) + '%';
                            if (document.getElementById('punto_' + i.toString())) document.getElementById('punto_' + i.toString()).style.left = AvancePorcentajeP2;

                        }

                    }
                }

            }

            if (montoTipipoing != 0) {

                var htmlTipinpoing = '';
                var MostrarMonto = 'none';
                if (dataBarra.TippingPointBarra.ActiveMonto == true) MostrarMonto = 'block';

                showTintineo = dataBarra.TippingPointBarra.ActivePremioElectivo && tpElectivos.hasPremios && tpElectivos.premioSelected == null;

                AvancePorcentaje = CalculoPorcentajeAvance(montoTipipoing, montoMaximo);

                if (showTintineo) {

                    if (esPedidoReservado) {
                        htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentaje + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;"  style="position: relative; left: -44px;"></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + '; position: relative;left: -47px;"  >' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="display: block; left: -8px; "><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                    } else {
                        htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + '" data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentaje + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();" style="position: relative; left: -44px;"></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + '; position: relative;left: -47px;"  >' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="display: block; left: -8px; "><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                    }

                } else {
                    if (esPedidoReservado) {
                        htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + ' data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentaje + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" style="position: relative; left: -44px;" ></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + '; position: relative;left: -47px;">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="left: -8px;" ><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                    } else {
                        htmlTipinpoing = '<div id="punto_' + dataBarra.ListaEscalaDescuento.length + ' data-punto="0" style="float: left;top:-52px; z-index: 200;left:' + AvancePorcentaje + '" class="EscalaDescuento"><div class="monto_minimo_barra"><div style="width:90px;position: relative;" data-texto=""><div class=""><a class="tippingPoint" href="javascript:;" onclick="javascript: cargarPopupEleccionRegalo();" style="position: relative; left: -44px;" ></a><div class="monto_meta_tippingPoint" style="display:' + MostrarMonto + '; position: relative;left: -47px;">' + variablesPortal.SimboloMoneda + ' ' + dataBarra.TippingPointStr + '</div></div><div class="contenedor_circulos microEfecto_regaloPendienteEleccion" style="left: -8px;" ><div class="circulo-1 iniciarTransicion"></div><div class="circulo-2 iniciarTransicion"></div><div class="circulo-3 iniciarTransicion"></div></div></div></div></div>';
                    }

                }

                document.getElementById('divBarraLimite').innerHTML = document.getElementById('divBarraLimite').innerHTML + htmlTipinpoing;

            }
        }

        if (IsoPais == 'CO') {


            var adjuste = 1;
            if (mMinimo <= dataBarra.ListaEscalaDescuento[1].MontoDesde && mMinimo != 0) {
                adjuste = 0;
            }

            //aparicion de bandera
            if (dataBarra.ListaEscalaDescuento.length > 1) {
                if (mtoLogroBarra > dataBarra.ListaEscalaDescuento[adjuste].MontoDesde * 1 && mtoLogroBarra < dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde * 1) {
                    document.getElementsByClassName('bandera_marcador')[0].style.display = 'block';
                }
                else
                    document.getElementsByClassName('bandera_marcador')[0].style.display = 'none';
            }



        }
        else {
            //aparicion de bandera
            if (dataBarra.ListaEscalaDescuento.length > 1) {
                if (mtoLogroBarra > dataBarra.ListaEscalaDescuento[0].MontoDesde * 1 && mtoLogroBarra < dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde * 1) {

                    $(".barra_mensaje_meta_pedido").css('margin-bottom', '56px');
                    $('.bandera_marcador').show();
                } else {
                    $('.bandera_marcador').hide();
                }
            }
        }
        ReordenarMontosBarra();
    }

}

function CalculoPosicionMensajeDestokp() {
    var montoActual = mtoLogroBarra;
    var montoMaximo = dataBarra.MontoMaximo;

    var AvancePorcentaje;
    if (TieneMontoMaximo()) {
        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
    }
    else {
        montoMaximo = dataBarra.ListaEscalaDescuento[dataBarra.ListaEscalaDescuento.length - 1].MontoDesde;
        AvancePorcentaje = CalculoPorcentajeAvance(montoActual, montoMaximo);
    }

    var divBarraMensaje = document.getElementById('divBarraMensajeLogrado');
    var alignRight = AvancePorcentaje.substring(0, AvancePorcentaje.length - 1) * 1 > 75;

    if (alignRight) {
        divBarraMensaje.firstChild.nextSibling.style.float = '';
        divBarraMensaje.style.display = 'flex';
        divBarraMensaje.style.justifyContent = 'flex-end';
        divBarraMensaje.style.left = '';

        return;
    }

    divBarraMensaje.firstChild.nextSibling.style.float = 'left';
    divBarraMensaje.style.display = 'block';
    divBarraMensaje.style.justifyContent = '';
    divBarraMensaje.style.left = AvancePorcentaje;
}

function TieneMontoMaximo() {
    return dataBarra.MontoMaximo != 0 &&
        dataBarra.MontoMaximo != "" &&
        dataBarra.MontoMaximo != null &&
        dataBarra.MontoMaximo * 1 <= 999999;
}

function CalculoPorcentajeAvance(montoActual, montoMaximo) {
    var AvancePorcentaje = (montoActual * 100) / montoMaximo;
    return (AvancePorcentaje) + '%';
}

function tryLoadPedidoDetalle() {
    if (typeof CargarPedido === "function") {
        CargarPedido();
    } else if (typeof CargarDetallePedido === "function") {
        CargarDetallePedido();
    }
}

function FixPorcentajes(barra) {
    var fixBarra = new Array();

    return fixBarra;
}

function AgregarPremio(premio) {

    /*HD-3710 - 2_3_Popup elige tu regalo - Click en botón cambiar -  Web - Mobile*/
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Carrito de Compras',
        'action': 'popupEleccionRegalo - Click Botón',
        'label': $(".btn_elegir_regalo").html() + ' - ' + premio.DescripcionResumen
    });

    AbrirLoad();
    var params = {
        CUV: $.trim(premio.CUV2),
        Cantidad: 1,
        PrecioUnidad: premio.Precio2,
        TipoEstrategiaID: premio.TipoEstrategiaID,
        MarcaID: premio.MarcaID,
        FlagNueva: $.trim(premio.FlagNueva),
        OrigenPedidoWeb: parseInt(PedidoEscogeRegaloCarrusel)
    };

    return InsertarPremio(params);
}

function InsertarPremio(model) {

    return jQuery.ajax({
        type: 'POST',
        url: baseUrl + "PedidoRegistro/PedidoAgregarProductoTransaction",
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(model),
        async: true,
        cache: false
    }).then(function (data) {
        CerrarLoad();

        if (!checkTimeout(data)) {
            return false;
        }

        if (data.success != true) {
            messageInfoError(data.message);
            return false;
        }

        tryLoadPedidoDetalle();

        return data;
    });
};

function ClosePopupRegaloElectivo(valor) {
    
    var valorCerrar = "icono_cerrar_popup_eleccion_regalo_programaNuevas";
    /*HD-3710 - 4_5_ Cerrar pop up elige tu regalo - Pop up regalos - Click Botón -- Web, Mobile */
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Carrito de Compras',
        'action': valor.className == valorCerrar ? valor.title : 'popupEleccionRegalo - Click Botón',
        'label': valor.className == valorCerrar ? 'popupEleccionRegalo' : valor.innerHTML
    });

    if (typeof dataAgregarOF !== 'undefined') dataAgregarOF = null;
    CerrarPopup('#popupEleccionRegalo');
    $('#popupEleccionRegalo').scrollTop(0);

    
        checkPopupEscala();

};

function ReordenarMontosBarra() {
    var barra = dataBarra.ListaEscalaDescuento;
    var barraFix = new Array();

    var monto = 0;
    if (IsoPais == 'CO') {
        monto = 1000;
        barraFix = FixPorcentajes(barra);
    }
    else if (IsoPais == 'CR')
        monto = 10000;
    else if (IsoPais == 'CL')
        monto = 40000;
    else if (IsoPais == 'PE')
        monto = 200;
    else
        monto = 100;

    var diferencia2 = 0;
    for (var i = barra.length - 1; i >= 1; i--) {

        if ((IsoPais == 'CO' && i == 0) || (IsoPais == 'CO' && document.getElementById('hdEsConsultoraOficina').value == 'False' && i == 1)) continue;

        var diferencia1 = (barra[i].MontoDesde - barra[i - 1].MontoDesde);
        if (i >= 2) {
            diferencia2 = (barra[i - 1].MontoDesde - barra[i - 2].MontoDesde);
        }
        else
            diferencia2 = 0;

        if (diferencia1 <= monto && (diferencia2 <= monto && diferencia2 != 0)) {

            if (IsoPais == 'CO') {
                if (document.getElementById('punto_' + i.toString()) != null) document.getElementById('punto_' + i.toString()).style.left = (document.getElementById('punto_' + i.toString()).style.left.substring(0, document.getElementById('punto_' + i.toString()).style.left.length - 1) * 1 + 2.5) + '%';
                if (document.getElementById('punto_' + (i - 1).toString()) != null) document.getElementById('punto_' + (i - 1).toString()).style.left = (document.getElementById('punto_' + (i - 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 1).toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 2).toString()) != null) document.getElementById('punto_' + (i - 2).toString()).style.left = (document.getElementById('punto_' + (i - 2).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 2).toString()).style.left.length - 1) * 1 - 3) + '%';
            }
            else if (IsoPais == 'CR') {
                if (document.getElementById('punto_' + i.toString()) != null) document.getElementById('punto_' + i.toString()).style.left = (document.getElementById('punto_' + i.toString()).style.left.substring(0, document.getElementById('punto_' + i.toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 1).toString()) != null) document.getElementById('punto_' + (i - 1).toString()).style.left = (document.getElementById('punto_' + (i - 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 1).toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 2).toString()) != null) document.getElementById('punto_' + (i - 2).toString()).style.left = (document.getElementById('punto_' + (i - 2).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 2).toString()).style.left.length - 1) * 1 - 3) + '%';

            }
            else if (IsoPais != 'CO' && IsoPais != 'CR') {//CHILE
                if (document.getElementById('punto_' + i.toString()) != null) document.getElementById('punto_' + i.toString()).style.left = (document.getElementById('punto_' + i.toString()).style.left.substring(0, document.getElementById('punto_' + i.toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 1).toString()) != null) document.getElementById('punto_' + (i - 1).toString()).style.left = (document.getElementById('punto_' + (i - 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 1).toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 2).toString()) != null) document.getElementById('punto_' + (i - 2).toString()).style.left = (document.getElementById('punto_' + (i - 2).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 2).toString()).style.left.length - 1) * 1 - 2.5) + '%';
                if (document.getElementById('punto_' + (i + 1).toString()) != null) document.getElementById('punto_' + (i + 1).toString()).style.left = (document.getElementById('punto_' + (i + 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i + 1).toString()).style.left.length - 1) * 1 + 2) + '%';

            }

            for (var x = 0; x < barra.length; x++) {
                if (IsoPais == 'CO') {
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.style.fontSize = '10px';
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.nextSibling.style.fontSize = '10px';

                }
                else if (IsoPais == 'CR') {

                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.style.fontSize = '9px';
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.nextSibling.style.fontSize = '9px';
                }
                else if (IsoPais == 'CL' || IsoPais == 'BO') {

                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.style.fontSize = '9px';
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.nextSibling.style.fontSize = '9px';
                }

                else {

                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.style.fontSize = '10px';
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.nextSibling.style.fontSize = '10px';
                }
            }

        }
        else if (diferencia1 <= monto) {

            if (IsoPais == 'CO') {
                if (document.getElementById('punto_' + i.toString()) != null) document.getElementById('punto_' + i.toString()).style.left = (document.getElementById('punto_' + i.toString()).style.left.substring(0, document.getElementById('punto_' + i.toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 1).toString()) != null) document.getElementById('punto_' + (i - 1).toString()).style.left = (document.getElementById('punto_' + (i - 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 1).toString()).style.left.length - 1) * 1 - 3.5) + '%';
                if (document.getElementById('punto_' + (i + 1).toString()) != null) document.getElementById('punto_' + (i + 1).toString()).style.left = (document.getElementById('punto_' + (i + 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i + 1).toString()).style.left.length - 1) * 1 + 1) + '%';

            }
            else if (IsoPais == 'CR') {
                if (document.getElementById('punto_' + i.toString()) != null) document.getElementById('punto_' + i.toString()).style.left = (document.getElementById('punto_' + i.toString()).style.left.substring(0, document.getElementById('punto_' + i.toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 1).toString()) != null) document.getElementById('punto_' + (i - 1).toString()).style.left = (document.getElementById('punto_' + (i - 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 1).toString()).style.left.length - 1) * 1 - 3.7) + '%';
                if (document.getElementById('punto_' + (i + 1).toString()) != null) document.getElementById('punto_' + (i + 1).toString()).style.left = (document.getElementById('punto_' + (i + 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i + 1).toString()).style.left.length - 1) * 1 + 1) + '%';
            }
            else if (IsoPais != 'CO' && IsoPais != 'CR') {
                if (document.getElementById('punto_' + i.toString()) != null) document.getElementById('punto_' + i.toString()).style.left = (document.getElementById('punto_' + i.toString()).style.left.substring(0, document.getElementById('punto_' + i.toString()).style.left.length - 1) * 1 + 2) + '%';
                if (document.getElementById('punto_' + (i - 1).toString()) != null) document.getElementById('punto_' + (i - 1).toString()).style.left = (document.getElementById('punto_' + (i - 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i - 1).toString()).style.left.length - 1) * 1 - 2) + '%';
                if (document.getElementById('punto_' + (i + 2).toString()) != null) document.getElementById('punto_' + (i + 2).toString()).style.left = (document.getElementById('punto_' + (i + 2).toString()).style.left.substring(0, document.getElementById('punto_' + (i + 2).toString()).style.left.length - 1) * 1 - 1.5) + '%';
                if (document.getElementById('punto_' + (i + 1).toString()) != null) document.getElementById('punto_' + (i + 1).toString()).style.left = (document.getElementById('punto_' + (i + 1).toString()).style.left.substring(0, document.getElementById('punto_' + (i + 1).toString()).style.left.length - 1) * 1 - 1) + '%';
            }

            for (var x = 0; x < barra.length; x++) {
                if (IsoPais == 'CO') {
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.style.fontSize = '10px';
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.nextSibling.style.fontSize = '10px';

                }
                else if (IsoPais == 'CR') {

                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.style.fontSize = '9px';
                    document.getElementById('punto_' + x.toString()).firstChild.firstChild.firstChild.nextSibling.style.fontSize = '9px';
                }
                else if (IsoPais != 'CO' && IsoPais != 'CR') {
                    var dvel = document.getElementById('punto_' + x.toString());
                    if (dvel) {
                        dvel.firstChild.firstChild.firstChild.style.fontSize = '10px';
                        dvel.firstChild.firstChild.firstChild.nextSibling.style.fontSize = '10px';
                    }
                }
            }

        }
    }


    if (barra.length >= 5) {

        for (var x = 0; x < document.getElementsByClassName('EscalaDescuento').length; x++) {

            document.getElementsByClassName('EscalaDescuento')[x].firstChild.firstChild.firstChild.style.fontSize = '9px';
            document.getElementsByClassName('EscalaDescuento')[x].firstChild.firstChild.firstChild.nextSibling.style.fontSize = '9px';

        }

    }
}

function buildMessages(premios) {
    var textPremios = {
        premioElegido: '¡YA ELEGISTE TU REGALO!',
        puedesElegirPremio: '¡Puedes elegir tu regalo del Programa de Nuevas ahora!',
        textElegido: 'REGALO ELEGIDO',
        textTienesRegalo: 'TIENES UN REGALO',
        textLlegasteRegalo: 'LLEGASTE A TU REGALO',
        textAlcanzasteRegalo: '¡Alcanzaste tu regalo!'
    };

    var textKitInicio = {
        premioElegido: '¡YA ELEGISTE TU PRODUCTO!',
        puedesElegirPremio: '¡Puedes elegir tu producto del Kit de Inicio!',
        textElegido: 'PRODUCTO ELEGIDO',
        textTienesRegalo: 'TIENES UN PRODUCTO DEL KIT DE INICIO',
        textLlegasteRegalo: 'LLEGASTE A TU PRODUCTO',
        textAlcanzasteRegalo: '¡Alcanzaste tu producto del Kit de Inicio!'
    };

    return isKitInicio(premios) ? textKitInicio : textPremios;
}

function isKitInicio(premios) {
    if (!premios) {
        return false;
    }

    for (var i = 0; i < premios.length; i++) {
        if (premios[i].Precio2 > 0) {
            return true;
        }
    }

    return false;
}