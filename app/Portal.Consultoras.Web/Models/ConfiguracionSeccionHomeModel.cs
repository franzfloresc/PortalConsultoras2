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
        public int TipoPresentacion { get; set; }
        public string TipoEstrategia { get; set; }
        public int CantidadMostrar { get; set; }
        public int CantidadProductos { get; set; }
        public string UrlObtenerProductos { get; set; }
        public string UrlLandig { get; set; }
        public string TemplateProducto { get; set; }
        public string TemplatePresentacion { get; set; }
        public bool VerMas { get; set; }
        public int OrigenPedido { get; set; }
    }
}