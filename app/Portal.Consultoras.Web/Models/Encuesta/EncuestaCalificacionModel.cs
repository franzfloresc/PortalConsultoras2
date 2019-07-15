using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.Encuesta
{
      public class EncuestaCalificacionModel
    {
        public EncuestaCalificacionModel()
        {
            EncuestaMotivo = new HashSet<EncuestaMotivoModel>();
        }
        public int EncuestaCalificacionId { get; set; }
        public int EncuestaId { get; set; }
        public string Descripcion { get; set; }
        public int TipoCalificacion { get; set; }
        public ICollection<EncuestaMotivoModel> EncuestaMotivo { get; set; }
    }
}
