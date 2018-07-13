var colorBoton = colorBoton || "";
var tipoOrigenPantalla = tipoOrigenPantalla || 0;

$(document).ready(function () {
    var boton = $("button[type='submit']")[0];
    $(boton).css("background", colorBoton);
    $(boton).css("width", "100%");
    $(boton).css("font-family", "Lato");
    $(boton).css("border-radius", "0%");
    $(boton).css("letter-spacing", "0.5px");

    if (tipoOrigenPantalla == 1)
        $(boton).css("max-width", "308px");

    $(boton).html("PAGA CON VISA");

    $(document).on('click', '#formBoton', function () {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Pago en Línea',
            'action': 'Clic en Botón',
            'label': 'Paga con Visa - Resultado'
        });
    });

    $(document).on('click', '#linkRegresar', function () {
        dataLayer.push({
            'event': 'virtualEvent',
            'category': 'Pago en Línea',
            'action': 'Clic en Botón',
            'label': 'Regresar a Método de Pago'
        });
    });

});