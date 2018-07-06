var CarruselModule = (function (config) {
    'use strict';
    
    var _config = {
        palanca: config.palanca || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlDataCarrusel: config.urlDataCarrusel || ""
    };
     
    var _elementos = {
        idPlantillaProductoLanding: config.idPlantilla,
        divCarruselSetsProductosRelacionados: config.divCarrusel,
        divSetsProductosRelacionados: config.divCarrusel,
        idTituloCarrusel: config.idTituloCarrusel
    };

    var _promiseObternerDataCarrusel = function (params) {
        var dfd = $.Deferred();
        $.ajax({
            type: "POST",
            url: _config.urlDataCarrusel,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(params),
            async: false,
            cache: false,
            success: function (data) {
                
                dfd.resolve(data);
            },
            error: function (data, error) {
                dfd.reject(data, error);
            }
        });

        return dfd.promise();
    };

    var _cargarDatos_Lanzamiento = function () {

        var setRelacionados = [];

        var cuv = _config.cuv;
        var campaniaId = _config.campania;

        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return false;
        }

        var str = LocalStorageListado("LANLista" + campaniaId, "", 1) || "";

        if (str === '') {
            return false;
        }

        var lista = JSON.parse(str).response.listaLan;
        var codigoProducto = "";

        $.each(lista, function (index, lanzamiento) {
            if (cuv === lanzamiento.CUV2) {
                codigoProducto = lanzamiento.CodigoProducto;
                return false;
            }
        });

        $.each(lista, function (index, lanzamiento) {
            if (cuv != lanzamiento.CUV2 && lanzamiento.CodigoProducto === codigoProducto) {
                setRelacionados.push(lanzamiento);
            }
        });
        if (setRelacionados.length == 0) {
            return false;
        }

       return setRelacionados;
    } 
 
    var _mostrarSlicks = function () {

        var platform = !isMobile() ? 'desktop' : 'mobile';

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
    }

    var _ocultarElementos = function () {

        $(_elementos.divSetsProductosRelacionados).fadeOut();
    }

    var _mostrarTitulo = function () {
        
        var titulo = '';

        if (_config.palanca == 'Lanzamiento')
        {
            titulo='SET DONDE ENCUENTRAS EL PRODUCTO';
        }
        else if (_config.palanca == 'ShowRoom')
        {
            titulo = 'VER MÁS SETS EXCLUSIVOS PARA TI';
        } else if (_config.palanca == 'OfertaDelDia')
        {
            titulo = 'VER MÁS OFERTAS ¡SOLO HOY!';
        }

        $(_elementos.idTituloCarrusel).html(titulo);
    }

    var _mostrarCarrusel = function () {
        
        var data = {
            lista: []
        };
     

        if (_config.palanca == 'Lanzamiento') {
            data.lista = _cargarDatos_Lanzamiento();
            SetHandlebars(_elementos.idPlantillaProductoLanding, data, _elementos.divCarruselSetsProductosRelacionados);
        }
        else if ((_config.palanca == 'ShowRoom') || (_config.palanca == 'OfertaDelDia')) {

            var param = { CUVExcluido: _config.cuv, palanca: _config.palanca }

            _promiseObternerDataCarrusel(param).done(function (response) {
                
                if (response)
                {
                    if (response.success)
                    {
                        data.lista = response.data;
                        SetHandlebars(_elementos.idPlantillaProductoLanding, data, _elementos.divCarruselSetsProductosRelacionados);                         
                    }
                }
            });
            
        }
    };     

    function Inicializar() {
        
        _ocultarElementos();
        _mostrarCarrusel();
        _mostrarTitulo();
        _mostrarSlicks();
       
    }

    return {
        Inicializar: Inicializar
    };
});