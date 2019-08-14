using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEEncuesta : BEEntityBase
    {
        public BEEncuesta()
        {
            EncuestaCalificacion = new HashSet<BEEncuestaCalificacion>();
        }
        [DataMember]
        public int EncuestaId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public ICollection<BEEncuestaCalificacion> EncuestaCalificacion { get; set; }

    }
}
