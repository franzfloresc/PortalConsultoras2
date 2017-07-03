var masVendidosModule = (function () {
    "use strict"

    var CONTANSTES_ = {

    };

    var elements = {
        
    };
    
    var setting = {
        baseUrl: '',
        urlVerDetalleProducto: 'EstrategiaProducto/DetalleProducto',

    };

    var lista = [];

    var _bindEvents = function () {
        $(document).on("click", elements.btnAgregarComentario, function () {
            
        });

        $(document).ready(function () {
            var model = get_local_storage("data_mas_vendidos");
            var item = model.Item;
            //item.UrlCompartir = item.UrlCompartir.replace('localhost:35848','sbpl20qa.somosbelcorp.com');//http://localhost:35848//Pdto.aspx?id=PE_[valor]
            SetHandlebars("#template-detalle-producto", item, "#contenedor-detalle-producto");
            _validarGanancia(item);
            _validarPrecioTachado(item);
            _pintarEstrellas(item);
            _pintarRecomendaciones(item);
            _pintarUltimoComentario(item);
            _pintarUltimoComentarioConsultora(item);
            let data = _armarListaCarruselDetalleProducto();
            _armarCarouselMasVendidos(data);
            inicializarDivMasVendidos('desktop');
            _validarDivTituloMasVendidos();
        });
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
        SetHandlebars("#mas-vendidos-templateDP", data, '#divCarrouselMasVendidos');
        PintarEstrellasCarrusel(data.Lista);
        PintarRecomendacionesCarrusel(data.Lista);
    }

    function PintarRecomendacionesCarrusel(listaMasVendidos) {
        listaMasVendidos.forEach(item => {
            _pintarRecomendacionesCarrusel(item);
        });
    }

    function _pintarRecomendacionesCarrusel(item) {
        let div = "#recommedation-" + item.EstrategiaID.toString();
        if (item.CantComenRecom > 0) {
            let recommendation = '(' + item.CantComenRecom.toString() + ' )';
            $(div).html(recommendation);
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    function PintarEstrellasCarrusel(listaMasVendidos) {
        listaMasVendidos.forEach(item => {
            _pintarEstrellasCarrusel(item);
        });
    }

    function _pintarEstrellasCarrusel(item) {
        let div = "#star-" + item.EstrategiaID.toString();
        if (item.PromValorizado > 0) {
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
            $(div).show();
        }
        else {
            $(div).hide();
        }
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
        if (item.UltimoComentario.NombreConsultora !== '') {
            let consultant_commentary = item.UltimoComentario.NombreConsultora;
            $(div).html(consultant_commentary);
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    var _pintarUltimoComentario = function (item) {
        let div = "#last-commentary-" + item.EstrategiaID.toString();
        if (item.UltimoComentario.Comentario !== '') {
            let last_commentary = item.UltimoComentario.Comentario;
            $(div).html(last_commentary);
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    var _pintarRecomendaciones = function (item) {
        let div = "#recommendation-" + item.EstrategiaID.toString();
        if (item.CantComenRecom > 0) {
            let recommendation = '(' + item.CantComenRecom.toString() + ' Recomendaciones)'
            $(div).html(recommendation);
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    var _pintarEstrellas = function (item) {
        let div = "#star-" + item.EstrategiaID.toString();
        if (item.PromValorizado > 0) {
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
            $(div).show();
        }
        else {
            $(div).hide();
        }
    }

    var _validarGanancia = function(item){
        if (item.Ganancia > 0) {
            $(".ganancia_showroom").show();
        }
        else {
            $(".ganancia_showroom").hide();
        }
    }

    var _validarPrecioTachado = function (item) {
        if (item.Ganancia > 0) {
            $(".precio_valorizado_showroom").show();
        }
        else {
            $(".precio_valorizado_showroom").hide();
        }
    }

    var _setDefaultValues = function () { };

    var _initializer = function (parameters) {
        setting.baseUrl = parameters.baseUrl;
        _bindEvents();
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
                        location.href = "/" + 'EstrategiaProducto/DetalleProducto';
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
            url: "EstrategiaProducto/ObtenerDetalleProducto",
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
        }
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