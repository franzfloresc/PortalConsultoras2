var FichaModule = (function (config) {
    'use strict';
    var localStorageModule;
    
    var _config = {
        palanca: config.palanca || "",
        origen: config.origen || "",
        tieneSession: config.tieneSession || "",
        campania: config.campania || "",
        cuv: config.cuv || "",
        urlObtenerComponentes: config.urlObtenerComponentes
        
    }
    var _codigoVariedad = ConstantesModule.CodigoVariedad;
    var _codigoPalanca = ConstantesModule.CodigosPalanca;
    
    var _elementos = {
        dataClicked: "[data-clicked]",
        dataChange: "[data-change]",
        dataSelected:  "[data-select-area]"
    }

    var _eventos =
    {
        clickChange: function () {
          
        },
        mouseMove: function () {
        
        },
        mouseLeaveSelectArea: function () {

        }
    }

    var _bindingEvents = function () {
        $("body").on("click", _elementos.dataClicked, _eventos.clickChange);

        if (!isMobile()) {
            $(document).on("mousemove", _elementos.dataChange, _eventos.mouseMove);
            $(document).on("mouseleave",_elementos.dataSelected, _eventos.mouseLeaveSelectArea);
        }
    }
    
    var _crearReloj = function() {
        $("#clock").each(function (index, elem) {
            $(elem).FlipClock(50000,
                {
                    countdown: true,
                    clockFace: 'HourlyCounter',
                    language: 'es-es',
                });
        });
    }

    var _crearTabs = function() {
        for (var i = 1; i <= 5; i++) {
            if (document.getElementById("ficha_tab_" + i.toString()).checked) {
                document.getElementById("contenido_" + i.toString()).style.display = "block";
            }

            document.getElementById("ficha_tab_" + i.toString()).onclick = function (event) {
                var numID = event.target.getAttribute('data-numTab');

                for (var j = 1; j <= 5; j++) {
                    document.getElementById("contenido_" + j.toString()).style.display = "none";
                }

                document.getElementById("contenido_" + numID.toString()).style.display = "block";
            }
        }
    }
    
    var _crearCarruseles = function() {
        $("#carrusel").not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            infinite: true,
            vertical: false,
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow:
                '<a class="contenedor_flecha_carrusel flecha_izquierda_carrusel js-slick-prev slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_izquierda_carrusel"></div></a>',
            nextArrow:
                '<a class="contenedor_flecha_carrusel flecha_derecha_carrusel js-slick-next slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_derecha_carrusel"></div></a>'
        });

        $("#carrusel_tonos").not('.slick-initialized').slick({
            lazyLoad: 'ondemand',
            infinite: true,
            vertical: false,
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow:
                '<a class="contenedor_flecha_carrusel flecha_izquierda_carrusel js-slick-prev slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_carrusel_tonos dibujar_flecha_izquierda_carrusel"></div></a>',
            nextArrow:
                '<a class="contenedor_flecha_carrusel flecha_derecha_carrusel js-slick-next slick-arrow"><div class="dibujar_linea dibujar_flecha_carrusel dibujar_flecha_carrusel_tonos dibujar_flecha_derecha_carrusel"></div></a>'
        });
    }
    
    var _promiseObternerComponentes = function (params) {
        var dfd = $.Deferred();

        $.ajax({
            type: "POST",
            url: _config.urlObtenerComponentes,
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
    }

    var _verificarVariedad = function (estrategia) {
        if (IsNullOrEmpty(estrategia.codigoVariante)) {
            var componentes;
            var param = {
                estrategiaId: estrategia.EstrategiaID,
                campania: _config.campania,
                codigoVariante: estrategia.CodigoVariante
            }
            
            _promiseObternerComponentes(param).done(function (data) {
                componentes = data.componentes;
            }).fail(function (data, error) {
                componentes = new Object();
            });
            
            return componentes;
        } else return new Object();
    }
    
   

    var _construirSeccionEstrategia = function () {

        var estrategia;
        if (_config.tieneSession === "True") {
            //revisar si se realiza con razor o handle bar para SW y ODD
            estrategia = new Object();
        } else {
            estrategia = localStorageModule.ObtenerEstrategia(_config.cuv, _config.campania, _config.palanca);
        }

        if (estrategia == null) {
            window.location = (isMobile() ? "/Mobile/" : "") + "Ofertas";
            return false;
        }
        
        $("#data-estrategia").attr("data-estrategia", JSON.stringify(estrategia));

        estrategia.Hermanos = _verificarVariedad(estrategia);
        SetHandlebars("#detalle_ficha_template", estrategia, "#seccion_ficha_handlebars");
        return true;
    }
    
    function Inicializar() {
        localStorageModule = LocalStorageModule();
        _construirSeccionEstrategia();
        _bindingEvents();
        _crearReloj();
        _crearTabs();
        _crearCarruseles();
       
    }

    return {
        Inicializar: Inicializar
    }
});