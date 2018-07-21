using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoDato
    {
        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string ImagenFondo { get; set; }

        [DataMember]
        public string ImagenLogo { get; set; }

        public BEContenidoDato(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            PaisID = row.ToInt32("PaisID");
            ImagenFondo = row.ToString("ImagenFondo");
            ImagenLogo = row.ToString("ImagenLogo");
        }
    }
}
