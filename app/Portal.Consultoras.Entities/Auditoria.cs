using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class Auditoria
    {
        [DataMember]
        [Column("UsuarioCreacion")]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        [Column("FechaCreacion")]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        [Column("UsuarioModificacion")]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        [Column("FechaModificacion")]
        public DateTime? FechaModificacion { get; set; }
    }
}
