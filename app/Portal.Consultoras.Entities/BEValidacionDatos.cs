using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEValidacionDatos
    {
        [DataMember]
        [Column("ValidacionID")]
        public long ValidacionId { get; set; }

        [DataMember]
        [Column("TipoEnvio")]
        public string TipoEnvio { get; set; }

        [DataMember]
        [Column("DatoAntiguo")]
        public string DatoAntiguo { get; set; }

        [DataMember]
        [Column("DatoNuevo")]
        public string DatoNuevo { get; set; }

        [DataMember]
        [Column("CodigoUsuario")]
        public string CodigoUsuario { get; set; }

        [DataMember]
        [Column("Estado")]
        public string Estado { get; set; }

        [DataMember]
        [Column("CampaniaActivacionEmail")]
        public int CampaniaActivacionEmail { get; set; }

        [DataMember]
        [Column("FechaCreacion")]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        [Column("UsuarioCreacion")]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        [Column("FechaModificacion")]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        [Column("UsuarioModificacion")]
        public string UsuarioModificacion { get; set; }
    }
}
