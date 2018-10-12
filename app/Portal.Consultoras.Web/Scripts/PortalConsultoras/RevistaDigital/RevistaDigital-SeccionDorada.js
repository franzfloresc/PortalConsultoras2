$(window).on("scroll", function () {
    var $divProductosShowRoom = $('#divProductosShowRoom');
    var $divOfertaProductos = $('#divOfertaProductos');
    var EsOPT = $divProductosShowRoom.length > 0 ? false : true;
    if (isMobile()) {
        var cabecera_mobil = $('header').outerHeight(true);
        var tabs_mobil = $('#seccion-menu-mobile').outerHeight(true);
        var cont_prod_mobil = EsOPT ? $divOfertaProductos.outerHeight(true) : $divProductosShowRoom.outerHeight(true);
        var menu_para_ti = $('.bc_para_ti-menu-opciones').outerHeight(true);
        var total_head_sin = menu_para_ti + cabecera_mobil;
        var total_head_mobil = cabecera_mobil + cont_prod_mobil;
        var total_sin_head = $('.contenido_zona_dorada_contenedor_desktop').outerHeight(true);

        if ($(this).scrollTop() >= total_head_mobil) {
            $('.contenido_zona_dorada_contenedor_desktop .logo-dorado-desktop').addClass('dorado_esconde_imagen');
            $('.contenido_zona_dorada_contenedor_desktop').addClass('dorado_contenedor');
            $('#divOfertaProductosPerdio').addClass('dorado_contenedor_prods');
            if (!EsOPT) {
                $('#block_inscribete').css("top", 105);
            } else {
                $('#block_inscribete').css("top", cabecera_mobil > 0 ? 105 : 45);
            }
        }
        else {
            $('.contenido_zona_dorada_contenedor_desktop .logo-dorado-desktop').removeClass('dorado_esconde_imagen');
            $('.contenido_zona_dorada_contenedor_desktop').removeClass('dorado_contenedor');
            $('#divOfertaProductosPerdio').removeClass('dorado_contenedor_prods');
            $('#block_inscribete').css("top", 0);
        }
    }
    else {
        var header_altura = $(".wrapper_header").outerHeight(true);
        var contenedor_ofertas = EsOPT ? $divOfertaProductos.outerHeight(true) : $divProductosShowRoom.outerHeight(true);
        var total_altura_scroll = header_altura + contenedor_ofertas;
        if ($(this).scrollTop() >= total_altura_scroll) {
            $('.zona_dorada_contenedor_desktop').addClass('fixed_contenedor_head');
            $('.contenido_zona_dorada_contenedor_desktop').addClass('fixed_head');
            $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').addClass('fixed_head_cabecera');
            $('.divOfertaProductosPerdiofix').addClass('fixed_productos');
            $('footer').css("position", "relative");
            $('footer').css("z-index", "99");
            $('.footerTerminos').css("position", "relative");
            $('.footerTerminos').css("z-index", "99");
            if (!EsOPT) {
                $('.footerTerminos').css("position", "relative");
                $('.footerTerminos').css("z-index", "99");
            }
        }
        else {
            $('.zona_dorada_contenedor_desktop').removeClass('fixed_contenedor_head');
            $('.contenido_zona_dorada_contenedor_desktop').removeClass('fixed_head');
            $('.contenido_zona_dorada_contenedor_desktop .fix-zona-dorada').removeClass('fixed_head_cabecera');
            $('.divOfertaProductosPerdiofix').removeClass('fixed_productos');
            $('footer').css("position", "initial");
            $('.footerTerminos').css("position", "initial");
            if (!EsOPT) {
                $('.footerTerminos').css("position", "initial");
            }
        }
    }
});