using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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

        public string Origen { get; set; }
        public string Palanca { get; set; }
        public bool TieneSession { get; set; }
        public int Campania { get; set; }
        public string Cuv { get; set; }
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