using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    //RQ_SB - R2133
    [DataContract]
    public class BEZonificacionJerarquia
    {
        [DataMember]
        public int RegionId { set; get; }
        [DataMember]
        public string RegionCodigo { set; get; }
        [DataMember]
        public string RegionNombre { set; get; }
        [DataMember]
        public int ZonaId { set; get; }
        [DataMember]
        public string ZonaCodigo { set; get; }
        [DataMember]
        public string ZonaNombre { set; get; }

        public BEZonificacionJerarquia()
        { 
        
        }

        public BEZonificacionJerarquia(IDataRecord row)
        {
            RegionId = Convert.ToInt32(row["RegionId"]);
            RegionCodigo = Convert.ToString(row["RegionCodigo"]);
            RegionNombre = Convert.ToString(row["RegionNombre"]);
            ZonaId = Convert.ToInt32(row["ZonaId"]);
            ZonaCodigo = Convert.ToString(row["ZonaCodigo"]);
            ZonaNombre = Convert.ToString(row["ZonaNombre"]);
        }
    }
}
