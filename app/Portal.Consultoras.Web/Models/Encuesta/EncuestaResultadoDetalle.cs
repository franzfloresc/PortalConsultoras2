using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    
    public class EncuestaResultadoDetalleModel :EntityBaseModel
    {
        public Guid Id { get; set; }
       public Guid EncuestaResultadoId { get; set; }
       public int MotivoId { get; set; }
       public string Observacion { get; set; }
    }
}
