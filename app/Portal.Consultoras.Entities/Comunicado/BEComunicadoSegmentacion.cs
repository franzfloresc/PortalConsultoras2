using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Comunicado
{
    [DataContract]
    public class BEComunicadoSegmentacion
    {
        [DataMember]
        [Column("SegmentacionComunicadoId")]
        public int SegmentacionComunicadoId { get; set; }
        [DataMember]
        [Column("ComunicadoId")]
        public long ComunicadoId { get; set; }
        [DataMember]
        [Column("SegmentacionID")]
        public int SegmentacionID { get; set; }
        [DataMember]
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("CodigoRegion")]
        public string CodigoRegion { get; set; }
        [DataMember]
        [Column("CodigoZona")]
        public string CodigoZona { get; set; }
        [DataMember]
        [Column("IdEstadoActividad")]
        public int? IdEstadoActividad { get; set; }
    }
}
