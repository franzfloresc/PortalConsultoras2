using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEValidacionDatos
    {
        [DataMember]
        public long ValidacionId { get; set; }
        [DataMember]
        public string TipoEnvio { get; set; }
        [DataMember]
        public string DatoAntiguo { get; set; }
        [DataMember]
        public string DatoNuevo { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public int CampaniaActivacion { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
    }
}
