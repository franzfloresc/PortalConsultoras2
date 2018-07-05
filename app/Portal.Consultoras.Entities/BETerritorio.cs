using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETerritorio
    {
        [DataMember]
        public int RegionID { get; set; }

        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public int TerritorioID { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public int SeccionID { get; set; }

        public BETerritorio() { }
        public BETerritorio(IDataRecord row)
        {
            RegionID = Convert.ToInt32(row["RegionID"]);
            ZonaID = Convert.ToInt32(row["ZonaID"]);
            TerritorioID = Convert.ToInt32(row["TerritorioID"]);
            Codigo = row["Codigo"].ToString();
            Descripcion = row["Descripcion"].ToString();
            SeccionID = Convert.ToInt32(row["SeccionID"]);
        }

    }
}