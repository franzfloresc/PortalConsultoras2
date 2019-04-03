using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura
{
    public class EstrategiaComponenteSeccion
    {
        public string Titulo { get; set; }
        public bool EsVideos { get; set; }
        public List<EstrategiaComponenteSeccionDetalle> Detalles { get; set; }
    }

    public class EstrategiaComponenteSeccionDetalle
    {
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string Key { get; set; }
    }
}