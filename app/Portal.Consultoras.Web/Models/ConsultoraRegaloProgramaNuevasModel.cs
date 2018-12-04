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
        public string DescripcionPremio { get; set; }        
        public decimal PrecioValorizado { get; set; }
        public string UrlImagenRegalo { get; set; }

        public string PrecioValorizadoFormat
        {
            get
            {
                return Util.DecimalToStringFormat(PrecioValorizado, CodigoIso);
            }
        }
    }
}