using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuestaMotivo: BEEntityBase
    {
        [DataMember]
        public int EncuestaMotivoId { get; set; }
        [DataMember]
        public int EncuestaCalificacionId { get; set; }
        [DataMember]
        public int TipoEncuestaMotivoId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
    }
}
