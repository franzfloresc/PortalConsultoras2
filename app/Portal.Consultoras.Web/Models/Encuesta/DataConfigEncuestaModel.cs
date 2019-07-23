using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Encuesta
{
    [Serializable]
    public class DataConfigEncuestaModel
    {
        public int EncuestaId { get; set; }
        public string CodigoCampania { get; set; }
        public string NombreEncuesta { get; set; }
        public int CalificacionId { get; set; }
        public string Calificacion { get; set; }
        public int TipoCalificacion { get; set; }
        public string PreguntaDescripcion { get; set; }
        public string EstiloCalificacion { get; set; }
        public string ImagenCalificacion { get; set; }
        public int MotivoId { get; set; }
        public int TipoMotivo { get; set; }
        public string Motivo { get; set; }
    }
}