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
            lista = data;
            //Inicio: Barra de niveles
            var nivelactual = data.Nivel;
            var NivelIndice = parseInt(nivelactual) - 1;
            var Html = "<div class='Progress medal-" + nivelactual + "' id='indicadorNivel'></div>";
            var estilo;
            for (var i = 0; i <= data.list.Niveles.length - 1; i++) {
                estilo = parseInt(i) + parseInt(1);
                estilo = parseInt(estilo);
                if (estilo <= nivelactual)
                    Html += "<span class='point pt" + estilo + "'>";
                else
                    Html += "<span class='point pt" + estilo + "' onclick='ModalBeneficios(" + i + ")' data-toggle='modal' data-target='#BenefNivel'>";
                Html += "<img src='" + data.list.Niveles[i].UrlImagenNivel + "' class='activa'>";
                Html += "<em>" + data.list.Niveles[i].DescripcionNivel + "</em>";
                Html += "</span>";
            }
            $("#ProgressBar").append(Html);
            for (var i = 1; i <= nivelactual; i++)
                $(".pt" + i).addClass("activo");

            $(".pt" + nivelactual).addClass("brillante");
            //Fin

            //Inicio: Agregando lista de beneficios en la pagina principal
            $("#BeneficiosPrincipal").empty();
            var index = nivelactual - 1;
            var htmlBeneficios = "<h2 class='title'>Mis beneficios</h2>";
            //htmlBeneficios += "<p class='text'>Todos los beneficios que tienes actualmente en tu nivel</p>";
            htmlBeneficios += "<ul class='box-beneficios' id='BeneficiosPrincipal'>";
            for (var i = 0; i <= data.list.Niveles[index].Beneficios.length - 1; i++) {

                htmlBeneficios += "<li>";
                htmlBeneficios += "<img src='/Content/CaminoBrillante/imgs/group-14.svg'>";
                htmlBeneficios += "<div class='txt-benf'><p class='text-bold'>" + data.list.Niveles[index].Beneficios[i].Descripcion + "<span>" + data.list.Niveles[index].Beneficios[i].NombreBeneficio + "</span></p></div>";
                htmlBeneficios += "</li>";
            }
            htmlBeneficios += "</ul>";
            $("#BeneficiosPrincipal").append(htmlBeneficios);
            //Fin
        }, error: function (xhr, status, error) {

        }
    });
}

function ModalBeneficios(index) {
    $("#m_montoMinimo").empty();
    $("#ListaBeneficios").empty();
    $("#m_titulo").text(lista.list.Niveles[index].DescripcionNivel);
    $("#m_montoMinimo").append("Monto mínimo: <span>S/ " + lista.list.Niveles[index].MontoMinimo + ".00</span>");
    $("#m_imagen").attr("src", lista.list.Niveles[index].UrlImagenNivel.replace("_I", "_A"));
    var Html = "";
    for (var i = 0; i <= lista.list.Niveles[index].Beneficios.length - 1; i++) {
        Html += "<li>";
        Html += "<img src='/Content/CaminoBrillante/imgs/group-14.svg'>";
        Html += "<div class='txt-benf'><p class='text-bold'>" + lista.list.Niveles[index].Beneficios[i].Descripcion + "<span>" + lista.list.Niveles[index].Beneficios[i].NombreBeneficio + "</span></p></div>";
        Html += "</li>";
    }
    $("#ListaBeneficios").append(Html);
}