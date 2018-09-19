using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class RevistaDigitalLandingModel
    {
        public RevistaDigitalLandingModel()
        {
            FiltersBySorting = new List<BETablaLogicaDatos>();
            FiltersByCategory = new List<BETablaLogicaDatos>();
            FiltersByBrand = new List<BETablaLogicaDatos>();
            FiltersByPublished = new List<BETablaLogicaDatos>();
        }

        public bool Success { get; set; }
        public bool IsMobile { get; set; }
        public int CampaniaID { get; set; }
        public bool PuedeSuscribirse { get; set; }
        public MensajeProductoBloqueadoModel MensajeProductoBloqueado { get; set; }
        public int CantidadFilas { get; set; }
        public bool ProductosPerdio { get; set; }
        public string PerdioLogo { get; set; }
        public string PerdioTitulo { get; set; }
        public string PerdioSubTitulo { get; set; }
        public bool MostrarFiltros { get; set; }

        public List<BETablaLogicaDatos> FiltersBySorting { get; set; }
        public List<BETablaLogicaDatos> FiltersByCategory { get; set; }
        public List<BETablaLogicaDatos> FiltersByBrand { get; set; }
        public List<BETablaLogicaDatos> FiltersByPublished { get; set; }
    }
}