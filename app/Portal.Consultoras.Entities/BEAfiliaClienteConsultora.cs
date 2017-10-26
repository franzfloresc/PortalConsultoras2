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

        public BEAfiliaClienteConsultora(IDataRecord datarec)
        {
            ConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);
            EsConsultoraLider = Convert.ToInt32(datarec["EsConsultoraLider"]) > 0;
            EsAfiliado = Convert.ToInt32(datarec["EsAfiliado"]);
            NombreCompleto = Convert.ToString(datarec["NombreCompleto"]);
            Email = Convert.ToString(datarec["Email"]);
            Celular = Convert.ToString(datarec["Celular"]);
            Telefono = Convert.ToString(datarec["Telefono"]);
            EmailActivo = Convert.ToBoolean(datarec["EmailActivo"]);
        }

    }
}
