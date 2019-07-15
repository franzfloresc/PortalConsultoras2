using Portal.Consultoras.Common;
using System.Data;

namespace Portal.Consultoras.Entities.Encuesta
{
    public class BEDataConfigEncuesta
    {
        public int EncuestaId { get; set; }
        public string NombreEncuesta { get; set; }
        public int CalificacionId { get; set; }
        public string Calificacion { get; set; }
        public int TipoCalificacion { get; set; }
        public int MotivoId { get; set; }
        public int TipoMotivo { get; set; }
        public string Motivo { get; set; }

        public BEDataConfigEncuesta(IDataRecord row)
        {
            EncuestaId = row.ToInt32("EncuestaId");
            CalificacionId = row.ToInt32("CalificacionId");
            TipoCalificacion = row.ToInt32("TipoCalificacion");
            Calificacion = row.ToString("Calificacion");
            MotivoId = row.ToInt32("MotivoId");
            TipoMotivo = row.ToInt32("TipoMotivo");
            Motivo = row.ToString("Motivo");
        }
    }
}
