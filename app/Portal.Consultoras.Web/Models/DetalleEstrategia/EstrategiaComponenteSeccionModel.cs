using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.DetalleEstrategia
{
    [Serializable]
    public class EstrategiaComponenteCabeceraModel
    {
        public string ContenidoNeto { get; set; }
        public string Dimensiones { get; set; }
        public string TallaMedidas { get; set; }
    }

    [Serializable]
    public class EstrategiaComponenteSeccionModel
    {
        public string Tipo { get; set; }
        public string Titulo { get; set; }
        public List<EstrategiaComponenteSeccionDetalleModel> Detalles { get; set; }
    }

    [Serializable]
    public class EstrategiaComponenteSeccionDetalleModel
    {
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string Key { get; set; }
    } 
}