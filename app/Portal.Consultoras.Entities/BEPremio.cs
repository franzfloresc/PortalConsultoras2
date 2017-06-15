using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPremio
    {
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Mensaje { get; set; }
        [DataMember]
        public string CodigoConcurso { get; set; }
        [DataMember]
        public int PuntajeMinimo { get; set; }
        [DataMember]
        public int NumeroNivel { get; set; }

        public BEPremio(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "COD_PREM"))
                Codigo = Convert.ToString(row["COD_PREM"]);

            if (DataRecord.HasColumn(row, "DES_PROD"))
                Descripcion = Convert.ToString(row["DES_PROD"]);

            if (DataRecord.HasColumn(row, "COD_CONC"))
                CodigoConcurso = Convert.ToString(row["COD_CONC"]);

            if (DataRecord.HasColumn(row, "PUN_MINI"))
                PuntajeMinimo = Convert.ToInt32(row["PUN_MINI"]);

            if (DataRecord.HasColumn(row, "NUM_NIVE"))
                NumeroNivel = Convert.ToInt32(row["NUM_NIVE"]);
        }
    }
}
