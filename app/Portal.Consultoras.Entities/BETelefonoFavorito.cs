using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETelefonoFavorito
    {
        [DataMember]
        public long TelefonoFavoritoID { get; set; }
        [DataMember]
        public long ConsultoraClienteID { get; set; }
        [DataMember]
        public short TipoContactoID { get; set; }
        [DataMember]
        public long ClienteID { get; set; }
    }
}
