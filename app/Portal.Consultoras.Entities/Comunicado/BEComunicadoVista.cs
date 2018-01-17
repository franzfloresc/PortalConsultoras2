using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Comunicado
{
    [DataContract]
    public class BEComunicadoVista
    {
        [DataMember]
        [Column("ComunicadoVistaId")]
        public long ComunicadoVistaId { get; set; }
        [DataMember]
        [Column("ComunicadoId")]
        public long ComunicadoId { get; set; }
        [DataMember]
        [Column("NombreControlador")]
        public string NombreControlador { get; set; }
        [DataMember]
        [Column("NombreVista")]
        public string NombreVista { get; set; }
    }
}
