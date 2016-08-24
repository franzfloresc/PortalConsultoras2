$(document).ready(function () {

    $(".footer-page").css({ "margin-bottom": "54px" });

    CargarCantidadProductosPedidos();
    CargarCarouselEstrategias("");
    CargarPopupsConsultora();
});

function RedirectPagaEnLineaAnalytics() {
    _gaq.push(['_trackEvent', 'Menu-Lateral', 'Paga-en-linea']);
    dataLayer.push({
        'event': 'pageview',
        'virtualUrl': '/Menu-Lateral/Paga-en-linea'
    });

    if (ViewBagRutaChile != "") {
        window.open(ViewBagRutaChile + ViewBagUrlChileEncriptada, "_blank");
    }
    else {
        window.open('https://www.belcorpchile.cl/BP_Servipag/PagoConsultora.aspx?c=' + ViewBagUrlChileEncriptada, "_blank");
    }
};
function CargarCarouselEstrategias(cuv) {
    $('.js-slick-prev').remove();
    $('.js-slick-next').remove();
    $('#divCarouseHorizontalMobile').unslick();
    $('#divCarouseHorizontalMobile').html('<div style="text-align: center;">Cargando Productos Destacados<br><img src="' + urlLoad + '" /></div>');

    $.ajax({
        type: 'GET',
        url: urlGetEstrategiasCarousel + '?cuv=' + cuv,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            ArmarCarouselEstrategias(data);
        },
        error: function (error) {
            $('#divCarruselHorizontal').html('<div style="text-align: center;">Ocurrio un error al cargar los productos.</div>');
        }
    });
};
function ArmarCarouselEstrategias(data) {
    data = EstructurarDataCarousel(data);

    SetHandlebars("#estrategia-template", data, '#divCarouseHorizontalMobile');

    if ($.trim($('#divCarouseHorizontalMobile').html()).length == 0) {
        $('.fondo_gris').hide();
    } else {
        $('#divCarouseHorizontalMobile').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            prevArrow: '<a class="previous_ofertas_mobile js-slick-prev" style="margin-left:-13%"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas_mobile js-slick-next" style="margin-right:-13%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>',
            responsive: [
                {
                    breakpoint: 1200,
                    settings: { slidesToShow: 3, slidesToScroll: 1 }
                },
                {
                    breakpoint: 900,
                    settings: { slidesToShow: 2, slidesToScroll: 1 }
                },
                {
                    breakpoint: 600,
                    settings: { slidesToShow: 1, slidesToScroll: 1 }
                }
            ]
        });
    }
};
function EstructurarDataCarousel(array) {
    $.each(array, function (i, item) {
        if (item.FlagNueva == 1) {
            item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
        } else {
            item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
        };
    });

    return array;
};
function CargarProductoDestacado(objParameter, objInput) {
    ShowLoading();

    if (ReservadoOEnHorarioRestringido())
        return false;

    var tipoEstrategiaID = objParameter.TipoEstrategiaID;
    var estrategiaID = objParameter.EstrategiaID;
    var posicionItem = objParameter.Posicion;
    var flagNueva = objParameter.FlagNueva;
    var cantidadIngresada = $(objInput).parent().find("input.rango_cantidad_pedido").val();

    $("#hdTipoEstrategiaID").val(tipoEstrategiaID);

    var params = {
        EstrategiaID: estrategiaID,
        FlagNueva: flagNueva
    };

    jQuery.ajax({
        type: 'POST',
        url: urlFiltrarEstrategiasPedido ,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(params),
        async: true,
        success: function (datos) {
            var flagEstrella = (datos.data.FlagEstrella == 0) ? "hidden" : "visible";
            $("#imgTipoOfertaEdit").attr("src", datos.data.ImagenURL);
            $("#imgEstrellaEdit").css({ "visibility": flagEstrella });
            $("#imgZonaEstrategiaEdit").attr("src", datos.data.FotoProducto01);

            if (datos.data.Precio != "0") {
                $(".zona2Edit").html(datos.data.EtiquetaDescripcion + ' ' + datos.data.Simbolo + '' + datos.precio);
            } else {
                $(".zona2Edit").html("");
            }

            if (datos.data.Precio2 != "0") {
                $(".zona3Edit_1").html(datos.data.EtiquetaDescripcion2);
                $(".zona3Edit_2").html('<span>' + datos.data.Simbolo + '' + datos.precio2 + '</span>');
            } else {
                $(".zona3Edit_1").html("");
                $(".zona3Edit_2").html("");
            }

            if (datos.data.TextoLibre != "") {
                $(".zona4Edit").html(datos.data.TextoLibre);
            } else {
                $(".zona4Edit").html("");
            }

            if (datos.data.ColorFondo != "") {
                $("#divVistaPrevia").css({ "background-color": datos.data.ColorFondo });
            } else {
                $("#divVistaPrevia").css({ "background-color": "#FFF" });
            }

            $("#txtCantidadZE").val(cantidadIngresada);
            $("#txtCantidadZE").attr("est-cantidad", datos.data.LimiteVenta);
            $("#txtCantidadZE").attr("est-cuv2", datos.data.CUV2);
            $("#txtCantidadZE").attr("est-marcaID", datos.data.MarcaID);
            $("#txtCantidadZE").attr("est-precio2", datos.data.Precio2);
            $("#txtCantidadZE").attr("est-montominimo", datos.data.IndicadorMontoMinimo);
            $("#txtCantidadZE").attr("est-tipooferta", datos.data.TipoOferta);
            $("#txtCantidadZE").attr("est-descripcionMarca", datos.data.DescripcionMarca);
            $("#txtCantidadZE").attr("est-descripcionEstrategia", datos.data.DescripcionEstrategia);
            $("#txtCantidadZE").attr("est-descripcionCategoria", datos.data.DescripcionCategoria);
            $("#txtCantidadZE").attr("est-posicion", posicionItem);

            $("#ddlTallaColor").empty();
            $(".zona0Edit").html(datos.data.DescripcionMarca);

            /*Validar Programa Ofertas Nuevas*/
            $("#hdnProgramaOfertaNuevo").val(false);
            $("#OfertasResultados li").hide();
            $("#OfertaTipoNuevo").val("");

            if (datos.data.FlagNueva == 1) {
                $(".zona4Edit").hide();
                $(".zonaCantidad").hide();
                $("#hdnProgramaOfertaNuevo").val(true);
                var nroPedidos = false;
                var pedidosData = $('#divListadoPedido').find("input[id^='hdfTipoEstrategia']");

                pedidosData.each(function (indice, valor) {
                    if (valor.value == 1) {
                        nroPedidos = true;
                        var OfertaTipoNuevo = "".concat($('#divListadoPedido').find("input[id^='hdfCampaniaID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoId']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfPedidoDetalleID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfTipoOfertaSisID']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='hdfCUV']")[indice].value, ";",
                            $('#divListadoPedido').find("input[id^='txtLPTempCant']")[indice].value, ";",
                            $('#hdnPagina').val(), ";",
                            $('#hdnClienteID2_').val());

                        $("#OfertaTipoNuevo").val(OfertaTipoNuevo);
                        return;
                    }
                });

                if (nroPedidos) {
                    $(".zona4Edit").text(datos.data.TextoLibre);
                    $(".zona4Edit").show();
                }

                var ofertas = datos.data.DescripcionCUV2.split('|');
                $(".zona1Edit").html(ofertas[0]);
                $("#txtCantidadZE").attr("est-descripcion", ofertas[0]);
                $("#OfertasResultados li").remove(); // Limpiar la lista.

                $.each(ofertas, function (i) {
                    if (i != 0 && $.trim(ofertas[i]) != "") {
                        $("#OfertasResultados").append("<li>" + ofertas[i] + "</li>");
                    }
                });

                CloseLoading();
                AgregarProductoDestacado();
            } else {
                $(".zona4Edit").show();
                $(".zonaCantidad").show();
                $(".zona1Edit").html(datos.data.DescripcionCUV2);
                $("#txtCantidadZE").attr("est-descripcion", datos.data.DescripcionCUV2);
                var option = "";
                $(".tallaColor").hide();
                if (datos.data.TallaColor != "") {
                    var arrOption = datos.data.TallaColor.split('</>');
                    if (arrOption.length > 2) {
                        for (var i = 0; i < arrOption.length; i++) {
                            if (arrOption[i] != "") {
                                option = "<option ";
                                var strOption = arrOption[i].split('|');
                                var strCuv = strOption[0];
                                var strDescCuv = strOption[1];
                                var strDescTalla = strOption[2];
                                option += " value='" + strCuv + "' desc-talla='" + strDescCuv + "' >" + strDescTalla + "</option>";
                                $("#ddlTallaColor").append(option);
                            }
                        }

                        $(".tallaColor").show();
                    }
                }
                if (option == "") {
                    AgregarProductoDestacado();
                } else {
                    CloseLoading();
                }
            }

            InfoCommerceGoogleDestacadoProductClick(datos.data.DescripcionCUV2, datos.data.CUV2, datos.data.DescripcionCategoria, datos.data.DescripcionEstrategia, posicionItem);
            //CloseLoading();
        },
        error: function (data, error) {
            alert(datos.data.message);
            CloseLoading();
        }
    });
};
function AgregarProductoDestacado() {
    var cantidad = $("#txtCantidadZE").val();
    var cantidadLimite = $("#txtCantidadZE").attr("est-cantidad");
    var cuv = $("#txtCantidadZE").attr("est-cuv2");
    var marcaID = $("#txtCantidadZE").attr("est-marcaID");
    var precio = $("#txtCantidadZE").attr("est-precio2");
    var descripcion = $("#txtCantidadZE").attr("est-descripcion");
    var indicadorMontoMinimo = $("#txtCantidadZE").attr("est-montominimo");
    var tipoOferta = $("#txtCantidadZE").attr("est-tipooferta");
    var categoria = $("#txtCantidadZE").attr("est-descripcionCategoria");
    var variant = $("#txtCantidadZE").attr("est-descripcionEstrategia");
    var marca = $("#txtCantidadZE").attr("est-descripcionMarca");
    var posicion = $("#txtCantidadZE").attr("est-posicion");
    var urlImagen = $("#imgZonaEstrategiaEdit").attr("src");

    // validar que se existan tallas
    if ($.trim($("#ddlTallaColor").html()) != "") {
        if ($.trim($("#ddlTallaColor").val()) == "") {
            messageInfo("Por favor, seleccione la Talla/Color del producto.");
            CloseLoading();
            return false;
        }
    }
    /*Quitar estas validaciones cuando exista Programa de Ofertas nuevas */
    if ($("#hdnProgramaOfertaNuevo").val() == "true") {
        cantidad = cantidadLimite;
    }
    if (!$.isNumeric(cantidad)) {
        messageInfo("Ingrese un valor numérico.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CloseLoading();
        return false;
    }
    if (parseInt(cantidad) <= 0) {
        messageInfo("La cantidad debe ser mayor a cero.");
        $('.liquidacion_rango_cantidad_pedido').val(1);
        CloseLoading();
        return false;
    }
    if (parseInt(cantidad) > parseInt(cantidadLimite)) {
        messageInfo("La cantidad no debe ser mayor que la cantidad limite ( " + cantidadLimite + " ).");
        CloseLoading();
        return false;
    }

    ShowLoading();

    var param = ({
        MarcaID: marcaID,
        CUV: cuv,
        PrecioUnidad: precio,
        Descripcion: descripcion,
        Cantidad: cantidad,
        IndicadorMontoMinimo: indicadorMontoMinimo,
        TipoOferta: $("#hdTipoEstrategiaID").val(),
        ElementoOfertaTipoNuevo: $("#OfertaTipoNuevo").val()
    });

    jQuery.ajax({
        type: 'POST',
        url: urlValidarStockEstrategia,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(param),
        async: true,
        success: function (datos) {
            if (!datos.result) {
                messageInfo(datos.message);
                CloseLoading();
            } else {
                jQuery.ajax({
                    type: 'POST',
                    url: urlAgregarProducto,
                    dataType: 'html',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(param),
                    async: true,
                    success: function (data) {
                        if (checkTimeout(data)) {
                            ShowLoading();
                            ActualizarGanancia(data.DataBarra);
                            InfoCommerceGoogle(parseFloat(cantidad * precio).toFixed(2), cuv, descripcion, categoria, precio, cantidad, marca, variant, "Productos destacados – Pedido", parseInt(posicion));
                            CargarCarouselEstrategias(cuv);
                            CargarCantidadProductosPedidos();
                            TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), cuv);
                            CloseLoading();
                        }
                    },
                    error: function (data, error) {
                        if (checkTimeout(data)) {
                            CloseLoading();
                        }
                    }
                });
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                CloseLoading();
            }
        }
    });
};
function InfoCommerceGoogle(ItemTotal, CUV, DescripcionProd, Categoria, Precio, Cantidad, Marca, variant, listaDes, posicion) {
    posicion = posicion || 1;
    if (ItemTotal >= 0 && Precio >= 0 && Cantidad > 0) {
        if (variant == null || variant == "") {
            variant = "Estándar";
        }
        if (Categoria == null || Categoria == "") {
            Categoria = "Sin Categoría";
        }
        dataLayer.push({
            'event': 'addToCart',
            'ecommerce': {
                'add': {
                    'actionField': { 'list': listaDes },
                    'products': [{
                        'name': DescripcionProd,
                        'price': Precio,
                        'brand': Marca,
                        'id': CUV,
                        'category': Categoria,
                        'variant': variant,
                        'quantity': parseInt(Cantidad),
                        'position': posicion
                    }]
                }
            }
        });
    }
};
function ReservadoOEnHorarioRestringido(mostrarAlerta) {
    mostrarAlerta = typeof mostrarAlerta !== 'undefined' ? mostrarAlerta : true;
    var restringido = true;

    $.ajaxSetup({ cache: false });
    jQuery.ajax({
        type: 'GET',
        url: urlReservadoOEnHorarioRestringido,
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        async: false,
        success: function (data) {
            if (!checkTimeout(data)) {
                return false;
            }

            if (data.success == false) {
                restringido = false;
                return false;
            }

            if (data.pedidoReservado) {
                var fnRedireccionar = function () {
                    ShowLoading();
                    location.href = urlValidadoPedido;
                }
                if (mostrarAlerta == true) {
                    CloseLoading();
                    //alert_msg(data.message, fnRedireccionar);
                    messageInfo(data.message);
                }
                else fnRedireccionar();
            }
            else if (mostrarAlerta == true) messageInfo(data.message);
        },
        error: function (error) {
            console.log(error);
            messageInfo('Ocurrió un error al intentar validar el horario restringido o si el pedido está reservado. Por favor inténtelo en unos minutos.');
        }
    });
    return restringido;
}

