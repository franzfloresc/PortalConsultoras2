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
            ZonaID = row.ToInt32("ZonaID");
            RegionID = row.ToInt32("RegionID");
            Codigo = row.ToString("Codigo");
            Nombre = row.ToString("Nombre");
            NombreGerenteZona = row.ToString("NombreGerenteZona");
            CantidadDias = row.ToInt32("CantidadDias");
        }
    }
}
