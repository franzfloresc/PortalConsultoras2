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
            ConsultoraID = Convert.ToInt64(row["ConsultoraID"]);
            EsConsultoraLider = Convert.ToInt32(row["EsConsultoraLider"]) > 0;
            EsAfiliado = Convert.ToInt32(row["EsAfiliado"]);
            NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            Email = Convert.ToString(row["Email"]);
            Celular = Convert.ToString(row["Celular"]);
            Telefono = Convert.ToString(row["Telefono"]);
            EmailActivo = Convert.ToBoolean(row["EmailActivo"]);
        }

    }
}
