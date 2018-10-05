using Portal.Consultoras.Web.Models.Estrategia;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.Ofertas
{
    public class IndexViewModel
    {
        public EstrategiaPersonalizadaModel EstrategiaPersonalizada { get; set; }
        public string IconoLLuvia { get; set; }
        public VariablesGeneralEstrategiaModel VariablesEstrategia { get; set; }
    }
}