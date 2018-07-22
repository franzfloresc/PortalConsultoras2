using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEAfiliaClienteConsultora
    {
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public bool EsConsultoraLider { get; set; }
        [DataMember]
        public int EsAfiliado { get; set; }

        [DataMember]
        public bool EmailActivo { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Celular { get; set; }
        [DataMember]
        public string Telefono { get; set; }

        public BEAfiliaClienteConsultora()
        {
        }

        public BEAfiliaClienteConsultora(IDataRecord row)
        {
            ConsultoraID = row.ToInt64("ConsultoraID");
            EsConsultoraLider = row.ToInt32("EsConsultoraLider") > 0;
            EsAfiliado = row.ToInt32("EsAfiliado");
            NombreCompleto = row.ToString("NombreCompleto");
            Email = row.ToString("Email");
            Celular = row.ToString("Celular");
            Telefono = row.ToString("Telefono");
            EmailActivo = row.ToBoolean("EmailActivo");
        }

    }
}
