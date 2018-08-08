using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMensajeCUV
    {
        [DataMember]
        public int ParametroID { get; set; }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string Cuvs { get; set; }

        [DataMember]
        public string Mensaje { get; set; }

        public BEMensajeCUV() { }

        public BEMensajeCUV(IDataRecord row)
        {
            ParametroID = row.ToInt32("ParametroID");
            PaisID = row.ToInt32("PaisID");
            CampaniaID = row.ToInt32("CampaniaID");
            Cuvs = row.ToString("CUVs");
            Mensaje = row.ToString("Mensaje");
        }

    }
}
