using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
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
            RegionId = row.ToInt32("RegionId");
            RegionCodigo = row.ToString("RegionCodigo");
            RegionNombre = row.ToString("RegionNombre");
            ZonaId = row.ToInt32("ZonaId");
            ZonaCodigo = row.ToString("ZonaCodigo");
            ZonaNombre = row.ToString("ZonaNombre");
        }
    }
}
