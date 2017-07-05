using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

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
