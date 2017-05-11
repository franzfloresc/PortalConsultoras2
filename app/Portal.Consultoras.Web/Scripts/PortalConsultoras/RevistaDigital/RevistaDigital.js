function OfertaArmarEstrategias(response) {
    var lista = EstructurarDataCarousel(response.lista);

    $.each(lista, function (index, value) {
        value.Posicion = index + 1;
        value.UrlDetalle = urlOfertaDetalle + '/' + (value.ID || value.Id);
    });

    $("#divOfertaProductos").html("");
    response.Lista = lista;
    response.CodigoEstrategia = $("#hdCodigoEstrategia").val() || "";
    response.ClassEstrategia = 'revistadigital-landing';
    response.Consultora = usuarioNombre.toUpperCase()
    response.CodigoEstrategia = "101";

    // Lanzamiento carrusel




    // Listado de producto
    var urlTemplate = "#estrategia-template";

    var htmlDiv = SetHandlebars(urlTemplate, response, '#divOfertaProductos');
    //$('#divOfertaProductos').append(htmlDiv);

    $("#spnCantidadFiltro").html(response.cantidad);
    $("#spnCantidadTotal").html(response.cantidadTotal);
}
