using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    public class BEConfiguracionOfertasHome : BaseEntidad
    {
        [DataMember]
        public int ConfiguracionOfertasHomeID { get; set; }

        [DataMember]
        public int ConfiguracionPaisID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public int DesktopOrden { get; set; }

        [DataMember]
        public int DesktopOrdenBpt { get; set; }

        [DataMember]
        public int MobileOrden { get; set; }

        [DataMember]
        public int MobileOrdenBpt { get; set; }

        [DataMember]
        public string DesktopColorFondo { get; set; }

        [DataMember]
        public string MobileColorFondo { get; set; }

        [DataMember]
        public bool DesktopUsarImagenFondo { get; set; }

        [DataMember]
        public bool MobileUsarImagenFondo { get; set; }

        [DataMember]
        public string DesktopImagenFondo { get; set; }

        [DataMember]
        public string MobileImagenFondo { get; set; }

        [DataMember]
        public string DesktopColorTexto { get; set; }

        [DataMember]
        public string MobileColorTexto { get; set; }

        [DataMember]
        public string DesktopTitulo { get; set; }

        [DataMember]
        public string MobileTitulo { get; set; }

        [DataMember]
        public string DesktopSubTitulo { get; set; }

        [DataMember]
        public string MobileSubTitulo { get; set; }

        [DataMember]
        public int DesktopTipoPresentacion { get; set; }

        [DataMember]
        public int MobileTipoPresentacion { get; set; }

        [DataMember]
        public string DesktopTipoEstrategia { get; set; }

        [DataMember]
        public string MobileTipoEstrategia { get; set; }

        [DataMember]
        public int DesktopCantidadProductos { get; set; }

        [DataMember]
        public int MobileCantidadProductos { get; set; }

        [DataMember]
        public bool DesktopActivo { get; set; }

        [DataMember]
        public bool MobileActivo { get; set; }

        [DataMember]
        public string UrlSeccion { get; set; }

        [DataMember]
        public BEConfiguracionPais ConfiguracionPais { get; set; }

        public BEConfiguracionOfertasHome(IDataRecord row)
        {
            ConfiguracionOfertasHomeID = row.ToInt32("ConfiguracionOfertasHomeID");
            ConfiguracionPaisID = row.ToInt32("ConfiguracionPaisID");
            CampaniaID = row.ToInt32("CampaniaID");
            DesktopOrden = row.ToInt32("DesktopOrden");
            DesktopOrdenBpt = row.ToInt32("DesktopOrdenBpt");
            MobileOrden = row.ToInt32("MobileOrden");
            MobileOrdenBpt = row.ToInt32("MobileOrdenBpt");
            DesktopColorFondo = row.ToString("DesktopColorFondo");
            MobileColorFondo = row.ToString("MobileColorFondo");
            DesktopActivo = row.ToBoolean("DesktopActivo");
            MobileActivo = row.ToBoolean("MobileActivo");
            DesktopUsarImagenFondo = row.ToBoolean("DesktopUsarImagenFondo");
            MobileUsarImagenFondo = row.ToBoolean("MobileUsarImagenFondo");
            DesktopImagenFondo = row.ToString("DesktopImagenFondo");
            MobileImagenFondo = row.ToString("MobileImagenFondo");
            DesktopColorTexto = row.ToString("DesktopColorTexto");
            MobileColorTexto = row.ToString("MobileColorTexto");
            DesktopTitulo = row.ToString("DesktopTitulo");
            MobileTitulo = row.ToString("MobileTitulo");
            DesktopSubTitulo = row.ToString("DesktopSubTitulo");
            MobileSubTitulo = row.ToString("MobileSubTitulo");
            DesktopTipoPresentacion = row.ToInt32("DesktopTipoPresentacion");
            MobileTipoPresentacion = row.ToInt32("MobileTipoPresentacion");
            DesktopTipoEstrategia = row.ToString("DesktopTipoEstrategia");
            MobileTipoEstrategia = row.ToString("MobileTipoEstrategia");
            DesktopCantidadProductos = row.ToInt32("DesktopCantidadProductos");
            MobileCantidadProductos = row.ToInt32("MobileCantidadProductos");
            DesktopActivo = row.ToBoolean("DesktopActivo");
            MobileActivo = row.ToBoolean("MobileActivo");
            UrlSeccion = row.ToString("UrlSeccion");
            ConfiguracionPais = new BEConfiguracionPais();
            ConfiguracionPais.Codigo = row.HasColumn("Codigo") ? Convert.ToString(row["Codigo"]) : "";
        }

        public BEConfiguracionOfertasHome()
        {
        }
    }
}
