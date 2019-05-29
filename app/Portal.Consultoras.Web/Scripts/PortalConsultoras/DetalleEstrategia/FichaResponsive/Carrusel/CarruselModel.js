class CarruselModel
{
    constructor(palanca,
        campania,
        cuv,
        urlDataCarrusel,
        OrigenPedidoWeb,
        pantalla,
        tituloCarrusel,
        cantidadPack,
        codigoProducto,
        precioProducto,
        productosHermanos)
    {
        this.palanca = palanca || "";
        this.campania = campania || "";
        this.cuv = cuv || "";
        this.urlDataCarrusel = urlDataCarrusel || "/Estrategia/FichaObtenerProductosUpSellingCarrusel";
        this.OrigenPedidoWeb = OrigenPedidoWeb || "";
        this.pantalla = pantalla;
        this.tituloCarrusel = tituloCarrusel;
        this.cantidadPack = cantidadPack;
        this.codigoProducto = codigoProducto;
        this.precioProducto = precioProducto;
        this.productosHermanos = productosHermanos;
    }
}