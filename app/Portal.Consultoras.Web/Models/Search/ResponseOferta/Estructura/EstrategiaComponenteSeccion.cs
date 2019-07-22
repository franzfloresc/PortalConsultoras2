using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura
{
    public class EstrategiaComponenteCabecera
    {
        public string ContenidoNeto { get; set; }
        public string Dimensiones { get; set; }
        public string TallaMedidas { get; set; }
    }
    public class EstrategiaComponenteSeccion
    {
        public string Tipo { get; set; }
        public string Titulo { get; set; }
        public List<EstrategiaComponenteSeccionDetalle> Detalles { get; set; }
    }

    public class EstrategiaComponenteSeccionDetalle
    {
        
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string Key { get; set; }
    }
}