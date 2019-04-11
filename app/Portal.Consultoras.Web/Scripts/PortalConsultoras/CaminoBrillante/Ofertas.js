var TabUno = 0;
var TabDos = 0;
var tipoOrigen = "1";
var reservaResponse = {
    data: { Reserva: false }
};
var baseUrl = "/";

$(document).ready(function () {
    CambiarOferta();
    AgregarProducto();
});

$(window).scroll(function (event) {
    if ($("#Tab-kits").hasClass('activado-dorado')) {
        TabUno = $(window).scrollTop();
    }

    if ($("#Tab-Demostradores").hasClass('activado-dorado')) {
        TabDos = $(window).scrollTop();
    }
});

function AgregarProducto() {
    var items = document.getElementsByClassName('boton_Agregalo_home');
    for (var i = 0; i < items.length; i++) {
        items[i].onclick = function (e) {
            e.preventDefault();
            AbrirSplash();

            var cuvCapturado = this.parentElement.parentElement.parentElement.parentElement.children[0].value;
            var cantidadCapturado = this.parentElement.parentElement.children[0].children[0].children[1].value;

            var params = {
                CuvTonos: cuvCapturado,
                CUV: cuvCapturado,
                Cantidad: cantidadCapturado,
                TipoEstrategiaID: 0,
                EstrategiaID: "0",
                OrigenPedidoWeb: "1181901",
                TipoEstrategiaImagen: "6",
                FlagNueva: false,
                EsEditable: false,
                SetId: null,
                ClienteID: 0
            };

            var resultado = e.target;

            jQuery.ajax({
                type: "POST",
                url: baseUrl + "PedidoRegistro/PedidoAgregarProductoTransaction",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                async: true,
                cache: false,
                success: function (data) {
                    if ($("#Tab-kits").hasClass('activado-dorado')) {
                        resultado.parentElement.parentElement.parentElement.lastElementChild.style.display = 'block';
                        //resultado.parentElement.parentElement.parentElement.parentElement.className += " producto_desactivado";
                        var articulos = document.getElementsByClassName('col-12 fichas__productos__wrapper text-center');
                        for (var i = 0; i < articulos[0].childElementCount; i++) {
                            articulos[0].children[i].className += " producto_desactivado"
                        }

                    }
                    CerrarSplash();
                    CargarResumenCampaniaHeader(true);
                },
                error: function (data, error) {
                    alert("error");
                }
            });
        }
    }
}

function CambiarOferta() {
    $('#Tab-kits').click(function () {
        $('#kits').show();
        $('#Demostradores').hide();
        $("#Tab-kits").addClass("activado-dorado");
        $("#Tab-Demostradores").removeClass("activado-dorado");
        $("#divresultadosDemostradores").hide();
        $("#divresultadosKit").show();
        document.body.scrollTop = TabUno;
        $(window).scrollTop(TabUno);
    });

    $('#Tab-Demostradores').click(function () {
        $('#Demostradores').show();
        $('#kits').hide();
        $("#Tab-kits").removeClass("activado-dorado");
        $("#Tab-Demostradores").addClass("activado-dorado");
        $("#divresultadosKit").hide();
        $("#divresultadosDemostradores").show();
        document.body.scrollTop = TabDos;
        $(window).scrollTop(TabDos);
    });
}