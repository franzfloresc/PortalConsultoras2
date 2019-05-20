using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class FiltrosCaminoBrillanteModel
    {
        public List<FiltrosDatosCaminoBrillante> DatosFiltros { get; set; }
        public List<OrdenDatosCaminoBrillante> DatosOrden { get; set; }
    }

    public class FiltrosDatosCaminoBrillante
    {
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }

    public class OrdenDatosCaminoBrillante
    {
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
    }
}