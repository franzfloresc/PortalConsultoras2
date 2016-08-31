using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.WebPages.Html;

namespace Portal.Consultoras.Web.Models
{
    public class NivelesRiesgoModel
    {
        public string CodigoISO { get; set; }
        public string ZonaSeccion { set; get; }
        public string NivelRiesgo { set; get; }
       
    }
}