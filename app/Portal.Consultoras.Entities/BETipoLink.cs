using Portal.Consultoras.Common;
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
            PaisID = row.ToInt32("PaisID");
            TipoLinkID = row.ToInt32("TipoLinkID");
            Url = row.ToString("Url");
        }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int TipoLinkID { get; set; }

        [DataMember]
        public string Url { get; set; }
    }
}
