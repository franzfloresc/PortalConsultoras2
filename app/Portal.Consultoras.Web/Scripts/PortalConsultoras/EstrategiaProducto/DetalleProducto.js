﻿var masVendidosModule = (function () {
    "use strict"

    var CONTANSTES_ = {

    };

    var elements = {
        
    };
    
    var setting = {
        baseUrl: ''        
    };

    var lista = [];

    var _bindEvents = function () {         
        $(document).ready(function () {
            var model = get_local_storage("data_mas_vendidos");
            var item = model.Item;
            SetHandlebars("#template-detalle-producto", item, "#contenedor-detalle-producto");
            if (tipoOrigenPantalla == 2) {
                SetHandlebars("#template-detalle-producto-agregar", item, "#contenedor-detalle-producto-agregar");
                SetHandlebars("#template-detalle-producto-compartir", item, "#contenedor-detalle-producto-compartir");
            }
            _validarGanancia(item);
            _validarPrecioTachado(item);
            _pintarEstrellas(item);
            _pintarRecomendaciones(item);
            _pintarUltimoComentario(item);
            _pintarUltimoComentarioConsultora(item);
            let data = _armarListaCarruselDetalleProducto();
            _armarCarouselMasVendidos(data);
            if (tipoOrigenPantalla === 1) { inicializarDivMasVendidos('desktop');}
            if (tipoOrigenPantalla === 2) { inicializarDivMasVendidosCarruselSinFlechas('mobile'); }            
            _validarDivTituloMasVendidos();
        });
    }

    function inicializarDivMasVendidosCarruselSinFlechas(origen) {
        if (origen == "mobile") {
            $('#Carrusel').on('init', function (event, slick) {
                setTimeout(function () {
                    slick.setPosition();
                    slick.slickGoTo(1);
                    $("#divCarrouselMasVendidosLista").find("[data-posicion-set]").find(".orden_listado_numero").find("[data-posicion-current]").html(1);
                }, 500);
            }).slick({
                dots: true,
                infinite: true,
                speed: 300,
                slidesToShow: 1,
                centerPadding: '0px',
                centerMode: true,
                variableWidth: true,
                slidesToScroll: 1,
                centerMode: true,
                arrows: false,
                dots: false,
            }).on('swipe', function (event, slick, direction) {
                var posicion = slick.currentSlide;
                posicion = Math.max(parseInt(posicion), 0);

                if (direction == 'left') { // dedecha a izquierda
                    posicion = posicion + 1;
                } else if (direction == 'right') {
                    posicion = posicion + 1;
                }

                $("#divCarrouselMasVendidosLista").find("[data-posicion-set]").find(".orden_listado_numero").find("[data-posicion-current]").html(posicion);
            });
        }
    }

    function inicializarDivMasVendidos(origen) {
        $('#divCarrouselMasVendidos.slick-initialized').slick('unslick');
        var slickArrows = {
            'mobile': {
                prev: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-left:-12%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>'
              , next: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-right:-12%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>'
              , next: '<a class="previous_ofertas" style="right: 0;display: block;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        $('#divCarrouselMasVendidos').not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            centerMode: false,
            centerPadding: '0px',
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 270,
            pantallaPedido: false,
            prevArrow: slickArrows[origen].prev,
            nextArrow: slickArrows[origen].next,
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

    var _armarListaCarruselDetalleProducto = function() {
        var model = get_local_storage("data_mas_vendidos");
        var item = model.Item;
        var lista = [];
        model.Lista.forEach(elem => {
            if (elem.EstrategiaID !== item.EstrategiaID) {
                lista.push(elem);
            }
        });
        model.Lista = lista;
        return model;
    }

    var _armarCarouselMasVendidos = function (data) {
        data.Lista = EstructurarDataCarousel(data.Lista);
        $("#divCarrouselMasVendidos").empty();
        var promesa = _actualizarModelMasVendidosPromise(data);
        $.when(promesa)
            .then(function (response) {
                if (checkTimeout(response)) {
                    if (response.success) {
                        data = response.data;
                        if (ValidarPintarMasVendidos(data.Lista)) {
                            if (tipoOrigenPantalla === 1) { SetHandlebars("#mas-vendidos-templateDP", data, '#divCarrouselMasVendidos'); }
                            if (tipoOrigenPantalla === 2) { SetHandlebars("#template-detalle-producto-lista", data, '#divCarrouselMasVendidos'); }
                            PintarEstrellasCarrusel(data.Lista);
                            PintarRecomendacionesCarrusel(data.Lista);
                            PintarPrecioTachadoCarrusel(data.Lista);
                            if (tipoOrigenPantalla === 2) { ValidarPosicionesCarruselMobile(data); }
                        }
                        else {
                            OcultarPanelMasVendidos();
                        }
                    } else {
                        console.log(response.menssage);
                    }
                }
            });
    }

    function ValidarPosicionesCarruselMobile(data) {
        if (data != null) {
            if (data.Lista != null) {
                var posicion = 0;
                if (data.Lista.length === 1) {
                    posicion = 1;
                    $("#divCarrouselMasVendidosLista").find("[data-posicion-set]").find(".orden_listado_numero").find("[data-posicion-current]").html(posicion);
                }
            }
        }
    }

    function OcultarPanelMasVendidos() {
        $(".content_carrusel_bestSeller").hide();
    }

    function ValidarPintarMasVendidos(listaMasVendidos) {
        if (listaMasVendidos == null) {
            return false;
        }
        if (listaMasVendidos.length === 0) {
            return false;
        }
        return true;
    }

    function PintarPrecioTachadoCarrusel(listaMasVendidos) {
        listaMasVendidos.forEach(item => {
            _pintarPrecioTachadoCarrusel(item);
        });
    }

    function _pintarPrecioTachadoCarrusel(item) {
        let div = "#precio-tachado-" + item.EstrategiaID.toString();
        if (item.Ganancia > 0) {
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    function PintarRecomendacionesCarrusel(listaMasVendidos) {
        listaMasVendidos.forEach(item => {
            _pintarRecomendacionesCarrusel(item);
        });
    }

    function _pintarRecomendacionesCarrusel(item) {
        let div = "#recommedation-" + item.EstrategiaID.toString();
        let recommendation = '(' + item.CantComenAprob.toString() + ')'
        $(div).html(recommendation);
        $(div).show();
    }

    function PintarEstrellasCarrusel(listaMasVendidos) {
        listaMasVendidos.forEach(item => {
            _pintarEstrellasCarrusel(item);
        });
    }

    function _pintarEstrellasCarrusel(item) {
        let div = "#star-" + item.EstrategiaID.toString();
        let rating = '';
        rating = item.PromValorizado.toString() + '%';
        $(div).rateYo({
            rating: rating,
            numStars: 5,
            precision: 2,
            minValue: 1,
            maxValue: 5,
            starWidth: "17px",
            readOnly: true
        });
    }

    function EstructurarDataCarousel(array) {
        var isList = array.DescripcionCUV2 == undefined;
        var lista = isList ? array : new Array();
        if (!isList)
            lista.push(array);

        var urlOfertaDetalle = $.trim(urlOfertaDetalle);
        $.each(lista, function (i, item) {
            item.DescripcionCUV2 = $.trim(item.DescripcionCUV2);
            item.DescripcionCompleta = item.DescripcionCUV2.split('|')[0];
            if (item.FlagNueva == 1) {
                item.DescripcionCUVSplit = item.DescripcionCUV2.split('|')[0];
                item.ArrayContenidoSet = item.DescripcionCUV2.split('|').slice(1);
            } else {
                item.DescripcionCUV2 = (item.DescripcionCUV2.length > 40 ? item.DescripcionCUV2.substring(0, 40) + "..." : item.DescripcionCUV2);
            };

            item.Posicion = i + 1;
            item.MostrarTextoLibre = (item.TextoLibre ? $.trim(item.TextoLibre).length > 0 : false);
            item.UrlDetalle = urlOfertaDetalle + '/' + (item.ID || item.Id) || "";
        });
        return isList ? lista : lista[0];
    };

    var _pintarUltimoComentarioConsultora = function (item) {
        let div = "#consultant-commentary-" + item.EstrategiaID.toString();
        if (item.UltimoComentario.NombreConsultora !== '' && item.UltimoComentario.NombreConsultora != null) {
            let consultant_commentary = "- " + item.UltimoComentario.NombreConsultora;
            $(div).html(consultant_commentary);
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    var _pintarUltimoComentario = function (item) {
        let div = "#last-commentary-" + item.EstrategiaID.toString();
        if (item.UltimoComentario.Comentario !== '' && item.UltimoComentario.Comentario != null) {
            let last_commentary = '"' + item.UltimoComentario.Comentario + '"';
            $(div).html(last_commentary);
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    var _pintarRecomendaciones = function (item) {
        let div = "#recommendation-" + item.EstrategiaID.toString();
        let recommendation = '(' + item.CantComenAprob.toString() + ' Comentarios)'
        $(div).html(recommendation);
        $(div).show();
    }

    var _pintarEstrellas = function (item) {
        let div = "#star-" + item.EstrategiaID.toString();
        let rating = '';
        rating = item.PromValorizado.toString() + '%';
        $(div).rateYo({
            rating: rating,
            numStars: 5,
            precision: 2,
            minValue: 1,
            maxValue: 5,
            starWidth: "17px",
            readOnly: true
        });
    }

    var _validarGanancia = function (item) {
        let element = "#precio-gana-" + item.EstrategiaID.toString();
        if (item.Ganancia > 0) {
            $(element).show();
        }
        else {
            $(element).hide();
        }
    }

    var _validarPrecioTachado = function (item) {
        let element = "#precio-tachado-" + item.EstrategiaID.toString();
        if (item.Ganancia > 0) {
            $(element).show();
        }
        else {
            $(element).hide();
        }
    }

    var _setDefaultValues = function () { };

    var _initializer = function (parameters) {
        _readVariables(parameters);
        _bindEvents();
    };

    var _readVariables = function (parameters) {
        setting.baseUrl = parameters.baseUrl;
        setting.urlDetalleProducto = parameters.urlDetalleProducto;
    };

    var _verDetalleProductoMasVendidos = function (estrategiaId) {
        var objProducto = _obtenerProductoDesdeStorage(estrategiaId);
        var verDetallePromise = _verDetallePromise(objProducto);
        $.when(verDetallePromise)
            .then(function (verDetalleResponse) {
                if (checkTimeout(verDetalleResponse)) {
                    if (verDetalleResponse.success) {
                        var item = verDetalleResponse.data.Item;
                        var model = get_local_storage("data_mas_vendidos");
                        model.Item = item;
                        model.Lista = _actualizarListaStorate(model.Lista, item);
                        set_local_storage(model, "data_mas_vendidos");                        
                        location.href = setting.urlDetalleProducto;
                    } else {
                        console.log(verDetalleResponse.menssage);
                    }
                }
            });
    };

    var _obtenerProductoDesdeStorage = function (estrategiaId) {
        var model = get_local_storage("data_mas_vendidos");
        var lista = model.Lista;
        var item = null;

        lista.forEach(elem => {if (elem.EstrategiaID === estrategiaId) {item = elem;}});

        return item;
    };
    
    var _actualizarListaStorate = function (lista, item) {
        var temp = [];
        lista.forEach(elem => {
            if (elem.EstrategiaID === item.EstrategiaID) {
                temp.push(item);
            } else {
                temp.push(elem);
            }
        })
        return temp;
    };

    var _verDetallePromise = function (data) {
        var d = $.Deferred();
        var promise = $.ajax({
            type: 'POST',
            url: setting.baseUrl + "EstrategiaProducto/ObtenerDetalleProducto",
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            async: true
        });

        promise.done(function (response) {
            d.resolve(response);
        })
        promise.fail(d.reject);

        return d.promise();
    };

    return {
        ini: function (parameters) {
            _initializer(parameters);
        },
        estrategiaVerDetalle: function (estrategiaId) {
            _verDetalleProductoMasVendidos(estrategiaId);
        },       
        readVariables: function (parameters) {
            _readVariables(parameters);
        },
    };
})();

function _validarDivTituloMasVendidos() {
    let tieneMasVendidosFlag = _validartieneMasVendidos();
    let model = get_local_storage("data_mas_vendidos");
    let lista = [];

    if (model !== 'undefined' && model !== null) {
        lista = model.Lista;
    }

    if (tieneMasVendidosFlag === 0) {
        $(".content_mas_vendidos").hide();
        return;
    }

    if (tieneMasVendidosFlag === 1) {
        if (lista.length === 0) {
            $(".content_mas_vendidos").hide();
        }
        else {
            $(".content_mas_vendidos").show();
        }
    }
}