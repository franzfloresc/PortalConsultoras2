using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoNivel
    {
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public int CodigoNivel { get; set; }
        [DataMember]
        public int PuntosNivel { get; set; }
        [DataMember]
        public int PuntosFaltantes { get; set; }
        [DataMember]
        public string CodigoPremio { get; set; }
        [DataMember]
        public string DescripcionPremio { get; set; }

        public BEIncentivoNivel(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoConcurso"))
                CodigoConcurso = Convert.ToString(row["CodigoConcurso"]);

            if (DataRecord.HasColumn(row, "CodigoNivel"))
                CodigoNivel = Convert.ToInt32(row["CodigoNivel"]);

            if (DataRecord.HasColumn(row, "PuntosNivel"))
                PuntosNivel = Convert.ToInt32(row["PuntosNivel"]);

            if (DataRecord.HasColumn(row, "PuntosFaltantes"))
                PuntosFaltantes = Convert.ToInt32(row["PuntosFaltantes"]);
        }
    }
}
