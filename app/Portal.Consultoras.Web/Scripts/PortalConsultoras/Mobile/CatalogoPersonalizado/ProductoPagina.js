

$(document).ready(function () {

    //PL20-1237
    $('.footer-page').hide();

    $("#VerPrecioCatalogo").on("click", function () {
        $('#GuiaNegocio').hide(); //muestro mediante id
        $('#PrecioCatalogo').show(); //oculto mediante id

        $('ul[data-tab="tab"] li a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    });

    $("#VerGuiaNegocio").on("click", function () {
        $('#GuiaNegocio').show(); //muestro mediante id
        $('#PrecioCatalogo').hide(); //oculto mediante id

        $('ul[data-tab="tab"] li a').find("div.marcador_tab").addClass("oculto");
        $(this).find("div.marcador_tab").removeClass("oculto");
    });

    $('.tabs_pagos').mouseover(function () {
        $("#barCursor").css("opacity", "1");
    }).mouseout(function () {
        $("#barCursor").css("opacity", "0");
    });

    $(".content_tono_detalle").on("click", function () {

        $('.content_tono_detalle').removeClass('borde_seleccion_tono');
        $(this).addClass("borde_seleccion_tono");
    });

    setInfoCUV();

    //PL20-1239
    if (tieneOfertaEnRevista == 'True') {
        ObtenerOfertaRevista2($('[data-item="catalogopersonalizado"]'));
        $('#GuiaNegocio').show();
    }
    else {
        $('#PrecioCatalogo').show();
    }

});

//PL20-1269
function setInfoCUV() {
    var cuv = $('#hdCuvFichaProductoFAV').val();
    $('#fav_cbo_tono').val(cuv);
    $('#fav_tono_' + cuv).addClass("borde_seleccion_tono");
    $('#hdCuvFichaProductoFAVSelect').val(cuv);
}

//PL20-1239
function ObtenerOfertaRevista2(item) {
    // 201615 - 032610099 peru
    DialogLoadingAbrir();
    var $contenedor = item;
    var cuv = $contenedor.find('.hdItemCuv').val();
    // 11791 (mucha data) "10989" (niveles);//
    var tipoOfertaRevista = $.trim($contenedor.find('.hdItemTipoOfertaRevista').val());

    var obj = {
        //UrlImagen: $contenedor.find('[data-img]>img').attr('src'),
        UrlImagen: $contenedor.find('.hdItemRutaImagen').val(),
        CUV: $contenedor.find('.hdItemCuv').val(),
        TipoOfertaSisID: $contenedor.find('.hdItemTipoOfertaSisID').val(),
        ConfiguracionOfertaID: $contenedor.find('.hdItemConfiguracionOfertaID').val(),
        IndicadorMontoMinimo: $contenedor.find('.hdItemIndicadorMontoMinimo').val(),
        MarcaID: $contenedor.find('.hdItemMarcaID').val(),
        PrecioCatalogo: $contenedor.find('.hdItemPrecioUnidad').val(),
        Descripcion: $contenedor.find('.hdItemDescripcionProd').val(),
        DescripcionCategoria: $contenedor.find('.hdItemDescripcionCategoria').val(),
        DescripcionMarca: $contenedor.find('.hdItemDescripcionMarca').val(),
        DescripcionEstrategia: $contenedor.find('.hdItemDescripcionEstrategia').val(),
        Volumen: $contenedor.find('.hdItemVolumen').val()
    };

    jQuery.ajax({
        type: 'POST',
        url: baseUrl + 'CatalogoPersonalizado/ObtenerOfertaRevista',
        dataType: 'json',
        data: JSON.stringify({ cuv: cuv, tipoOfertaRevista: tipoOfertaRevista }),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            //$('[data-oferta]').attr("class", "").hide();
            //if (tipoOrigen == '2') {
            //    $('[data-oferta]').addClass("MensajeAlertaMobile");
            //}
            if (checkTimeout(response)) {

                if (!response.success) {
                    DialogLoadingCerrar();
                    return false;
                }

                response.data.dataPROL.Simbolo = vbSimbolo;
                response.data.dataPROL.TxtGanancia = response.data.txtGanancia;
                response.data.dataPROL.TxtRecibeGratis = response.data.txtRecibeGratis;

                var settings = $.extend({}, response.data.dataPROL, obj);
                settings.productoRevista = response.data.producto;
                TrackingJetloreView(cuv, $("#hdCampaniaCodigo").val())
                //console.log(settings);

                if (response.data.dataPROL != 'undefined' && response.data.dataPROL != null) {
                    switch (settings.tipo_oferta) {
                        case '003':
                            codTipoOferta = '003';
                            //settings.precio_catalogo = DecimalToStringFormat(settings.precio_catalogo);
                            //settings.precio_revista = DecimalToStringFormat(settings.precio_revista);
                            //settings.ganancia = DecimalToStringFormat(settings.ganancia);
                            //console.log(settings);
                            SetHandlebars("#template-oferta003", settings, '#Ficha_003A');
                            //$('[data-oferta]').addClass('mod-ofer1').show();

                            $('#Ficha_003A').show();
                            break;

                        case '048':
                            if (settings.lista_oObjPack.length > 0) {
                                codTipoOferta = '048P';
                                settings.lista_oObjPack = RemoverRepetidos(settings.lista_oObjPack);
                                settings.lista_oObjItemPack = RemoverRepetidos(settings.lista_oObjItemPack);
                                //settings.lista_oObjPack.splice(2, settings.lista_oObjPack.length);
                                settings.lista_oObjPack[settings.lista_oObjPack.length - 1].EsUltimo = 1;
                                dataOfertaEnRevista = settings;
                                //console.log(settings);
                                SetHandlebars("#template-oferta048P", settings, '#Ficha_048B');
                                //$('[data-oferta]').addClass('mod-ofer3').show();

                                $('#Ficha_048B').show();
                            }
                            else if (settings.lista_ObjNivel.length > 0) {
                                codTipoOferta = '048N';
                                settings.lista_ObjNivel = RemoverRepetidos(settings.lista_ObjNivel);
                                settings.lista_oObjGratis = RemoverRepetidos(settings.lista_oObjGratis);
                                var lista = Clone(settings.lista_ObjNivel);
                                settings.lista_ObjNivel = new Array();
                                $.each(lista, function (ind, nivel) {
                                    if (nivel.escala_nivel > 1) {
                                        settings.lista_ObjNivel.push(nivel);
                                    }
                                });
                                //settings.lista_ObjNivel.splice(3, settings.lista_ObjNivel.length);
                                dataOfertaEnRevista = settings;
                                //console.log(settings);
                                SetHandlebars("#template-oferta048N", settings, '#Ficha_048A');

                                $('#Ficha_048A').show();
                            }
                            break;
                    }
                }
                DialogLoadingCerrar();
            }
        },
        error: function (response, error) {
            if (checkTimeout(response)) {
                DialogLoadingCerrar();
            }
        }
    });
}