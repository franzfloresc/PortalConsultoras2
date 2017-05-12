using System;
using System.Data;
using System.Runtime.Serialization;
using System.Collections.Generic;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraCliente
    {
        [DataMember]
        public long ConsultoraClienteID { get; set; }

        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public long ClienteID { get; set; }

        [DataMember]
        public short Favorito { get; set; }

        [DataMember]
        public List<BEAnotacion> Anotaciones { get; set; }
    }
}
