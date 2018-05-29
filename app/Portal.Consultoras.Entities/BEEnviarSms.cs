using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEnviarSms
    {
        [DataMember]
        public int OrigenID { get; set; }
        [DataMember]
        public string OrigenDescripcion { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public int CampaniaInicio { get; set; }
        [DataMember]
        public int CampaniaFin { get; set; }
        [DataMember]
        public string Mensaje { get; set; }

        public BEEnviarSms()
        {
        }

        public BEEnviarSms(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "OrigenID") && row["OrigenID"] != DBNull.Value)
                OrigenID = Convert.ToInt32(row["OrigenID"]);
            if (DataRecord.HasColumn(row, "OrigenDescripcion") && row["OrigenDescripcion"] != DBNull.Value)
                OrigenDescripcion = Convert.ToString(row["OrigenDescripcion"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "CampaniaInicio") && row["CampaniaInicio"] != DBNull.Value)
                CampaniaInicio = Convert.ToInt32(row["CampaniaInicio"]);
            if (DataRecord.HasColumn(row, "CampaniaFin") && row["CampaniaFin"] != DBNull.Value)
                CampaniaFin = Convert.ToInt32(row["CampaniaFin"]);
            if (DataRecord.HasColumn(row, "Mensaje") && row["Mensaje"] != DBNull.Value)
                Mensaje = Convert.ToString(row["Mensaje"]);
        }
    }
}
