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
            ParametroID = Convert.ToInt32(row["ParametroID"]);
            PaisID = Convert.ToInt32(row["PaisID"]);
            CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            Cuvs = Convert.ToString(row["CUVs"]);
            Mensaje = Convert.ToString(row["Mensaje"]);
        }

    }
}
