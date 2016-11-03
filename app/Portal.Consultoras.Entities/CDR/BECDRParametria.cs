using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRParametria
    {
        [DataMember]
        public string CodigoParametria { get; set; }
        [DataMember]
        public string DescripcionParametria { get; set; }
        [DataMember]
        public string ValorParametria { get; set; }
        
        public BECDRParametria()
        { }

        public BECDRParametria(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoParametria")) CodigoParametria = Convert.ToString(row["CodigoParametria"]);
            if (DataRecord.HasColumn(row, "DescripcionParametria")) DescripcionParametria = Convert.ToString(row["DescripcionParametria"]);
            if (DataRecord.HasColumn(row, "ValorParametria")) ValorParametria = Convert.ToString(row["ValorParametria"]);
        }
    }
}
