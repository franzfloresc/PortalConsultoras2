using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    public class BEContactoCliente
    {
        private short _Estado;

        public BEContactoCliente()
        {
            _Estado = 1;
        }

        [DataMember]
        public long ContactoClienteID { get; set; }
        [DataMember]
        public long ClienteID { get; set; }
        [DataMember]
        public short TipoContactoID { get; set; }
        [DataMember]
        public string Valor { get; set; }
        [DataMember]
        public short Estado
        {
            get
            {
                return _Estado;
            }
            set
            {
                _Estado = value;
            }
        }

        [DataMember]
        public short Favorito { get; set; }
    }
}
