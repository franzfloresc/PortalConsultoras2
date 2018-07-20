using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraRegaloProgramaNuevas
    {
        [DataMember]
        public string CodigoNivel { get; set; }

        [DataMember]
        public decimal TippingPoint { get; set; }

        [DataMember]
        public string CUVPremio { get; set; }

        [DataMember]
        public string DescripcionPremio { get; set; }

        [DataMember]
        public string CodigoSap { get; set; }

        [DataMember]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        public string UrlImagenRegalo { get; set; }

        public BEConsultoraRegaloProgramaNuevas() { }

        public BEConsultoraRegaloProgramaNuevas(IDataRecord row)
        {
            CodigoNivel = row.ToString("CodigoNivel");
            TippingPoint = row.ToDecimal("TippingPoint");
            CUVPremio = row.ToString("CUVPremio");
            DescripcionPremio = row.ToString("DescripcionPremio");
            CodigoSap = row.ToString("CodigoSap");
            PrecioCatalogo = row.ToDecimal("PrecioCatalogo");
            PrecioValorizado = row.ToDecimal("PrecioValorizado");
        }
    }
}
