using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraRegaloProgramaNuevas
    {
        [DataMember]
        [Column("CodigoNivel")]
        public string CodigoNivel { get; set; }

        [DataMember]
        [Column("TippingPoint")]
        public decimal TippingPoint { get; set; }

        [DataMember]
        [Column("CUVPremio")]
        public string CUVPremio { get; set; }

        [DataMember]
        [Column("DescripcionPremio")]
        public string DescripcionPremio { get; set; }

        [DataMember]
        [Column("CodigoSap")]
        public string CodigoSap { get; set; }

        [DataMember]
        [Column("PrecioCatalogo")]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        [Column("PrecioValorizado")]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        [Column("UrlImagenRegalo")]
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
