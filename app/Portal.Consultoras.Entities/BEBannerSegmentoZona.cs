using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEBannerSegmentoZona
    {
        [DataMember]
        public int CampaniaId { set; get; }
        [DataMember]
        public int BannerId { set; get; }
        [DataMember]
        public int PaisId { set; get; }
        [DataMember]
        public int Segmento { set; get; }
        [DataMember]
        public string ConfiguracionZona { set; get; }
        [DataMember]
        public string NombrePais { set; get; }
        [DataMember]
        public string SegmentoInterno { get; set; }
        [DataMember]
        public int TipoAcceso { set; get; }
        [DataMember]
        public string CodigosConsultora { get; set; }
    }
}
