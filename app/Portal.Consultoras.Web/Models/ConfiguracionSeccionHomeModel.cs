using System;
using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class ConfiguracionSeccionHomeModel
    {
        public ConfiguracionSeccionHomeModel()
        {
        }

        public string Codigo { get; set; }
        public int CampaniaID { get; set; }
        public string TipoPresentacion { get; set; }
        public int CantidadMostrar { get; set; }
        public string TipoEstrategia { get; set; }
        public string Titulo { get; set; }
        public string SubTitulo { get; set; }

    }
}