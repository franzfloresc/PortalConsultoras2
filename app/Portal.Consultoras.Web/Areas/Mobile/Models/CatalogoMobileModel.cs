using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using Portal.Consultoras.Web.ServiceCatalogosIssuu;
using Portal.Consultoras.Web.ServiceCliente;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class CatalogoMobileModel
    {
        public string CampaniaActual { get; set; }
        public string CampaniaAnterior { get; set; }
        public string CampaniaSiguiente { get; set; }
        public string Campania { get; set; }

        public string EstadoLbel { get; set; }
        public string EstadoEsika { get; set; }
        public string EstadoCyzone { get; set; }
        public string CatalogoUnificado { get; set; }
        public string UrlDescargarApp { get; set; }

        public int PaisID { get; set; } //R20160204
        public string CodigoZona { get; set; } //R20160204
        public List<BECliente> ListaCliente { get; set; }
    }
}