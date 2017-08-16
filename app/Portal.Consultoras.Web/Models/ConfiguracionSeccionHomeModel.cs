﻿using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionSeccionHomeModel
    {
        public int ConfiguracionOfertasHomeID { get; set; }
        public int ConfiguracionPaisID { get; set; }
        public string Codigo { get; set; }
        public int CampaniaID { get; set; }
        
        public bool IsMobile { get; set; } // Desktop - Mobile
        public int Orden { get; set; }
        public string ImagenFondo { get; set; }
        public string Titulo { get; set; }
        public string SubTitulo { get; set; }
        public string TipoPresentacion { get; set; }
        public string TipoEstrategia { get; set; }
        public int CantidadProductos { get; set; }
        public string UrlObtenerProductos { get; set; }
        public string Template { get; set; }

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

    }
}