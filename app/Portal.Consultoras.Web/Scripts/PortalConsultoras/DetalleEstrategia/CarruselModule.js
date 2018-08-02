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
        divProductosRelacionados: config.divCarrusel,
        idTituloCarrusel: config.idTituloCarrusel,
        divCarruselContenedor: config.divSetsProductosdata,
        ContenidoProducto: config.ContenidoProducto,
        CarruselProducto: config.CarruselProducto
    };

    var _variable = {
        cantidadProdCarrusel: 0
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

    var _cargarDatos = function () {

        var setRelacionados = [];

        var cuv = _config.cuv;
        var campaniaId = _config.campania;

        if (cuv == "" || campaniaId == "" || campaniaId == "0") {
            return setRelacionados;
        }

        var str = LocalStorageListado("LANLista" + campaniaId, "", 1) || "";

        if (str === '') {
            return setRelacionados;
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
                lanzamiento.ImagenURL = "";
                setRelacionados.push(lanzamiento);
            }
        });

        return setRelacionados;
    }

    var _mostrarSlicks = function () {

        var platform = !isMobile() ? 'desktop' : 'mobile';

        EstablecerAccionLazyImagen("img[data-lazy-seccion-revista-digital]");

        var slickArrows = {
            'mobile': {
                prev: '<a class="carrusel_fechaprev_mobile" href="javascript:void(0);"><img src="' + baseUrl + 'Content/Images/mobile/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="carrusel_fechanext_mobile" href="javascript:void(0);"><img src="' + baseUrl + 'Content/Images/mobile/Esika/next.png")" alt="" /></a>'
            },
            'desktop': {
                prev: '<a class="previous_ofertas" style="left:-5%; text-align:left;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
                next: '<a class="previous_ofertas" style="display: block; right:-5%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
            }
        };

        var widthDimamico = !isMobile();

        $(_elementos.divProductosRelacionados).fadeIn();

        if ((widthDimamico && _variable.cantidadProdCarrusel > 2) || !widthDimamico) {

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
                //centerMode: true,
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
        }
    }

    var _ocultarElementos = function () {

        $(_elementos.divProductosRelacionados).fadeOut();
    }

    var _mostrarTitulo = function () {

        var titulo = '';

        if (_config.palanca == ConstantesModule.CodigosPalanca.Lanzamiento) {
            titulo = 'SET DONDE ENCUENTRAS EL PRODUCTO';
        }
        else if (_config.palanca == ConstantesModule.CodigosPalanca.ShowRoom) {
            titulo = 'VER MÁS SETS EXCLUSIVOS PARA TI';
        }
        else if (_config.palanca == ConstantesModule.CodigosPalanca.OfertaDelDia) {
            titulo = 'VER MÁS OFERTAS ¡SOLO HOY!';
        }

        $(_elementos.idTituloCarrusel).html(titulo);
    }

    var _mostrarCarrusel = function () {

        var data = {
            lista: []
        };

        if (_config.palanca == ConstantesModule.CodigosPalanca.Lanzamiento) {
            data.lista = _cargarDatos();
        }
        else if (
            (_config.palanca == ConstantesModule.CodigosPalanca.ShowRoom)
            || (_config.palanca == ConstantesModule.CodigosPalanca.OfertaDelDia)
            || (_config.palanca == ConstantesModule.CodigosPalanca.PackNuevas)
        ) {

            var param = { cuvExcluido: _config.cuv, palanca: _config.palanca }

            _promiseObternerDataCarrusel(param).done(function (response) {

                if (response) {
                    if (response.success) {
                        data.lista = response.data;
                    }
                }

            });
        }

        if (data.lista.length > 0) {
            _variable.cantidadProdCarrusel = data.lista.length;
            SetHandlebars(_elementos.idPlantillaProductoLanding, data, _elementos.divCarruselSetsProductosRelacionados);
            _mostrarTitulo();
            _mostrarSlicks();
        }
        _ocultarCarrusel(data);
    };

    var _ocultarCarrusel = function (data) {
        if (typeof data != "undefined")
            if (Array.isArray(data.lista) && data.lista.length > 0) {
                $(_elementos.divCarruselContenedor).show();
                return;
            } else {
                //$(_elementos.ContenidoProducto).hide();
                $(_elementos.CarruselProducto).hide();
            }
        $(_elementos.divCarruselContenedor).hide();
    }

    function Inicializar() {

        _ocultarElementos();
        _mostrarCarrusel();

    }

    return {
        Inicializar: Inicializar
    };
});