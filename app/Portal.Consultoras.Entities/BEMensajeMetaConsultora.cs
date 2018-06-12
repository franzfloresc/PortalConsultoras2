using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMensajeMetaConsultora
    {
        [DataMember]
        [Column("TipoMensaje")]
        public string TipoMensaje { get; set; }
        [DataMember]
        [Column("Titulo")]
        public string Titulo { get; set; }
        [DataMember]
        [Column("Mensaje")]
        public string Mensaje { get; set; }
    }
}
