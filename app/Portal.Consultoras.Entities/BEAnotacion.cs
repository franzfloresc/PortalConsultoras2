using System;
using System.Data;
using System.Runtime.Serialization;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEAnotacion : BEConsultoraCliente
    {
        [DataMember]
        public long AnotacionID { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public short Estado { get; set; }
    }
}
