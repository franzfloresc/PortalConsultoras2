var lista;

$(document).ready(function () {
    GetNiveles();
});

function GetNiveles() {
    $.ajax({
        url: "/Mobile/CaminoBrillante/GetNiveles",
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
            //Desactivando según nivel
            if (nivelactual === 1)
                $('#OfertasEspeciales').addClass("desactive");
        }, error: function (xhr, status, error) {

        }
    });
}

function ModalBeneficios(index) {
    $("#ListaBeneficios").empty();
    $("#m_titulo").text(lista.list[index].DescripcionNivel);
    $("#m_montoMinimo").text("Monto mínimo: " + lista.list[index].MontoMinimo);
    var Html = "";
    for (var i = 0; i <= lista.list[index].BeneficiosNivel.length - 1; i++) {
        Html += "<li>";
        Html += "<img src='../Content/CaminoBrillante/imgs/group-14.svg'>";
        Html += "<div class='txt-benf'><p class='text-bold'>" + lista.list[index].BeneficiosNivel[i].Titulo + "</p></div>";
        Html += "</li>";
    }
    $("#ListaBeneficios").append(Html);
}