"use strict";
class CarruselModel
{
    constructor(palanca,
        campania,
        cuv,
        urlDataCarrusel,
        origenPedidoWeb,
        origenAgregarCarrusel,
        tituloCarrusel,
        codigoProducto,
        precioProducto,
        productosHermanos,
        tieneStock)
    {
        this.palanca = palanca || "";
        this.campania = campania || "";
        this.cuv = cuv || "";
        this.urlDataCarrusel = urlDataCarrusel || "";
        this.origenPedidoWeb = origenPedidoWeb || "";
        this.origenAgregarCarrusel = origenAgregarCarrusel || "";
        this.tituloCarrusel = tituloCarrusel;
        this.codigoProducto = codigoProducto;
        this.precioProducto = precioProducto;
        this.productosHermanos = productosHermanos;
        this.tieneStock = tieneStock;
    }
}