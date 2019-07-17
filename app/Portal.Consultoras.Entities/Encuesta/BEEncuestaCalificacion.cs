using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuestaCalificacion :BEEntityBase
    {
        public BEEncuestaCalificacion()
        {
            EncuestaMotivo = new HashSet<BEEncuestaMotivo>();
        }

        [DataMember]
        public int EncuestaCalificacionId { get; set; }
        [DataMember]
        public int EncuestaId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public int CanalId { get; set; }
        [DataMember]
        public int TipoCalificacion { get; set; }
        public ICollection<BEEncuestaMotivo> EncuestaMotivo { get; set; }
        [DataMember]
        public string XMLMotivo { get; set; }
    }
}
