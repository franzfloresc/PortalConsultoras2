using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BERegion
    {
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Nombre { get; set; }

        public BERegion() { }
        public BERegion(IDataRecord row)
        {
            RegionID = row.ToInt32("RegionID");
            PaisID = row.ToInt32("PaisID");
            Codigo = row.ToString("Codigo");
            Nombre = row.ToString("Nombre");
        }
    }
}
