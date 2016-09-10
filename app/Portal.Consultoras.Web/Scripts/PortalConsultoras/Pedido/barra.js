var listaEscalaDescuento = listaEscalaDescuento || new Array();
var listaMensajeMeta = listaMensajeMeta || new Array();
var dataBarra = dataBarra || new Object();

function MostrarBarra(datax) {
    //$("#divBarra").hide();
    //return false;

    $("#divBarra #divLimite").html("");
    datax = datax || new Object();
    var data = datax.dataBarra || datax.DataBarra || dataBarra || new Object();
    dataBarra = data;

    dataBarra.ListaEscalaDescuento = dataBarra.ListaEscalaDescuento || new Array(); 
    if (dataBarra.ListaEscalaDescuento.length > 0) {
        listaEscalaDescuento = dataBarra.ListaEscalaDescuento;

        $.each(listaEscalaDescuento, function (i, item) {
            listaEscalaDescuento[i].MontoHasta = Math.ceil(item.MontoHasta);
            listaEscalaDescuento[i].MontoHastaStr = DecimalToStringFormat(Math.ceil(item.MontoHasta));
        });
    }

    dataBarra.ListaMensajeMeta = dataBarra.ListaMensajeMeta || new Array();
    if (dataBarra.ListaMensajeMeta.length > 0) {
        listaMensajeMeta = dataBarra.ListaMensajeMeta;
    }

    ActualizarGanancia(dataBarra);

    var me = data.MontoEscala;
    var md = data.MontoDescuento;
    var mx = data.MontoMaximo;
    var mn = data.MontoMinimo;
    var tp = data.TippingPoint;
    var mt = data.TotalPedido;

    var salto = "<br>";
    var listaLimite = new Array();

    var widthTotal = $("#divListadoPedido").outerWidth();
    var wPrimer = 0;
    var vLogro = 0;
    var wMsgFin = 0;
    var wmin = 45; //parseInt(parseInt(widthTotal, 10) / 20, 10);

    if (!(mn == "0,00" || mn == "0.00" || mn == "0")) {
        wPrimer = wmin;
    }
    var textoPunto = '<div style="font-weight: bold;">{titulo}</div><div style="font-size: 11px;">{detalle}</div>';
    if (mx > 0) {
        vLogro = mt - md;

        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "M. mínimo").replace("{detalle}", vbSimbolo + " " + data.MontoMinimoStr),
            msgLimite: "!VAMOS, ADELANTE!",
            msgFalta: "Te faltan " + vbSimbolo + " {falta} para pasar pedido.",
            tipoMensaje: 'MontoMinimo',
            width: wPrimer,
            valor: data.MontoMinimo,
            valorStr: data.MontoMinimoStr
        });

        if (tp > 0) {
            listaLimite.push({
                nombre: "",
                msgLimite: "!VAMOS POR LA BONIFICACIÓN!",
                msgFalta: "Solo te faltan " + vbSimbolo + " {falta}.",
                tipoMensaje: 'TippingPoint',
                valor: data.TippingPoint,
                valorStr: data.TippingPointStr
            });
        }

        var dif = parseFloat(data.MontoMaximo - vLogro).toFixed(2);
        listaLimite.push({
            nombre: textoPunto.replace("{titulo}", "L. crédito").replace("{detalle}", vbSimbolo + " " + data.MontoMaximoStr),
            msgLimite: dif <= 0 ? "" : ("SOLO PUEDES AGREGAR " + vbSimbolo + " " + dif + " MÁS"),
            msgFalta: "Ya estas por llegar a tu tope de linea de crédito.",
            tipoMensaje: 'MontoMaximo',
            widthR: wmin,
            valor: data.MontoMaximo,
            valorStr: data.MontoMaximoStr
        });
    }
    else {
        if (mt < mn)
            vLogro = mt - md;
        else
            vLogro = me < mn ? mn : me;

        listaLimite = new Array();
        listaEscalaDescuento = listaEscalaDescuento || new Array();
        var listaEscala = new Array();
        $.each(listaEscalaDescuento, function (ind, monto) {
            if (mn < monto.MontoHasta) {
                listaEscala.push(monto);
            }
        });

        $.each(listaEscala, function (ind, monto) {
            var montox = ind == 0 ? monto : listaEscala[ind - 1];
            listaLimite.push({
                nombre: textoPunto
                    .replace("{titulo}", monto.PorDescuento + "% DSCTO")
                    .replace("{detalle}", (ind == 0 ? "M. mínimo: " : "") + vbSimbolo + " " + (ind == 0 ? data.MontoMinimoStr : montox.MontoHastaStr)),
                msgLimite: ind == 0 ? "!VAMOS, ADELANTE!" : ("¡YA LLEGAS AL " + monto.PorDescuento + "% DSCTO!"),
                msgFalta: ind == 0 ? "Te faltan " + vbSimbolo + " {falta} para pasar pedido." : ("Solo agrega " + vbSimbolo + " {falta}"),
                width: ind == 0 ? wPrimer : null,
                widthR: ind == listaEscala.length - 1 ? wmin : null,
                tipoMensaje: 'EscalaDescuento',
                valPor: monto.PorDescuento,
                valor: ind == 0 ? data.MontoMinimo : montox.MontoHasta,
                valorStr: ind == 0 ? data.MontoMinimoStr : montox.MontoHastaStr,
                tipo: ind == 0 ? 'min' : ind == listaEscala.length - 1 ? 'max' : 'int'
            });
        });

        if (listaLimite.length == 0 && mn > 0) {
            listaLimite.push({
                nombre: textoPunto.replace("{titulo}", "M. mínimo").replace("{detalle}", vbSimbolo + " " + data.MontoMinimoStr),
                msgLimite: "!VAMOS, ADELANTE!",
                msgFalta: "Te faltan " + vbSimbolo + " {falta} para pasar pedido.",
                tipoMensaje: 'MontoMinimo',
                width: wPrimer,
                valor: data.MontoMinimo,
                valorStr: data.MontoMinimoStr
            });
        }
    }

    // validar si hay algun limite
    listaLimite = listaLimite || new Array();
    if (listaLimite.length == 0) {
        $("#divBarra").hide();
        return false;
    }

    var indPuntoLimite = 0;
    // obtener el punto limite actual
    listaLimite = listaLimite || new Array();
    $.each(listaLimite, function (ind, limite) {
        if (ind > 0 ) {
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
    $("#divBarra #divBarraPosicion").css("width", wTotal);
    $("#divBarra").css("width", wTotal);

    // colocar los puntos limites
    var styleMin = 'style="margin-left: 6px;"';
    var htmlPunto = '<div id="punto_{punto}">'
                + '<div class="monto_minimo_barra">'
                    + '<div style="width:{wText}px;position: absolute;" data-texto>{texto}</div>'
                    + '<div class="linea_indicador_barra" {style}></div>'
                + '</div>'
            + '</div>';
    var htmlTippintPoint = '<div id="punto_{punto}">'
                + '<div class="monto_minimo_barra">'
                    + '<div style="width:{wText}px;position: absolute;" data-texto><div class="tippingPoint {estado}"></div></div>'
                    + '<div class="linea_indicador_barra"></div>'
                + '</div>'
            + '</div>';
    var htmlPuntoLimite = '<div id="punto_{punto}">'
                + '<div class="monto_minimo_barra">'
                    + '<div class="bandera_marcador" style="margin-top: -6px;"></div>'
                    + '<div style="margin-left: {marl}px;width: {wText}px;position: absolute;" data-texto>{texto}</div>'
                + '</div>'
            + '</div>';

    if (mx > 0)
        htmlPuntoLimite = htmlPunto;

    var wTotalPunto = 0;
    $("#divBarra #divBarraLimite").html("");
    $.each(listaLimite, function (ind, limite) {
        var htmlSet = indPuntoLimite == ind && ind > 0 ? vLogro < vLimite ? htmlPuntoLimite : htmlPunto : htmlPunto;
        htmlSet = ind == 1 && indPuntoLimite == 0 && mn == 0 ? htmlPuntoLimite : htmlSet;
        htmlSet = limite.tipoMensaje == 'TippingPoint' ? htmlTippintPoint : htmlSet;

        var wText = ind == 0 ? "130" : "90";
        var marl = indPuntoLimite == listaLimite.length - 1 ? "-80" : "21";
        var activo = limite.tipoMensaje == 'TippingPoint' && indPuntoLimite == 1 ? "activo" : "";
        var styleMinx = mn == 0 && ind == 0 ? styleMin : "";
        htmlSet = htmlSet
            .replace("{punto}", ind)
            .replace("{texto}", limite.nombre)
            .replace("{wText}", wText)
            .replace("{marl}", marl)
            .replace("{estado}", activo)
            .replace("{style}", styleMinx);

        var objH = $(htmlSet).css("float", 'left');
        $("#divBarra #divBarraLimite").append(objH);

        var wPunto = $("#punto_" + ind + " [data-texto]").width();
        wPunto += $("#punto_" + ind + " .bandera_marcador").width() || 0;
        if (indPuntoLimite == listaLimite.length - 1 && indPuntoLimite == ind) {
            if (vLogro < vLimite) {
                if (mx <= 0) {
                    wPunto = wmin;
                }
            }
        }

        $("#punto_" + ind).css("width", wPunto);
        if (ind == 0) {
            if (mn == 0) {
                $("#punto_" + ind + " .linea_indicador_barra").css("margin-left", "0px;");
            }
        }
        wTotalPunto += wPunto;

    });
    $("#divBarra #divBarraLimite").append("<div class='clear'></div>");

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

    // asignar espacio para el progreso
    var wAreaMover = widthTotal - wTotalPunto;
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
            $("#punto_" + indPuntoLimite).css("margin-left", wAreaMover);
        }
        else {
            $("#punto_" + indPuntoLimite).css("margin-right", wAreaMover);
        }
    }

    //if (mn == 0) {
    //    wAreaMover += $("#punto_" + 0).width();
    //}

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
    if (vLogro >= vLimite) {
        if (indPuntoLimite > 0 && mn > 0) {
            wPuntosAnterior += $("#punto_" + indPuntoLimite).width();
        }
    }

    var wLimite = wAreaMover + wPuntosAnterior; // hasta el borde inicial  del texto del limite
    var wLimiteAnterior = wPuntosAnterior;
    if (indPuntoLimite > 0) {
        if (vLogro >= vLimite) { // supero el ultimo limite
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

    // ancho de logrado
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

    //wLogro = wLimite == widthTotal ? vLogro > vLimite ? widthTotal - 20 : wLimite : wLogro;
    $("#divBarra #divBarraEspacioLimite").css("width", wLimite);
    $("#divBarra #divBarraEspacioLogrado").css("width", wLogro);

    //console.log(widthTotal, wTotalPunto, wAreaMover, wLimite, indPuntoLimite, vLogro, vLimite, wLimiteAnterior);

    // mensaje
    if (mn == 0 && vLogro == 0) {
        $("#divBarra #divBarraMensajeLogrado").hide();
        return false;
    }
    var tipoMensaje = listaLimite[indPuntoLimite].tipoMensaje;
    tipoMensaje += vLogro >= vLimite ? "Supero" : "";
    if (vLogro < mn) {
        tipoMensaje = "MontoMinimo";
    }

    listaMensajeMeta = listaMensajeMeta || new Array();
    var objMsg = listaMensajeMeta.Find("TipoMensaje", tipoMensaje)[0] || new Object();
    objMsg.Titulo = $.trim(objMsg.Titulo);
    objMsg.Mensaje = $.trim(objMsg.Mensaje);
    if (objMsg.Titulo == "" && objMsg.Mensaje == "") {
        $("#divBarra #divBarraMensajeLogrado").hide();
        return false;
    }
    var valPor = listaLimite[indPuntoLimite].valPor || "";
    var valorMonto = vbSimbolo + " " + DecimalToStringFormat(parseFloat(vLimite - vLogro));
    $("#divBarra #divBarraMensajeLogrado").show();
    $("#divBarra #divBarraMensajeLogrado .mensaje_barra").html(objMsg.Titulo.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    $("#divBarra #divBarraMensajeLogrado .agrega_barra").html(objMsg.Mensaje.replace("#porcentaje", valPor).replace("#valor", valorMonto));
    $("#divBarraMensajeLogrado").css("width", "");
    var wMsgTexto = $("#divBarra #divBarraMensajeLogrado > div").width() + 1;
    wMsgTexto = wLogro + wMsgTexto >= wTotal ? wTotal : (wLogro + wMsgTexto);
    $("#divBarra #divBarraMensajeLogrado").css("width", wMsgTexto);

    return true;
}

