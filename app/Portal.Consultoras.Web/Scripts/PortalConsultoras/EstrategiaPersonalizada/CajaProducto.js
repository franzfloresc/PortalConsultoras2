$(function () {
    $('[data-seccion] [data-item-producto] .producto_img img').load(function () {
        var anchoImagen = $(this).width();
        var objetoEtiquetas = $(this).parent().parent().find('.producto_contenido');
        var anchoEtiquetas = objetoEtiquetas.width();

        if (anchoImagen > anchoEtiquetas) {
            objetoEtiquetas.width(anchoImagen);
        }
    });
});