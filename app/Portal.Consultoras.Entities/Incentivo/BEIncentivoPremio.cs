using Portal.Consultoras.Common;

using System;
using System.Data;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoPremio
    {
        [Column("CodigoConcurso")]
        [DataMember]
        public string CodigoConcurso { get; set; }
        [Column("CodigoNivel")]
        [DataMember]
        public int CodigoNivel { get; set; }
        [Column("CodigoPremio")]
        [DataMember]
        public string CodigoPremio { get; set; }
        [Column("DescripcionPremio")]
        [DataMember]
        public string DescripcionPremio { get; set; }
        [Column("NumeroPremio")]
        [DataMember]
        public int NumeroPremio { get; set; }

        [Obsolete("Use MapUtil.MapToCollection")]
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

            if (DataRecord.HasColumn(row, "NumeroPremio"))
                NumeroPremio = Convert.ToInt32(row["NumeroPremio"]);
        }

        public BEIncentivoPremio()
        {

        }
    }
}
