using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BESolicitudClienteAppCatalogo
    {
        [DataMember(Order = 0)]
        public string Campania { get; set; }
        [DataMember(Order = 1)]
        public string CodigoConsultora { get; set; }
        [DataMember(Order = 2)]
        public string CodigoUbigeo { get; set; }
        [DataMember(Order = 3)]
        public long ConsultoraID { get; set; }
        [DataMember(Order = 4)]
        public string Direccion { get; set; }
        [DataMember(Order = 5)]
        public string Email { get; set; }
        [DataMember(Order = 6)]
        public string Mensaje { get; set; }
        [DataMember(Order = 7)]
        public string NombreCompleto { get; set; }
        [DataMember(Order = 8)]
        public long SolicitudClienteID { get; set; }
        [DataMember(Order = 9)]
        public string Telefono { get; set; }
        [DataMember(Order = 10)]
        public IList<BESolicitudClienteDetalleAppCatalogo> DetalleSolicitud { get; set; }
        [DataMember(Order = 11)]
        public int FlagConsultora { get; set; }
        [DataMember(Order = 12)]
        public string FlagMedio { get; set; }
        [DataMember(Order = 13)]
        public string CodigoDispositivo { get; set; }
        [DataMember(Order = 14)]
        public string SODispositivo { get; set; }
        [DataMember(Order = 15)]
        public int TipoUsuario { get; set; }
        [DataMember(Order = 16)]
        public long UsuarioAppID { get; set; }
    }
}
