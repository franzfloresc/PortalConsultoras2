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
            RegionID = row.ToInt32("RegionID");
            ZonaID = row.ToInt32("ZonaID");
            OlvideContrasenya = row.ToBoolean("OlvideContrasenya");
            VerifAutenticidad = row.ToBoolean("VerifAutenticidad");
            ActualizarDatos = row.ToBoolean("ActualizarDatos");
            CDR = row.ToBoolean("CDR");
        }
    }
}
