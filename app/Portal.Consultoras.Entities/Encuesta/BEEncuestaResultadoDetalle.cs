using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuestaResultadoDetalle :BEEntityBase
    {
        [DataMember]
        public Guid Id { get; set; }
        [DataMember]
        public Guid EncuestaResultadoId { get; set; }
        [DataMember]
        public int MotivoId { get; set; }
        [DataMember]
        public string Observacion { get; set; }
    }
}
