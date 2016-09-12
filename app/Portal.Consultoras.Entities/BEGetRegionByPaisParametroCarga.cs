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
            RegionID = Convert.ToInt32(row["RegionID"]);
            Codigo = Convert.ToString(row["Codigo"]);
        }

    }
}
