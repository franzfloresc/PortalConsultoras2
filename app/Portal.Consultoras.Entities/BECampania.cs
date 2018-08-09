using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECampania
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public int Anio { get; set; }

        [DataMember]
        public string NombreCorto { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public bool Activo { get; set; }

        public BECampania() { }
        public BECampania(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            Codigo = row.ToString("Codigo");
            Anio = row.ToInt32("Anio");
            NombreCorto = row.ToString("NombreCorto");
            PaisID = row.ToInt32("PaisID");
            Activo = row.ToBoolean("Activo");
        }
    }
}
