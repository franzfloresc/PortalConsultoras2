using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class DetalleEstrategiaFichaModel : EstrategiaPersonalizadaProductoModel
    {
        //hacer el seguimiento.
        public List<TituloDetalle> DetallesProducto { get; set; } //Pestana detalles de la ficha detalle del CUV
        public List<TituloDetalle> DetallesPack { get; set; } //Pestana detalles del pack
        public List<TipVenta> TipsVentas { get; set; } //Pestana Tips Ventas de la ficha detalle del CUV
        public List<TituloDetalle> Beneficios { get; set; } //Pestana beneficios
        public String CodigoVideo { get; set; } //Por defecto 1 video
        public string OrigenUrl { get; set; }
        public int OrigenAgregar { get; set; }
        public string Palanca { get; set; }
        public bool TieneSession { get; set; }
        public int Campania { get; set; }
        public string Cuv { get; set; }
        public bool TieneReloj { get; set; }
        public bool TieneCarrusel { get; set; }
        public double TeQuedan { get; set; }
        public string ColorFondo1 { get; set; }
        public ConfiguracionSeccionHomeModel ConfiguracionContenedor { get; set; }
    }
    public class TituloDetalle
    {
        string Titulo { get; set; }
        string TextoLargo { get; set; }
    }
    public class TipVenta
    {
        string RutaImagen { get; set; }
        string TextoTip { get; set; }
    }
}