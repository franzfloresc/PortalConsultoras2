namespace Portal.Consultoras.Web.Models.Config.ResponseReporte
{
    using Portal.Consultoras.Web.Models.Config.Response;
    using Portal.Consultoras.Web.Models.Config.ResponseReporte.Estructura;
    using System.Collections.Generic;

    public class OutputReporteValidacion : ResponseStatus
    {
        public ReporteValidacion Result { get; set; }
    }
}