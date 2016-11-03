using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRTipoOperacion
    {
        [DataMember]
        public string CodigoOperacion { get; set; }
        [DataMember]
        public string DescripcionOperacion { get; set; }
        [DataMember]
        public decimal NumeroDiasAtrasOperacion { get; set; }

        public BECDRTipoOperacion()
        { }

        public BECDRTipoOperacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoOperacion")) CodigoOperacion = Convert.ToString(row["CodigoOperacion"]);
            if (DataRecord.HasColumn(row, "DescripcionOperacion")) DescripcionOperacion = Convert.ToString(row["DescripcionOperacion"]);
            if (DataRecord.HasColumn(row, "NumeroDiasAtrasOperacion")) NumeroDiasAtrasOperacion = Convert.ToDecimal(row["NumeroDiasAtrasOperacion"]);
        }
    }
}
