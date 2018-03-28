using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMensajeCUV
    {
        private int parametroID;
        private int paisID;
        private int campaniaID;
        private string cuvs;
        private string mensaje;

        public BEMensajeCUV()
        {
        }

        public BEMensajeCUV(IDataRecord row)
        {
            this.parametroID = Convert.ToInt32(row["ParametroID"].ToString());
            this.paisID = Convert.ToInt32(row["PaisID"].ToString());
            this.campaniaID = Convert.ToInt32(row["CampaniaID"].ToString());
            this.cuvs = row["CUVs"].ToString();
            this.mensaje = row["Mensaje"].ToString();
        }

        [DataMember]
        public int ParametroID
        {
            get { return parametroID; }
            set { parametroID = value; }
        }
        [DataMember]
        public int PaisID
        {
            get { return paisID; }
            set { paisID = value; }
        }
        [DataMember]
        public int CampaniaID
        {
            get { return campaniaID; }
            set { campaniaID = value; }
        }
        [DataMember]
        public string Cuvs
        {
            get { return cuvs; }
            set { cuvs = value; }
        }
        [DataMember]
        public string Mensaje
        {
            get { return mensaje; }
            set { mensaje = value; }
        }

    }
}
