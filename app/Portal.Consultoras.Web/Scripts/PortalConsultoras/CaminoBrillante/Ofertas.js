var tipoOrigen = "1";
var reservaResponse = {
    data: { Reserva: false }
};
var baseUrl = "/";

function AgregarProducto() {


    var items = document.getElementsByClassName('boton_Agregalo_home boton__agregalo--fichaProducto text-center d-block FichaAgregarProductoBuscador');

    for (var i = 0; i < items.length; i++) {
        items[i].onclick = function (e) {
            e.preventDefault();
            AbrirSplash();
            debugger;
            var cuvCapturado = this.parentElement.parentElement.parentElement.parentElement.children[0].value;
            var cantidadCapturado = this.parentElement.parentElement.children[0].children[0].children[1].value;

            var params = {
                CuvTonos: cuvCapturado,
                CUV: cuvCapturado,
                Cantidad: cantidadCapturado,
                TipoEstrategiaID: 3014,
                EstrategiaID: "34076",
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
                    //dfd.resolve(data);
                    resultado.parentElement.parentElement.parentElement.lastElementChild.style.display = 'block';
                    CerrarSplash();
                    CargarResumenCampaniaHeader(true);

                },
                error: function (data, error) {
                    alert("error");
                    // dfd.reject(data, error);
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
    });


    $('#Tab-Demostradores').click(function () {
        $('#Demostradores').show();
        $('#kits').hide();

        $("#Tab-kits").removeClass("activado-dorado");
        $("#Tab-Demostradores").addClass("activado-dorado");
        $("#divresultadosKit").hide();
        $("#divresultadosDemostradores").show();
    });
}