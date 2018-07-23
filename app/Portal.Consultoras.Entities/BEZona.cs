using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEZona
    {
        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public int RegionID { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string NombreGerenteZona { get; set; }

        [DataMember]
        public int CantidadDias { get; set; }

        public BEZona() { }
        public BEZona(IDataRecord row)
        {
            ZonaID = Convert.ToInt32(row["ZonaID"]);
            RegionID = Convert.ToInt32(row["RegionID"]);
            Codigo = Convert.ToString(row["Codigo"]);
            Nombre = Convert.ToString(row["Nombre"]);
            NombreGerenteZona = row.ToString("NombreGerenteZona");
            CantidadDias = row.ToInt32("CantidadDias");
        }
    }
}
