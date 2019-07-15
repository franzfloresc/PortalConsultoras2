using Portal.Consultoras.Common;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Encuesta
{
    [DataContract]
    public class BEDataConfigEncuesta
    {
        [DataMember]
        public int EncuestaId { get; set; }
        [DataMember]
        public string NombreEncuesta { get; set; }
        [DataMember]
        public int CalificacionId { get; set; }
        [DataMember]
        public string Calificacion { get; set; }
        [DataMember]
        public int TipoCalificacion { get; set; }
        [DataMember]
        public int MotivoId { get; set; }
        [DataMember]
        public int TipoMotivo { get; set; }
        [DataMember]
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
