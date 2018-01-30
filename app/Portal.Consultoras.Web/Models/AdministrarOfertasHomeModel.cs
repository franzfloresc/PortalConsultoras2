﻿using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class AdministrarOfertasHomeModel
    {
        public int ConfiguracionOfertasHomeID { get; set; }
        public int ConfiguracionPaisID { get; set; }
        public string Codigo { get; set; }
        public int CampaniaID { get; set; }

        public int DesktopOrden { get; set; }
        public int MobileOrden { get; set; }
        public string DesktopImagenFondo { get; set; }
        public string MobileImagenFondo { get; set; }
        public string DesktopTitulo { get; set; }
        public string MobileTitulo { get; set; }
        public string DesktopSubTitulo { get; set; }
        public string MobileSubTitulo { get; set; }
        public int DesktopTipoPresentacion { get; set; }
        public int MobileTipoPresentacion { get; set; }
        public string DesktopTipoEstrategia { get; set; }
        public string MobileTipoEstrategia { get; set; }
        public int DesktopCantidadProductos { get; set; }
        public int MobileCantidadProductos { get; set; }
        public bool DesktopActivo { get; set; }
        public bool MobileActivo { get; set; }
        public string UrlSeccion { get; set; }

        public int DesktopOrdenBpt { get; set; }
        public int MobileOrdenBpt { get; set; }

        public int PaisID { get; set; }
        public ConfiguracionPaisModel ConfiguracionPais { get; set; }
        public IEnumerable<PaisModel> ListaPaises { set; get; }
        public IEnumerable<CampaniaModel> ListaCampanias { set; get; }
        public IEnumerable<TipoEstrategiaModel> ListaTipoEstrategia { get; set; }
        public IEnumerable<ConfiguracionPaisModel> ListaConfiguracionPais { get; set; }
        public IEnumerable<TablaLogicaDatosModel> ListaTipoPresentacion { get; set; }

        public AdministrarOfertasHomeModel()
        {
            DesktopTipoEstrategia = "";
            MobileTipoEstrategia = "";
        }
    }
}