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
            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            Codigo = row["Codigo"].ToString();
            Anio = Convert.ToInt32(row["Anio"]);
            NombreCorto = row["NombreCorto"].ToString();
            PaisID = Convert.ToInt32(row["PaisID"]);
            Activo = Convert.ToBoolean(row["Activo"]);
        }
    }
}
