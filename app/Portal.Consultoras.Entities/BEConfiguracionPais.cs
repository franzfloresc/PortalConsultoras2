using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPais : BaseEntidad
    {
        [DataMember]
        [Column("ConfiguracionPaisID")]
        public int ConfiguracionPaisID { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("Excluyente")]
        public bool Excluyente { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }

        [DataMember]
        public bool Validado { get; set; }
        [DataMember]
        [Column("TienePerfil")]
        public bool TienePerfil { get; set; }
        [DataMember]
        [Column("MobileTituloMenu")]
        public string MobileTituloMenu { get; set; }
        [DataMember]
        [Column("DesktopTituloMenu")]
        public string DesktopTituloMenu { get; set; }
        [DataMember]
        [Column("Logo")]
        public string Logo { get; set; }
        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }
        [DataMember]
        [Column("DesdeCampania")]
        public int DesdeCampania { get; set; }
        [DataMember]
        [Column("DesktopTituloBanner")]
        public string DesktopTituloBanner { get; set; }
        [DataMember]
        [Column("MobileTituloBanner")]
        public string MobileTituloBanner { get; set; }
        [DataMember]
        [Column("DesktopSubTituloBanner")]
        public string DesktopSubTituloBanner { get; set; }
        [DataMember]
        [Column("MobileSubTituloBanner")]
        public string MobileSubTituloBanner { get; set; }

        [DataMember]
        [Column("DesktopFondoBanner")]
        public string DesktopFondoBanner { get; set; }
        [DataMember]
        [Column("MobileFondoBanner")]
        public string MobileFondoBanner { get; set; }
        [DataMember]
        [Column("DesktopLogoBanner")]
        public string DesktopLogoBanner { get; set; }
        [DataMember]
        [Column("MobileLogoBanner")]
        public string MobileLogoBanner { get; set; }
        [DataMember]
        [Column("UrlMenu")]
        public string UrlMenu { get; set; }
        [DataMember]
        [Column("OrdenBpt")]
        public int OrdenBpt { get; set; }
        [DataMember]
        [Column("BloqueoRevistaImpresa")]
        public bool BloqueoRevistaImpresa { get; set; }

        [DataMember]
        [Column("MobileOrden")]
        public int MobileOrden { get; set; }
        [DataMember]
        [Column("MobileOrdenBpt")]
        public int MobileOrdenBpt { get; set; }

        private BEConfiguracionPaisDetalle detalle = new BEConfiguracionPaisDetalle();
        [DataMember]
        public BEConfiguracionPaisDetalle Detalle
        {
            get
            {
                return detalle;
            }
            set
            {
                detalle = value;
            }
        }
    }
}
