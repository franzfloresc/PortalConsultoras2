using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConsultoraRegaloProgramaNuevasModel
    {
        public string CodigoIso { get; set; }

        public string CodigoNivel { get; set; }

        public decimal TippingPoint { get; set; }

        public string CUVPremio { get; set; }

        public string DescripcionPremio { get; set; }

        public string CodigoSap { get; set; }

        public decimal PrecioCatalogo { get; set; }

        public decimal PrecioValorizado { get; set; }

        public string UrlImagenRegalo { get; set; }

        public string PrecioCatalogoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioCatalogo, CodigoIso);
            }
        }

        public string PrecioValorizadoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioValorizado, CodigoIso);
            }
        }

        public string TippingPointFormat
        {
            get
            {
                return Util.DecimalToStringFormat(TippingPoint, CodigoIso);
            }
        }

    }
}