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
            if (DataRecord.HasColumn(row, "CodigoNivel"))
                CodigoNivel = Convert.ToString(row["CodigoNivel"]);

            if (DataRecord.HasColumn(row, "TippingPoint"))
                TippingPoint = Convert.ToDecimal(row["TippingPoint"]);

            if (DataRecord.HasColumn(row, "CUVPremio"))
                CUVPremio = Convert.ToString(row["CUVPremio"]);

            if (DataRecord.HasColumn(row, "DescripcionPremio"))
                DescripcionPremio = Convert.ToString(row["DescripcionPremio"]);

            if (DataRecord.HasColumn(row, "CodigoSap"))
                CodigoSap = Convert.ToString(row["CodigoSap"]);

            if (DataRecord.HasColumn(row, "PrecioCatalogo"))
                PrecioCatalogo = Convert.ToDecimal(row["PrecioCatalogo"]);

            if (DataRecord.HasColumn(row, "PrecioValorizado"))
                PrecioValorizado = Convert.ToDecimal(row["PrecioValorizado"]);
        }
    }
}
