using Portal.Consultoras.Common;
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
            RegionID = row.ToInt32("RegionID");
            ZonaID = row.ToInt32("ZonaID");
            TerritorioID = row.ToInt32("TerritorioID");
            Codigo = row.ToString("Codigo");
            Descripcion = row.ToString("Descripcion");
            SeccionID = row.ToInt32("SeccionID");
        }

    }
}
