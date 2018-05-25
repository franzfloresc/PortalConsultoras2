$(document).ready(function () {
    CargarProgramasBelcorp();
});

function CargarProgramasBelcorp() {
    $('#contenidoProgramasBelcorp').html('<div style="text-align: center;">Cargando Programas Belcorp<br><img src="' + urlLoad + '" /></div>');
    $.ajax({
        type: 'GET',
        url: baseUrl + 'MisBeneficios/GetJsonProgramasBelcorp',
        data: '',
        dataType: 'Json',
        contentType: 'application/json; charset=utf-8',
        success: function (data) {
            if (data.exito == true) {
                $.each(data.lista,
                    function (i, item) {
                        item.codigoISO = data.codigoISO;
                        item.DetalleDesripcion = "";
                        item.urlImgBeneficios = "";
                    });
                ArmarProgramasBelcorp(data.lista);
            }
        },
        error: function (data, error) { }
    });
}
function ArmarProgramasBelcorp(data) {
    data = EstructurarDataProgramasBelcorp(data);
    var htmlDiv = SetHandlebars("#ProgramasBelcorp-template", data);
    var imgIncentivos = urlS3Raiz + "MisBeneficios/" + codigoISO_MB + "/incentivos.png";
    //Se agrega item VER MAS
    if (htmlDiv.length > 0) {
        htmlDiv += [
             '<div class="items_misBeneficios">',
                    '<div class="contenedor_item_img">',
                        '<img class="item_img" src="' + imgIncentivos + '" alt="Alternate Text" />',
                        '<span class="item_titulo"><b>INCENTIVOS</b></span>',
                    '</div>',
                    '<div class="contenedor_item_descripcion">',
                        '<span>',
                            '<b>Los premios están más cerca de lo que piensas…</b>',
                        '</span>',
                        '<a href="' + urlIncentivos + '" title="DESCÚBRELOS AQUÍ">DESCÚBRELOS AQUÍ</a>',
                    '</div>',
             '</div>'
        ].join("\n");
    };

    $('#contenidoProgramasBelcorp').empty().append(htmlDiv);
}
function EstructurarDataProgramasBelcorp(array) {
    $.each(array, function (i, item) {
        if (item.Descripcion.trim() == "Brillante 2016") {
            item.urlImgBeneficios = urlS3Raiz + "MisBeneficios/" + codigoISO_MB + "/brillante.png";
            item.DetalleDesripcion = "Todo lo que logras merece un reconocimiento </br><b>¡y una gran celebración!</b>";
            item.Descripcion = "<b>BRILLANTE</b> " + anioActual;
        } else if (item.Descripcion.trim() == "Familia Protegida" || (codigoISO_MB == 'EC' && item.Descripcion == 'Familia Primero')) {
            item.Descripcion = "";
            item.urlImgBeneficios = urlS3Raiz + "MisBeneficios/" + codigoISO_MB + "/familiaprotegida.png";
            item.DetalleDesripcion = "Programa de ayuda económica para ti, tus hijos y esposo en caso de hospitalización y fallecimiento.";
        } else if (item.Descripcion.trim() == "Flexipago") {
            item.Descripcion = "";
            item.urlImgBeneficios = urlS3Raiz + "MisBeneficios/" + codigoISO_MB + "/flexipago.png";
            item.DetalleDesripcion = "El crédito de Belcorp que te permitirá pasar pedidos más grandes y poder pagarlos hasta en 3 partes.";
        } else if (item.Descripcion.trim() == "Programa Nuevas") {
            item.urlImgBeneficios = urlS3Raiz + "MisBeneficios/" + codigoISO_MB + "/programanuevas.png";
            item.DetalleDesripcion = "<b>Gana desde el comienzo</b> con las mejores herramientas para tu negocio: productos ganadores, demostradores, fichas de los TOP de Ésika y más.";
            item.Descripcion = "PROGRAMA <b>NUEVAS</b>";
        }
    });

    return array;
}