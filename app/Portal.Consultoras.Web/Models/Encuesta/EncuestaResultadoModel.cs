using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    public class EncuestaResultadoModel
    {
        public EncuestaResultadoModel()
        {
            EncuestaResultadoDetalle = new HashSet<EncuestaResultadoDetalleModel>();
        }
        public Guid Id { get; set; }
        public int EncuestaId { get; set; }
        public int CanalId { get; set; }
        public string CodigoCampania { get; set; }
        public string CodigoConsultora { get; set; }
        public ICollection<EncuestaResultadoDetalleModel> EncuestaResultadoDetalle { get; set; }
    }
}
