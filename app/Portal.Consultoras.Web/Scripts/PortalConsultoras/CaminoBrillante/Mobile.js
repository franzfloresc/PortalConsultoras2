var lista;

$(document).ready(function () {
    GetNiveles();
});

function GetNiveles() {
    $.ajax({
        url: "/CaminoBrillante/GetNiveles",
        type: "GET",
        dataType: "json",
        success: function (data) {
            var nivelactual = data.NivelActual;
            lista = data;
            var Html = "<div class='Progress medal-" + nivelactual + "' id='indicadorNivel'></div>";
            var estilo;
            for (var i = 0; i <= data.list.length - 1; i++) {
                estilo = parseInt(i) + parseInt(1);
                estilo = parseInt(estilo);
                if (estilo <= nivelactual)
                    Html += "<span class='point pt" + estilo + "'>";
                else
                    Html += "<span class='point pt" + estilo + "' onclick='ModalBeneficios(" + i + ")' data-toggle='modal' data-target='#BenefNivel'>";
                Html += "<em>" + data.list[i].DescripcionNivel + "</em>";
                Html += "</span>";
            }
            $("#ProgressBar").append(Html);
            for (var i = 1; i <= nivelactual; i++)
                $(".pt" + i).addClass("activo");
            $(".pt" + nivelactual).addClass("brillante");

            //Agregando lista de beneficios en la pagina principal
            $("#BeneficiosPrincipal").empty();
            var index = nivelactual - 1;

            var htmlBeneficios = "<h2 class='title'>MIS BENEFICIOS DE NIVEL</h2>";
            htmlBeneficios += "<p class='text'>Todos los beneficios que tienes actualmente en tu nivel</p>";
            htmlBeneficios += "<ul class='box-beneficios' id='BeneficiosPrincipal'>";
            for (var i = 0; i <= data.list[index].BeneficiosNivel.length - 1; i++) {
                htmlBeneficios += "<li>";
                htmlBeneficios += "<img src='/Content/CaminoBrillante/imgs/group-14.svg'>";
                htmlBeneficios += "<div class='txt-benf'><p class='text-bold'>" + data.list[index].BeneficiosNivel[i].Titulo + "<span>" + data.list[index].BeneficiosNivel[i].Descripcion + "</span></p></div>";
                htmlBeneficios += "</li>";
            }
            htmlBeneficios += "</ul>";
            //Desactivando según nivel
            if (nivelactual === 1) {
                //.hide();
                $('#OfertasEspeciales').addClass("OfertasEspecialesBlock");
                htmlBeneficios += "<br />";
            }
            $("#BeneficiosPrincipal").append(htmlBeneficios);

        }, error: function (xhr, status, error) {

        }
    });
}

function ModalBeneficios(index) {
    $("#m_montoMinimo").empty();
    $("#ListaBeneficios").empty();
    $("#m_titulo").text(lista.list[index].DescripcionNivel);
    $("#m_montoMinimo").append("Monto mínimo: <span>S/ " + lista.list[index].MontoMinimo + ".00</span>");

    if (index === 0)
        $("#m_imagen").attr("src", "/Content/CaminoBrillante/imgs/image-1@2x.png");

    if (index === 1)
        $("#m_imagen").attr("src", "/Content/CaminoBrillante/imgs/recurso-29-3-x-copy-3@2x.png");

    if (index === 2)
        $("#m_imagen").attr("src", "/Content/CaminoBrillante/imgs/recurso-30-3-x-copy-4@2x.png");

    if (index === 3)
        $("#m_imagen").attr("src", "/Content/CaminoBrillante/imgs/recurso-36-3-x@2x.png");

    if (index === 4)
        $("#m_imagen").attr("src", "/Content/CaminoBrillante/imgs/recurso-28-3-x-copy-2@2x.png");

    if (index === 5)
        $("#m_imagen").attr("src", "/Content/CaminoBrillante/imgs/recurso-27-3-x@2x.png");


    var Html = "";
    for (var i = 0; i <= lista.list[index].BeneficiosNivel.length - 1; i++) {
        Html += "<li>";
        Html += "<img src='/Content/CaminoBrillante/imgs/group-14.svg'>";
        Html += "<div class='txt-benf'><p class='text-bold'>" + lista.list[index].BeneficiosNivel[i].Titulo + "<span>" + lista.list[index].BeneficiosNivel[i].Descripcion + "</span></p></div>";
        Html += "</li>";
    }
    $("#ListaBeneficios").append(Html);
}