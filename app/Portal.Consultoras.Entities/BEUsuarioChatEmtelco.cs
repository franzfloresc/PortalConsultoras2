using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioChatEmtelco
    {
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string SegmentoAbreviatura { get; set; }

        public BEUsuarioChatEmtelco(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CodigoUsuario")) CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "Email")) Email = Convert.ToString(row["Email"]);
            if (DataRecord.HasColumn(row, "PrimerNombre")) PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "SegmentoAbreviatura")) SegmentoAbreviatura = Convert.ToString(row["SegmentoAbreviatura"]);
        }

    }
}
