using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

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
            RegionID = Convert.ToInt32(row["RegionID"]);
            PaisID = Convert.ToInt32(row["PaisID"]);
            Codigo = Convert.ToString(row["Codigo"]);
            Nombre = Convert.ToString(row["Nombre"]);
        }
    }
}
