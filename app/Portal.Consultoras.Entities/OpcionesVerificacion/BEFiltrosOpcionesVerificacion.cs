using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.OpcionesVerificacion
{
    [DataContract]
    public class BEFiltrosOpcionesVerificacion
    {
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public int CampaniaInicio { get; set; }
        [DataMember]
        public int CampaniaFinal { get; set; }
        [DataMember]
        public string MensajeSaludo { get; set; }

        public BEFiltrosOpcionesVerificacion()
        { }

        public BEFiltrosOpcionesVerificacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "CampaniaInicio") && row["CampaniaInicio"] != DBNull.Value)
                CampaniaInicio = Convert.ToInt32(row["CampaniaInicio"]);
            if (DataRecord.HasColumn(row, "CampaniaFinal") && row["CampaniaFinal"] != DBNull.Value)
                CampaniaFinal = Convert.ToInt32(row["CampaniaFinal"]);
            if (DataRecord.HasColumn(row, "MensajeSaludo") && row["MensajeSaludo"] != DBNull.Value)
                MensajeSaludo = Convert.ToString(row["MensajeSaludo"]);
        }
    }
}
