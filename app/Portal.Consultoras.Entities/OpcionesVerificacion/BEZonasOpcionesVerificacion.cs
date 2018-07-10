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
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public bool OlvideContrasenya { get; set; }
        [DataMember]
        public bool VerifAutenticidad { get; set; }
        [DataMember]
        public bool ActualizarDatos { get; set; }
        [DataMember]
        public bool CDR { get; set; }
        
        public BEZonasOpcionesVerificacion()
        { }

        public BEZonasOpcionesVerificacion(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "RegionID") && row["RegionID"] != DBNull.Value)
                RegionID = Convert.ToInt32(row["RegionID"]);
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
            if (DataRecord.HasColumn(row, "OlvideContrasenya") && row["OlvideContrasenya"] != DBNull.Value)
                OlvideContrasenya = Convert.ToBoolean(row["OlvideContrasenya"]);
            if (DataRecord.HasColumn(row, "VerifAutenticidad") && row["VerifAutenticidad"] != DBNull.Value)
                VerifAutenticidad = Convert.ToBoolean(row["VerifAutenticidad"]);
            if (DataRecord.HasColumn(row, "ActualizarDatos") && row["ActualizarDatos"] != DBNull.Value)
                ActualizarDatos = Convert.ToBoolean(row["ActualizarDatos"]);
            if (DataRecord.HasColumn(row, "CDR") && row["CDR"] != DBNull.Value)
                CDR = Convert.ToBoolean(row["CDR"]);
        }
    }
}
