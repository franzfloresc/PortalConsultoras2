using Portal.Consultoras.Common;
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
            PaisID = row.ToInt32("PaisID");
            ConsultoraCodigo = row.ToString("ConsultoraCodigo");
        }

        [DataMember]
        public int PaisID { get; set; }

        [DataMember]
        public string ConsultoraCodigo { get; set; }

        [DataMember]
        public string PaisCodigo { get; set; }

    }
}
