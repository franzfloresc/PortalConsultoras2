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
            var htmlBeneficios = "<h2 class='title'>MIS BENEFICIOS DE NIVEL</h2>";
            htmlBeneficios += "<p class='text'>Todos los beneficios que tienes actualmente en tu nivel</p>";
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

            //Desactivando botón para el primer nivel
            if (nivelactual === 1) {
                $('#OfertasEspeciales').addClass("OfertasEspecialesBlock");
                htmlBeneficios += "<br />";
            }
            //Fin

            //==========================================    LOGROS  =================================================
            //$("#Carusel-Logros").empty();
            $('#TituloLogros').append(data.list.ResumenLogros.Titulo);
            $('#DescripcionLogros').append(data.list.ResumenLogros.Descripcion);
            for (var i = 0; i <= data.list.ResumenLogros.Indicadores.length - 1; i++) {
                var HtmlLogros = '';
                HtmlLogros += '<div class="owl-item">';
                HtmlLogros += '<div class="item">';
                HtmlLogros += '<div class="shad box-' + data.list.ResumenLogros.Indicadores[i].Titulo + '">';
                HtmlLogros += '<p class="text-bold">' + data.list.ResumenLogros.Indicadores[i].Titulo + '</p>';
                HtmlLogros += '<span class="text-down">' + data.list.ResumenLogros.Indicadores[i].Descripcion + '</span>';
                HtmlLogros += '<ul class="list-crec">';

                for (var medalla = 0; medalla <= data.list.ResumenLogros.Indicadores[i].Medallas.length - 1; medalla++) {
                    HtmlLogros += '<li>';
                    HtmlLogros += '<div class="circle-porcent cinco">';
                    HtmlLogros += '<span>' + data.list.ResumenLogros.Indicadores[i].Medallas[medalla].Valor  + '</span>';
                    HtmlLogros += '</div>';
                    HtmlLogros += '<p>' + data.list.ResumenLogros.Indicadores[i].Medallas[medalla].Titulo + '</p>';
                    HtmlLogros += '</li>';  
                }
                HtmlLogros += '</ul>';
                HtmlLogros += '<a href="" class="btn-link">Ver todos</a>';
                HtmlLogros += '</div>';
                HtmlLogros += '</div>';
                HtmlLogros += '</div>';
                //$("#Carusel-Logros").append(HtmlLogros);
                $(".owl-stage").append(HtmlLogros);             
                //$(".owl-stage").css({"transform": "translate3d(0px, 0px, 0px)", "transition": "all 0.25s ease 0s", "padding-left": "35px", "padding-right": "35px" });
            }
        }, error: function (xhr, status, error) {

        }
    });
}

function ModalBeneficios(index) {
    $("#m_montoMinimo").empty();
    $("#ListaBeneficios").empty();
    $("#m_titulo").text(lista.list.Niveles[index].DescripcionNivel);
    $("#m_imagen").attr("src", lista.list.Niveles[index].UrlImagenNivel);
    $("#m_montoMinimo").append("Monto mínimo: <span>S/ " + lista.list.Niveles[index].MontoMinimo + ".00</span>");

    var Html = "";
    for (var i = 0; i <= lista.list.Niveles[index].Beneficios.length - 1; i++) {
        Html += "<li>";
        Html += "<img src='/Content/CaminoBrillante/imgs/group-14.svg'>";
        Html += "<div class='txt-benf'><p class='text-bold'>" + lista.list.Niveles[index].Beneficios[i].Descripcion + "<span>" + lista.list.Niveles[index].Beneficios[i].NombreBeneficio + "</span></p></div>";
        Html += "</li>";
    }
    $("#ListaBeneficios").append(Html);
}