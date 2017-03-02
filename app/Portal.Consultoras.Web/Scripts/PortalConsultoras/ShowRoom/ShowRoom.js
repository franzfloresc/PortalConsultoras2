/* 
Escritorio  => 1: Index    | 11: Detalle Oferta
Mobile      => 2: Index    | 21: Detalle Oferta
*/
var tipoOrigenPantalla = tipoOrigenPantalla || "";

$(document).ready(function () {
    if (tipoOrigenPantalla == 11) {

        //$('.js-slick-prev').remove();
        //$('.js-slick-next').remove();
        //$('.responsive').slick('unslick');

        $('.responsive').not('.slick-initialized').slick({
            infinite: true,
            vertical: false,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: false,
            speed: 260,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -5%;"><img src="' + baseUrl + 'Content/Images/Esika/previous_ofertas_home.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -5%;text-align:right"><img src="' + baseUrl + 'Content/Images/Esika/next.png")" alt="" /></a>'
        });
        $('.content_carrusel_pop_compra').slick({
            dots: true,
            infinite: true,
            vertical: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: '<a class="previous_ofertas js-slick-prev" style="display: block;left: 0;margin-left: -13%;"><img src="' + baseUrl + 'Content/Images/Esika/left_compra.png")" alt="" /></a>',
            nextArrow: '<a class="previous_ofertas js-slick-next" style="display: block;right: 0;margin-right: -13%; text-align:right;"><img src="' + baseUrl + 'Content/Images/Esika/right_compra.png")" alt="" /></a>'


        });
        $('.content_ficha_compra').slick({
            dots: true,
            infinite: true,
            vertical: true,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            

        });
    }

    $("body").on("click", "[data-btn-agregar-sr]", function (e) {
        var padre = $(this).parents("[data-item]");
        var article = $(padre).find("[data-campos]").eq(0);
        var cantidad = $(padre).find("[data-input='cantidad']").val();
        //listatipo = "0";
        AgregarOfertaShowRoom(article, cantidad);
        e.preventDefault();
        (this).blur();
    });
});

function AgregarOfertaShowRoom(article, cantidad) {
    var CUV = $(article).find(".valorCuv").val();
    var MarcaID = $(article).find(".claseMarcaID").val();
    var PrecioUnidad = $(article).find(".clasePrecioUnidad").val();
    var ConfiguracionOfertaID = $(article).find(".claseConfiguracionOfertaID").val();
    var nombreProducto = $(article).find(".DescripcionProd").val();
    var posicion = $(article).find(".posicionEstrategia").val();
    var descripcionMarca = $(article).find(".DescripcionMarca").val();

    if (cantidad == "" || cantidad == 0) {
        alert_msg("La cantidad ingresada debe ser mayor que 0, verifique.");
    } else {
        waitingDialog({});
        $.ajaxSetup({
            cache: false
        });
        $.getJSON(baseUrl + 'ShowRoom/ValidarUnidadesPermitidasPedidoProducto', { CUV: CUV }, function (data) {
            if (parseInt(data.Saldo) < parseInt(cantidad)) {
                var Saldo = data.Saldo;
                var UnidadesPermitidas = data.UnidadesPermitidas;

                closeWaitingDialog();

                if (Saldo == UnidadesPermitidas)
                    alert_msg("Lamentablemente, la cantidad solicitada sobrepasa las Unidades Permitidas de Venta (" + UnidadesPermitidas + ") del producto.");
                else {
                    if (Saldo == "0")
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted ya no puede adicionar más, debido a que ya agregó este producto a su pedido, verifique.");
                    else
                        alert_msg("Las Unidades Permitidas de Venta son solo (" + UnidadesPermitidas + "), pero Usted solo puede adicionar (" + Saldo + ") más, debido a que ya agregó este producto a su pedido, verifique.");
                }
            } else {
                var Item = {
                    MarcaID: MarcaID,
                    Cantidad: cantidad,
                    PrecioUnidad: PrecioUnidad,
                    CUV: CUV,
                    ConfiguracionOfertaID: ConfiguracionOfertaID
                };

                $.ajaxSetup({ cache: false });

                jQuery.ajax({
                    type: 'POST',
                    url: baseUrl + 'ShowRoom/InsertOfertaWebPortal',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(Item),
                    async: true,
                    success: function (response) {
                        closeWaitingDialog();

                        if (response.success == true) {                            

                            if ($.trim(tipoOrigenPantalla)[0] == '1') {
                                CargarResumenCampaniaHeader(true);

                                //Aparecer Agregado
                                $(article).parents("[data-item]").find(".product-add").css("display", "block");
                            }

                            //AgregarTagManagerProductoAgregadoSW(CUV, nombreProducto, PrecioUnidad, cantidad, descripcionMarca, listatipo);
                            //TrackingJetloreAdd(cantidad, $("#hdCampaniaCodigo").val(), CUV);
                        }
                        else messageInfoError(response.message);
                    },
                    error: function (response, error) {
                        if (checkTimeout(response)) {
                            closeWaitingDialog();
                            console.log(response);
                        }
                    }
                });
            }
        });
    }
}
