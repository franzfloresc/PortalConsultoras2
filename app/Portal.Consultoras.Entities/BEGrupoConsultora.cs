using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Data;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGrupoConsultora
    {
        private int miPaisID;
        private string miConsultoraCodigo;
        private string msPaisCodigo;

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