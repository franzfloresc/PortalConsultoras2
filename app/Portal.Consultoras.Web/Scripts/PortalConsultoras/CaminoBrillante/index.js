$(document).ready(function () {
    var nivelactual = $("#hfNivelActual").val();

    for (var i = 1; i <= nivelactual; i++)
        $(".pt" + i).addClass("activo");

    $(".pt" + nivelactual).addClass("brillante");


});

function ModalBeneficios(index) {
    $("#m_montoMinimo").empty();
    $("#ListaBeneficios").empty();
    $("#m_titulo").text("");
    $("#m_imagen").attr("src", "");

    $.ajax({
        url: "/CaminoBrillante/GetNiveles",
        type: "GET",
        dataType: "json",
        success: function (data) {
            
            $("#m_titulo").text(data.Niveles[index].DescripcionNivel);
            $("#m_montoMinimo").append("Monto mínimo: <span>S/ " + data.Niveles[index].MontoMinimo + ".00</span>");
            $("#m_imagen").attr("src", data.Niveles[index].UrlImagenNivel.replace("_I", "_A"));
            var Html = "";

            for (var i = 0; i <= data.Niveles[index].Beneficios.length - 1; i++) {
                debugger;
                Html += "<li>";
                Html += "<img src='" + data.Niveles[index].Beneficios[i].Icono + "'>";
                Html += "<div class='txt-benf'><p class='text-bold'>" + data.Niveles[index].Beneficios[i].Descripcion + "<span>" + data.Niveles[index].Beneficios[i].NombreBeneficio + "</span></p></div>";
                Html += "</li>";
            }
            $("#ListaBeneficios").append(Html);

        }, error: function (xhr, status, error) {

        }
    });
}