"use strict";
class CarruselModel
{
    constructor(palanca,
        campania,
        cuv,
        urlDataCarrusel,
        origenPedidoWeb,
        pantalla,
        tituloCarrusel,
        cantidadPack,
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
        this.pantalla = pantalla;
        this.tituloCarrusel = tituloCarrusel;
        this.cantidadPack = cantidadPack;
        this.codigoProducto = codigoProducto;
        this.precioProducto = precioProducto;
        this.productosHermanos = productosHermanos;
        this.tieneStock = tieneStock;
    }
}