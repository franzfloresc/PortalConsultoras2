using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.OpcionesVerificacion
{
    [DataContract]
    public class BEZonasOpcionesVerificacion
    {
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public bool Activo { get; set; }
        [DataMember]
        public int OrigenID { get; set; }

        public BEZonasOpcionesVerificacion()
        { }

        public BEZonasOpcionesVerificacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "Activo") && row["Activo"] != DBNull.Value)
                Activo = Convert.ToBoolean(row["Activo"]);
            if (DataRecord.HasColumn(row, "OrigenID") && row["OrigenID"] != DBNull.Value)
                OrigenID = Convert.ToInt32(row["OrigenID"]);
        }
    }
}