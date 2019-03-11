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
    }
}
