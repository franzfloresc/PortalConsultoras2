using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGrupoConsultora
    {
        private int miPaisID;
        private string miConsultoraCodigo;
        private string msPaisCodigo;

        public BEGrupoConsultora()
        {
        }

        public BEGrupoConsultora(IDataRecord row)
        {
            miPaisID = Convert.ToInt32(row["PaisID"]);
            miConsultoraCodigo = Convert.ToString(row["ConsultoraCodigo"]);
        }

        [DataMember]
        public int PaisID
        {
            get { return miPaisID; }
            set { miPaisID = value; }
        }
        [DataMember]
        public string ConsultoraCodigo
        {
            get { return miConsultoraCodigo; }
            set { miConsultoraCodigo = value; }
        }

        [DataMember]
        public string PaisCodigo
        {
            get { return msPaisCodigo; }
            set { msPaisCodigo = value; }
        }
    }
}