// CARGAR POPUPS HOME MOBILE
function CargarPopupsConsultora() {
    //if (viewBagPrimeraVez == "0" && viewBagPaisID == 4) { //Colombia
    //    AbrirAceptacionContrato();
    //}
    //else {
    //    if (viewBagPaisID == 9 && viewBagValidaDatosActualizados == '1' && viewBagValidaTiempoVentana == '1' && viewBagValidaSegmento == '1') { //Mexico
    //        if (contadorFondoPopUp == 0) {
    //            $("#fondoComunPopUp").show();
    //        }
    //        $("#popupActualizarMisDatosMexico").show();
    //        contadorFondoPopUp++;
    //    } else {
    //        if (viewBagPrimeraVez == "0" || viewBagPrimeraVezSession == "0") {
    //            if (viewBagPaisID == 11) { //Peru
    //                $('#tituloActualizarDatos').html('<b>ACTUALIZACIÓN Y AUTORIZACIÓN</b> DE USO DE DATOS PERSONALES');
    //            } else {
    //                $('#tituloActualizarDatos').html('<b>ACTUALIZAR</b> DATOS');
    //            }
    //            if (contadorFondoPopUp == 0) {
    //                $("#fondoComunPopUp").show();
    //            }
    //            $("#popupActualizarMisDatos").show();
    //            contadorFondoPopUp++;
    //        }
    //        else {
    //            if (viewBagPrimeraVez == "1" && viewBagPaisID == 4) { //Colombia
    //                AbrirAceptacionContrato();
    //            }
    //        }
    //    }
    //}

    //AbrirPopupFlexipago();
    //AbrirComunicado();

    //if (viewBagPrefijoPais == "EC") {
    //    AbrirComunicadoVisualizacion();
    //};

    MostrarDemandaAnticipada();

    //MostrarShowRoom();

    //if (viewBagValidaSuenioNavidad == 0) {
    //    showDialog('idSueniosNavidad');
    //}
};

