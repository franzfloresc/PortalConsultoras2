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
            if (row.HasColumn("ConfiguracionOfertasHomeID")) ConfiguracionOfertasHomeID = Convert.ToInt32(row["ConfiguracionOfertasHomeID"]);
            if (row.HasColumn("ConfiguracionPaisID")) ConfiguracionPaisID = Convert.ToInt32(row["ConfiguracionPaisID"]);
            if (row.HasColumn("CampaniaID")) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (row.HasColumn("DesktopOrden")) DesktopOrden = Convert.ToInt32(row["DesktopOrden"]);
            if (row.HasColumn("DesktopOrdenBpt")) DesktopOrdenBpt = Convert.ToInt32(row["DesktopOrdenBpt"]);
            if (row.HasColumn("MobileOrden")) MobileOrden = Convert.ToInt32(row["MobileOrden"]);
            if (row.HasColumn("MobileOrdenBpt")) MobileOrdenBpt = Convert.ToInt32(row["MobileOrdenBpt"]);
            if (row.HasColumn("DesktopColorFondo")) DesktopColorFondo = Convert.ToString(row["DesktopColorFondo"]);
            if (row.HasColumn("MobileColorFondo")) MobileColorFondo = Convert.ToString(row["MobileColorFondo"]);
            if (row.HasColumn("DesktopActivo")) DesktopActivo = Convert.ToBoolean(row["DesktopActivo"]);
            if (row.HasColumn("MobileActivo")) MobileActivo = Convert.ToBoolean(row["MobileActivo"]);
            if (row.HasColumn("DesktopUsarImagenFondo")) DesktopUsarImagenFondo = Convert.ToBoolean(row["DesktopUsarImagenFondo"]);
            if (row.HasColumn("MobileUsarImagenFondo")) MobileUsarImagenFondo = Convert.ToBoolean(row["MobileUsarImagenFondo"]);
            if (row.HasColumn("DesktopImagenFondo")) DesktopImagenFondo = Convert.ToString(row["DesktopImagenFondo"]);
            if (row.HasColumn("MobileImagenFondo")) MobileImagenFondo = Convert.ToString(row["MobileImagenFondo"]);
            if (row.HasColumn("DesktopColorTexto")) DesktopColorTexto = Convert.ToString(row["DesktopColorTexto"]);
            if (row.HasColumn("MobileColorTexto")) MobileColorTexto = Convert.ToString(row["MobileColorTexto"]);
            if (row.HasColumn("DesktopTitulo")) DesktopTitulo = Convert.ToString(row["DesktopTitulo"]);
            if (row.HasColumn("MobileTitulo")) MobileTitulo = Convert.ToString(row["MobileTitulo"]);
            if (row.HasColumn("DesktopSubTitulo")) DesktopSubTitulo = Convert.ToString(row["DesktopSubTitulo"]);
            if (row.HasColumn("MobileSubTitulo")) MobileSubTitulo = Convert.ToString(row["MobileSubTitulo"]);
            if (row.HasColumn("DesktopTipoPresentacion")) DesktopTipoPresentacion = Convert.ToInt32(row["DesktopTipoPresentacion"]);
            if (row.HasColumn("MobileTipoPresentacion")) MobileTipoPresentacion = Convert.ToInt32(row["MobileTipoPresentacion"]);
            if (row.HasColumn("DesktopTipoEstrategia")) DesktopTipoEstrategia = Convert.ToString(row["DesktopTipoEstrategia"]);
            if (row.HasColumn("MobileTipoEstrategia")) MobileTipoEstrategia = Convert.ToString(row["MobileTipoEstrategia"]);
            if (row.HasColumn("DesktopCantidadProductos")) DesktopCantidadProductos = Convert.ToInt32(row["DesktopCantidadProductos"]);
            if (row.HasColumn("MobileCantidadProductos")) MobileCantidadProductos = Convert.ToInt32(row["MobileCantidadProductos"]);
            if (row.HasColumn("DesktopActivo")) DesktopActivo = Convert.ToBoolean(row["DesktopActivo"]);
            if (row.HasColumn("MobileActivo")) MobileActivo = Convert.ToBoolean(row["MobileActivo"]);
            if (row.HasColumn("UrlSeccion")) UrlSeccion = Convert.ToString(row["UrlSeccion"]);
            ConfiguracionPais = new BEConfiguracionPais();
            ConfiguracionPais.Codigo = row.HasColumn("Codigo") ? Convert.ToString(row["Codigo"]) : "";
        }

        public BEConfiguracionOfertasHome()
        {
        }
    }
}