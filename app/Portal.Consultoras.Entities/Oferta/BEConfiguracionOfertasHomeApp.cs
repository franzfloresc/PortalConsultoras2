using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities.Oferta
{
    [DataContract]
    public class BEConfiguracionOfertasHomeApp
    {
        [Column("ConfiguracionOfertasHomeAppID")]
        [DataMember]
        public int ConfiguracionOfertasHomeAppID { get; set; }
        [Column("ConfiguracionOfertasHomeID")]
        [DataMember]
        public int ConfiguracionOfertasHomeID { get; set; }
        [Column("AppActivo")]
        [DataMember]
        public bool AppActivo { get; set; }
        [Column("AppTitulo")]
        [DataMember]
        public string AppTitulo { get; set; }
        [Column("AppColorFondo")]
        [DataMember]
        public string AppColorFondo { get; set; }
        [Column("AppColorTexto")]
        [DataMember]
        public string AppColorTexto { get; set; }
        [Column("AppBannerInformativo")]
        [DataMember]
        public string AppBannerInformativo { get; set; }
        [Column("AppOrden")]
        [DataMember]
        public int AppOrden { get; set; }
        [Column("AppCantidadProductos")]
        [DataMember]
        public int AppCantidadProductos { get; set; }
        [Column("Codigo")]
        [DataMember]
        public string Codigo { get; set; }
    }
}
