using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETipoLink
    {
        private int miPaisID;
        private int miTipoLinkID;
        private string miUrl;

        public BETipoLink(IDataRecord row)
        {
            miPaisID = Convert.ToInt32(row["PaisID"]);
            miTipoLinkID = Convert.ToInt32(row["TipoLinkID"].ToString());
            miUrl = row["Url"].ToString();
        }

        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
        [DataMember]
        public int TipoLinkID
        {
            get { return miTipoLinkID; }
            set { miTipoLinkID = value; }
        }
        [DataMember]
        public string Url
        {
            get { return miUrl; }
            set { miUrl = value; }
        }
    }
}
