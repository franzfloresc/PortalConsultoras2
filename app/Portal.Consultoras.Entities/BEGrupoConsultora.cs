using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEGrupoConsultora
    {
        public BEGrupoConsultora() { }

        public BEGrupoConsultora(IDataRecord row)
        {
            PaisID = Convert.ToInt32(row["PaisID"]);
            ConsultoraCodigo = Convert.ToString(row["ConsultoraCodigo"]);
        }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string ConsultoraCodigo { get; set; }

        [DataMember]
        public string PaisCodigo { get; set; }

    }
}