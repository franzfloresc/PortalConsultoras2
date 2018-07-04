var CarruselModule = (function (config) {
    'use strict';
    
    var _config = {
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || ""
    };
   
    var _elementos = {
        idPlantillaProductoLanding: "#producto-landing-template",
        divCarruselSetsProductosRelacionados: "#divOfertaProductos",
        divSetsProductosRelacionados: "#set_relacionados"
    };
    
     

    var _obtenerSetRelacionados = function () {


        var cuv = _config.cuv;
        var campaniaId = _config.campania;
        var setRelacionados = [];
        var data = {
            lista: []
        };


        if (_config.palanca == 'Lanzamiento') {
            if (cuv == "" || campaniaId == "" || campaniaId == "0") {
                return false;
            }

            var str = LocalStorageListado("LANLista" + campaniaId, '', 1) || '';

            if (str === '') {
                return false;
            }

            data.lista = JSON.parse(str).response.listaLan;


            var codigoProducto = '';
            $.each(data.lista, function (index, lanzamiento) {
                if (cuv === lanzamiento.CUV2) {
                    codigoProducto = lanzamiento.CodigoProducto;
                    return false;
                }
            });

            $.each(data.lista, function (index, lanzamiento) {
                if (cuv != lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                    setRelacionados.push(lanzamiento);
                }
            });
            if (setRelacionados.length == 0) {
                return false;
            }

            data.lista = setRelacionados;
        }

        return data;

    }



    var _mostrarSetRelacionados = function () {

        $(_elementos.divSetsProductosRelacionados).fadeOut();

        var platform = !isMobile() ? 'desktop' : 'mobile';


        if (platform != 'mobile')
            return false;

        var data = _obtenerSetRelacionados();

        if (!data)
            return false;

        SetHandlebars(_elementos.idPlantillaProductoLanding, data, _elementos.divCarruselSetsProductosRelacionados);
        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

        var slickArrows = {
            'mobile': {
                prev: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-left: 0%; text-align:left;"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas_mobile" href="javascript:void(0);" style="margin-right:0%; text-align:right; right:0"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        var widthDimamico = !isMobile();

        $(_elementos.divCarruselSetsProductosRelacionados + '.slick-initialized').slick('unslick');
        $(_elementos.divCarruselSetsProductosRelacionados).not('.slick-initialized').slick({
            dots: false,
            infinite: true,
            speed: 260,
            slidesToShow: 2,
            slidesToScroll: 1,
            variableWidth: widthDimamico,
            prevArrow: slickArrows[platform].prev,
            nextArrow: slickArrows[platform].next,
            responsive: [
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1,
                        infinite: true
                    }
                }
            ]
        });

        $(_elementos.divSetsProductosRelacionados).fadeIn();
    };
     

    function Inicializar() {

        _mostrarSetRelacionados();
    }

    return {
        Inicializar: Inicializar
    };
});