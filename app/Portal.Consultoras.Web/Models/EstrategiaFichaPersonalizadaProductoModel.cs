using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class EstrategiaFichaPersonalizadaProductoModel : EstrategiaPersonalizadaProductoModel
    {
        //hacer el seguimiento.
        List<TituloDetalle> DetallesProducto { get; set; } //Pestana detalles de la ficha detalle del CUV
        List<TituloDetalle> DetallesPack { get; set; } //Pestana detalles del pack
        List<TipVenta> TipsVentas { get; set; } //Pestana Tips Ventas de la ficha detalle del CUV
        List<TituloDetalle> Beneficios { get; set; } //Pestana beneficios
        List<String> RutaVideos { get; set; } //Por defecto 1 video

    }
    class TituloDetalle
    {
        string Titulo { get; set; }
        string TextoLargo { get; set; }
    }
    class TipVenta
    {
        string RutaImagen { get; set; }
        string TextoTip { get; set; }
    }
}