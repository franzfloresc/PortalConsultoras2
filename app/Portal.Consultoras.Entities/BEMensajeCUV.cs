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
            this.ParametroID = Convert.ToInt32(row["ParametroID"].ToString());
            this.PaisID = Convert.ToInt32(row["PaisID"].ToString());
            this.CampaniaID = Convert.ToInt32(row["CampaniaID"].ToString());
            this.Cuvs = row["CUVs"].ToString();
            this.Mensaje = row["Mensaje"].ToString();
        }

    }
}
