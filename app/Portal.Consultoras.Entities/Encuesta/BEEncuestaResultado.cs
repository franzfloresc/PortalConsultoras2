using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuestaResultado:BEEntityBase
    {
        public BEEncuestaResultado()
        {
            EncuestaResultadoDetalle = new HashSet<BEEncuestaResultadoDetalle>();
        }
        [DataMember]
        public Guid Id { get; set; }
        [DataMember]
        public int EncuestaId { get; set; }
        [DataMember]
        public int CanalId { get; set; }
        [DataMember]
        public string CodigoCampania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public ICollection<BEEncuestaResultadoDetalle> EncuestaResultadoDetalle { get; set; }
    }
}