function MostrarDemandaAnticipada() {
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/ValidacionConsultoraDA",
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $('#fechaHasta').text(data.mensajeFechaDA);
                    $('#fechaLuego').text(data.mensajeFechaDA);
                    if (contadorFondoPopUp == 0) {
                        $("#fondoComunPopUp").show();
                    }
                    $("#popupDemandaAnticipada").show();
                    contadorFondoPopUp++;
                }
                
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                if (tipo == 1) {
                    alert("Ocurrió un error al validar demanda anticipada.");
                } else {
                    alert("Ocurrió un error al validar la demanda anticipada.");
                }
            }
        }
    });
};

function AceptarDemandaAnticipada() {
    InsertarDemandaAnticipada(1);
};
function CancelarDemandaAnticipada() {
    InsertarDemandaAnticipada(0);
};
function InsertarDemandaAnticipada(tipo) {
    var params = { tipoConfiguracion: tipo };
    $.ajax({
        type: "POST",
        url: baseUrl + "Cronograma/InsConfiguracionConsultoraDA",
        data: JSON.stringify(params),
        contentType: 'application/json',
        success: function (data) {
            if (checkTimeout(data)) {
                if (data.success == true) {
                    $("#popupDemandaAnticipada").hide();
                    if (contadorFondoPopUp == 1) {
                        $("#fondoComunPopUp").hide();
                    }
                    contadorFondoPopUp--;
                    location.href = baseUrl + 'Login/LoginCargarConfiguracion?paisID=' + data.paisID + '&codigoUsuario=' + data.codigoUsuario;
                }
            }
        },
        error: function (data, error) {
            if (checkTimeout(data)) {
                if (tipo == 1) {
                    alert("Ocurrió un error al aceptar la demanda anticipada.");
                } else {
                    alert("Ocurrió un error al cancelar la demanda anticipada.");
                }
            }
        }
    });
};