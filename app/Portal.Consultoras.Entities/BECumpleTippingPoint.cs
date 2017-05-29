using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECumpleTippingPOint
    {
        [DataMember]
        public int Result { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public decimal TippingPoint { get; set; }
        [DataMember]
        public string CUVPremio { get; set; }
        [DataMember]
        public string CodigoSap { get; set; }

        public BECumpleTippingPOint()
        {

        }

        public BECumpleTippingPOint(IDataRecord row)
        {
            Result = Convert.ToInt16(row["Result"]);

            if (DataRecord.HasColumn(row, "CodigoNivel"))
                CodigoNivel = Convert.ToString(row["CodigoNivel"]);
            if (DataRecord.HasColumn(row, "TippingPoint"))
                TippingPoint = Convert.ToDecimal(row["TippingPoint"]);
            if (DataRecord.HasColumn(row, "CUVPremio"))
                CUVPremio = Convert.ToString(row["CUVPremio"]);
            if (DataRecord.HasColumn(row, "CodigoSap"))
                CodigoSap = Convert.ToString(row["CodigoSap"]);
        }
    }
}
