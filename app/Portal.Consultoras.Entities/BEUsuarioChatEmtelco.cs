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
            CodigoUsuario = row.ToString("CodigoUsuario");
            Email = row.ToString("Email");
            PrimerNombre = row.ToString("PrimerNombre");
            SegmentoAbreviatura = row.ToString("SegmentoAbreviatura");
        }

    }
}
