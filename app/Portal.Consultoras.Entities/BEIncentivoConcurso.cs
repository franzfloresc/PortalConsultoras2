using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEIncentivoConcurso
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int CampaniaIDInicio { get; set; }
        [DataMember]
        public int CampaniaIDFin { get; set; }
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public string TipoConcurso { get; set; }
        [DataMember]
        public int PuntosAcumulados { get; set; }
        [DataMember]
        public List<BEIncentivoNivel> Niveles { get; set; }

        public BEIncentivoConcurso(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);

            if (DataRecord.HasColumn(row, "CampaniaIDInicio"))
                CampaniaIDInicio = Convert.ToInt32(row["CampaniaIDInicio"]);

            if (DataRecord.HasColumn(row, "CampaniaIDFin"))
                CampaniaIDFin = Convert.ToInt32(row["CampaniaIDFin"]);

            if (DataRecord.HasColumn(row, "CodigoConcurso"))
                CodigoConcurso = Convert.ToString(row["CodigoConcurso"]);

            if (DataRecord.HasColumn(row, "TipoConcurso"))
                TipoConcurso = Convert.ToString(row["TipoConcurso"]);

            if (DataRecord.HasColumn(row, "PuntosAcumulados"))
                PuntosAcumulados = Convert.ToInt32(row["PuntosAcumulados"]);
        }
    }
}
