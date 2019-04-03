﻿using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.DetalleEstrategia
{
    public class EstrategiaComponenteCabeceraModel
    {
        public string ContenidoNeto { get; set; }
        public string Dimensiones { get; set; }
        public string TallaMedidas { get; set; }
    }

    public class EstrategiaComponenteSeccionModel
    {
        public string Titulo { get; set; }
        public bool EsVideos { get; set; }
        public List<EstrategiaComponenteSeccionDetalleModel> Detalles { get; set; }
    }

    public class EstrategiaComponenteSeccionDetalleModel
    {
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string Key { get; set; }
    } 
}