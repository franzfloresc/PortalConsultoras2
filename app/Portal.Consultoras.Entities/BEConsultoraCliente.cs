using System.Runtime.Serialization;
using System.Collections.Generic;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultoraCliente
    {
        private short _Estado;

        public BEConsultoraCliente()
        {
            _Estado = 1;
        }

        [DataMember]
        public long ConsultoraClienteID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public long ClienteID { get; set; }

        public string Apellidos { get; set; }
        [DataMember]
        public string Nombres { get; set; }
        [DataMember]
        public string Alias { get; set; }
        [DataMember]
        public string Foto { get; set; }
        [DataMember]
        public string FechaNacimiento { get; set; }
        [DataMember]
        public string Sexo { get; set; }
        [DataMember]
        public string Documento { get; set; }
        [DataMember]
        public string Origen { get; set; }

        [DataMember]
        public short TipoRegistro { get; set; }

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

        [DataMember]
        public List<BEContactoCliente> Contactos { get; set; }

        [DataMember]
        public List<BEAnotacion> Anotaciones { get; set; }
    }
}
