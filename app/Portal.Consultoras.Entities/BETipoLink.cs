using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETipoLink
    {
        public BETipoLink(IDataRecord row)
        {
            PaisID = Convert.ToInt32(row["PaisID"]);
            TipoLinkID = Convert.ToInt32(row["TipoLinkID"].ToString());
            Url = row["Url"].ToString();
        }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int TipoLinkID { get; set; }

        [DataMember]
        public string Url { get; set; }
    }
}
