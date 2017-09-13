using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    public class BEClienteContactoDB : BEClienteDB
    {
        [DataMember]
        public long ContactoClienteID { get; set; }
        [DataMember]
        public short TipoContactoID { get; set; }
        [DataMember]
        public string Valor { get; set; }
    }
}
