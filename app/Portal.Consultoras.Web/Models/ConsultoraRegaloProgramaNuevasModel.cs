using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConsultoraRegaloProgramaNuevasModel
    {
        public string CodigoNivel { get; set; }
   
        //public string CodigoPrograma { get; set; }
        
        public decimal TippingPoint { get; set; }
        
        public string CUVPremio { get; set; }

        public string DescripcionPremio { get; set; }
        
        public string CodigoSap { get; set; }

        public decimal PrecioCatalogo { get; set; }
        
        public decimal PrecioValorizado { get; set; }
        
        public string UrlImagenRegalo { get; set; }

    }
}