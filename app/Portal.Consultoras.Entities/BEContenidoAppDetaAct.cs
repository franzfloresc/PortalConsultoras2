using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppDetaAct : BaseEntidad
    {
        [DataMember]
        [Column("IdContenidoAct")]
        public int IdContenidoAct { get; set; }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("Parent")]
        public int Parent { get; set; }

        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }


    }
}

