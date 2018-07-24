using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraSolicitudCliente
    {
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public string MarcaNombre { get; set; }

        public BEConsultoraSolicitudCliente()
        {

        }

        public BEConsultoraSolicitudCliente(IDataRecord row)
        {
            Codigo = row.ToString("Codigo");
            Nombre = row.ToString("Nombre");
            NombreCompleto = row.ToString("NombreCompleto");
            Email = row.ToString("Email");
            CodigoISO = row.ToString("CodigoISO");
            MarcaNombre = row.ToString("MarcaNombre");
        }
    }
}
