using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraCodigo
    {
        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        public int RegionID { get; set; }

        public int ZonaID { get; set; }

        public int TerritorioID { get; set; }

        public BEConsultoraCodigo() { }
        public BEConsultoraCodigo(IDataRecord row)
        {
            ConsultoraID = row.GetInt64(0);
            Codigo = row.GetString(1);
            RegionID = row.GetInt32(2);
            ZonaID = row.GetInt32(3);
            TerritorioID = row.GetInt32(4);
        }
    }
}