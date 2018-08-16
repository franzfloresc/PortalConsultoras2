using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGetRegionByPaisParametroCarga
    {
        [DataMember]
        public int RegionID { set; get; }

        [DataMember]
        public string Codigo { set; get; }

        [DataMember]
        public string Usuario { set; get; }

        public BEGetRegionByPaisParametroCarga()
        { }

        public BEGetRegionByPaisParametroCarga(IDataRecord row)
        {
            RegionID = row.ToInt32("RegionID");
            Codigo = row.ToString("Codigo");
        }

    }
}
