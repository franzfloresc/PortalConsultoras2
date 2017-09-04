using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoPremio
    {
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public int CodigoNivel { get; set; }
        [DataMember]
        public string CodigoPremio { get; set; }
        [DataMember]
        public string DescripcionPremio { get; set; }

        public BEIncentivoPremio(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConcurso"))
                CodigoConcurso = Convert.ToString(row["CodigoConcurso"]);

            if (DataRecord.HasColumn(row, "CodigoNivel"))
                CodigoNivel = Convert.ToInt32(row["CodigoNivel"]);

            if (DataRecord.HasColumn(row, "CodigoPremio"))
                CodigoPremio = Convert.ToString(row["CodigoPremio"]);

            if (DataRecord.HasColumn(row, "DescripcionPremio"))
                DescripcionPremio = Convert.ToString(row["DescripcionPremio"]);
        }
    }
}
