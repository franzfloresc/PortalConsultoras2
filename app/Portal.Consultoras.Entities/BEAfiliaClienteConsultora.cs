using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    //R2319 - JLCS
    [DataContract]
    public class BEAfiliaClienteConsultora
    {
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public bool EsConsultoraLider { get; set; }
        [DataMember]
        public int EsAfiliado { get; set; }
        //R2442 - JICM - Agregando nuevos campos
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
        //R2442 - FIN
        public BEAfiliaClienteConsultora()
        {
        }

        public BEAfiliaClienteConsultora(IDataRecord datarec)
        {
            ConsultoraID = Convert.ToInt64(datarec["ConsultoraID"]);
            EsConsultoraLider = Convert.ToInt32(datarec["EsConsultoraLider"])>0;
            EsAfiliado = Convert.ToInt32(datarec["EsAfiliado"]);
            NombreCompleto = Convert.ToString(datarec["NombreCompleto"]);
            Email = Convert.ToString(datarec["Email"]);
            Celular = Convert.ToString(datarec["Celular"]);
            Telefono = Convert.ToString(datarec["Telefono"]);
            EmailActivo = Convert.ToBoolean(datarec["EmailActivo"]);
        }



    }
}
