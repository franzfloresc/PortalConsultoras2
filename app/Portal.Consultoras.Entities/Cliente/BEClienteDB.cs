using Portal.Consultoras.Common;
using Portal.Consultoras.Entities.Cliente;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEClienteDB
    {
        public BEClienteDB()
        {
            Estado = 1;
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public long CodigoCliente { get; set; }
        [DataMember]
        public int ClienteID { get; set; }

        [DataMember]
        public string Apellidos { get; set; }
        [DataMember]
        public string Nombres { get; set; }

        private string nombreCompleto = string.Empty;
        [DataMember]
        public string NombreCompleto
        {
            get
            {
                var nombres = Nombres ?? string.Empty;
                var apellidos = Apellidos ?? string.Empty;
                nombreCompleto = string.Format("{0} {1}", nombres, apellidos).Trim();
                return nombreCompleto;
            }
            set { nombreCompleto = value; }
        }
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
        public short Estado { get; set; }

        [DataMember]
        public short Favorito { get; set; }

        [DataMember]
        public short TipoContactoFavorito { get; set; }

        [DataMember]
        public decimal Saldo { get; set; }
        [DataMember]
        public int CantidadProductos { get; set; }
        [DataMember]
        public decimal MontoPedido { get; set; }
        [DataMember]
        public int CantidadPedido { get; set; }

        [DataMember]
        public string CodigoRespuesta { get; set; }

        private string mensajeRespuesta;
        [DataMember]
        public string MensajeRespuesta
        {
            get
            {
                mensajeRespuesta = string.Empty;
                if (string.IsNullOrEmpty(CodigoRespuesta))
                    mensajeRespuesta = Constantes.ClienteValidacion.Message[CodigoRespuesta];
                return mensajeRespuesta;
            }
            set { mensajeRespuesta = value; }
        }
        [DataMember]
        public bool Insertado { get; set; }

        [DataMember]
        public List<BEClienteContactoDB> Contactos { get; set; }

        [DataMember]
        public IEnumerable<BEClienteRecordatorio> Recordatorios { get; set; }

        [DataMember]
        public IEnumerable<BENota> Notas { get; set; }

        [DataMember]
        public IEnumerable<BEMovimiento> Movimientos { get; set; }
    }
}
