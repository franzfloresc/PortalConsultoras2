using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaDelDiaModel
    {
        public string CodigoIso { get; set; }
        public TimeSpan TeQuedan { get; set; }
        public string ImagenPatron1 { get; set; }
        public string ColorFondo1 { get; set; }
        public string ImagenBanner { get; set; }
        public string ImagenPatron2 { get; set; }
        public string ColorFondo2 { get; set; }
        public string ImagenDisplay { get; set; }
        public string NombreOferta { get; set; }
        public decimal PrecioOferta { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string DescripcionOferta { get; set; }
        public int Cantidad { get; set; }
        public int LimiteVenta { get; set; }

        public string PrecioOfertaFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioOferta, CodigoIso);
            }
        }

        public string PrecioCatalogoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioCatalogo, CodigoIso);
            }
        }
    }
}