using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

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
        [DataMember]
        [Column("RegionId")]
        public int RegionId { get; set; }
        [DataMember]
        [Column("ZonaId")]
        public int ZonaId { get; set; }
        [DataMember]
        [Column("Estado")]
        public int Estado { get; set; }
        [DataMember]
        [Column("Consultoraid")]
        public int Consultoraid { get; set; }
    }
}
