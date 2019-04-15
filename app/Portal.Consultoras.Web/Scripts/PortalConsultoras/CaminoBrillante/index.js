﻿$(document).ready(function () {
    var nivelactual = $("#hfNivelActual").val();
    for (var i = 1; i <= nivelactual; i++)
        $(".pt" + i).addClass("activo");

    $(".pt" + nivelactual).addClass("brillante");

    $('#OfertasEspeciales').click(function () {
        TagClickBotonVerOfertas();
    });
});

function ModalBeneficios(index) {
    $("#m_montoMinimo").empty();
    $("#m_montoFaltante").empty();
    $("#ListaBeneficios").empty();
    $("#m_titulo").text("");
    $("#m_imagen").attr("src", "");
    $("#ListaBeneficios").empty();
    $("#m_titulo").text("");
    $("#m_imagen").attr("src", "");
    
    var params = { nivel: index };


    $.ajax({
        type: "POST",
        url: urlGetNiveles,
        data: JSON.stringify(params),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            TagClickSeleccionNivel(data.Niveles[0].DescripcionNivel)
            var MontoFaltante = 0;
            var nivelactual = parseInt($("#hfNivelActual").val());
            var nivelSiguiente = nivelactual + 1;

            $("#m_titulo").text(data.Niveles[0].DescripcionNivel);

            if (data.Niveles[0].MontoMinimo >= data.MontoAcumuladoPedido) {
                MontoFaltante  = parseInt(data.Niveles[0].MontoMinimo - data.MontoAcumuladoPedido)
            }

            if ( index == nivelSiguiente ) {
                $("#m_montoMinimo").append("<b>Lo logras con: </b>" + data.Moneda + " " + parseInt(data.Niveles[0].MontoMinimo).toLocaleString() + ".00");
                $("#m_montoFaltante").append("<b>Te falta: </b>" + data.Moneda + " " + MontoFaltante.toLocaleString() + ".00");
            } else {
                $("#m_montoMinimo").append("<b>Los logras con: </b>" + data.Moneda + " " + parseInt(data.Niveles[0].MontoMinimo).toLocaleString() + ".00");
            }
            
            $("#m_imagen").attr("src", data.Niveles[0].UrlImagenNivel.replace("_I", "_A"));
            var Html = "";
            for (var i = 0; i <= data.Niveles[0].Beneficios.length - 1; i++) {

                Html += "<li>";
                Html += "<img src='" + data.Niveles[0].Beneficios[i].Icono + "'>";
                if (data.Niveles[0].Beneficios[i].Descripcion == "" || data.Niveles[0].Beneficios[i].Descripcion == null) {
                    Html += "<div class='txt-benf'><p class='text-bold'><span>" + data.Niveles[0].Beneficios[i].NombreBeneficio + "</span></p></div>";
                } else {
                    Html += "<div class='txt-benf'><p class='text-bold'>" + data.Niveles[0].Beneficios[i].NombreBeneficio + "<span>" + data.Niveles[0].Beneficios[i].Descripcion + "</span></p></div>";
                }
                Html += "</li>";
            }
            $("#ListaBeneficios").append(Html);
            TagMostrarPopupNivel(data.Niveles[0].DescripcionNivel);
        },
        error: function () {
            alert("Error while inserting data");
        }
    });
}

function TagClickSeleccionNivel(nivelConsultora){
    dataLayer.push ({
            'event': 'virtualEvent',
            'category': 'Nivel y beneficios',
            'action': 'Seleccionar nivel',
            'label': 'Nivel: ' + nivelConsultora
        });
}

function TagMostrarPopupNivel(nivelConsultora) {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios',
        'action': 'Ver Pop-up del nivel',
        'label': 'Nivel: ' + nivelConsultora
    });
}

function TagClickBotonVerOfertas() {
    dataLayer.push({
        'event': 'virtualEvent',
        'category': 'Nivel y beneficios–Mis beneficios de nivel',
        'action': 'Selección: Ver Ofertas',
        'label': '(not available)'
    });
}