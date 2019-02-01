using Portal.Consultoras.Web.Models.DetalleEstrategia;
using System;

namespace Portal.Consultoras.Web.Models
{
    public class DetalleEstrategiaFichaModel : EstrategiaPersonalizadaProductoModel
    {
        public string CodigoVideo { get; set; } //Por defecto 1 video
        public string OrigenUrl { get; set; }
        public int OrigenAgregar { get; set; }
        public int OrigenAgregarCarrusel { get; set; }
        public string Palanca { get; set; }
        public bool TieneSession { get; set; }
        public int Campania { get; set; }
        public string Cuv { get; set; }

        public bool TieneReloj { get; set; }
        public bool TieneCompartir { get; set; }
        public bool TieneCarrusel { get; set; }

        public double TeQuedan { get; set; }
        public string ColorFondo1 { get; set; }
        public ConfiguracionSeccionHomeModel ConfiguracionContenedor { get; set; }

        public DetalleEstrategiaBreadCrumbsModel BreadCrumbs { get; set; }
        public bool EsVC { get; set; }

        /// <summary>
        /// 0: Por defecto, no muestra accion de navegabilidad
        /// 1: BreadCrumbs
        /// 2: Volver
        /// </summary>
        public int TipoAccionNavegar { get; set; }

        public bool NoEsCampaniaActual { get; set; }

        public bool Error { get; set; }
        public int Cantidad { get; set; }
    }
}