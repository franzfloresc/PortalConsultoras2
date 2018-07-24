using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogo
    {
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Direccion { get; set; }

        public BECatalogo(IDataRecord row)
        {
            CampaniaID = row.ToInt32("CampaniaID");
            MarcaID = row.ToInt16("MarcaID");
            PaisID = row.ToInt16("PaisID");
            Direccion = row.ToString("Direccion");
        }
    }
}
